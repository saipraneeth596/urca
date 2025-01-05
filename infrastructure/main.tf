provider "aws" {
  region = var.aws_region
}

variable "aws_region" {
  description = "AWS region for deployment"
  default     = "us-east-1"
}


resource "aws_iam_role" "lambda_exec" {
  name = "lambda_execution_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Effect    = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_policy_attach" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_lambda_function" "ca_api" {
  function_name = "flask_api_function"
  runtime       = "python3.12"
  handler       = "app.lambda_handler"  # Ensure this matches your Flask app's handler
  role          = aws_iam_role.lambda_exec.arn

  filename         = "${path.module}/deployment-package.zip"
  source_code_hash = filebase64sha256("${path.module}/deployment-package.zip")

  environment {
    variables = {
      AWS_REGION            = var.aws_region
    }
  }
}

output "lambda_role_arn" {
  value = aws_iam_role.lambda_exec.arn
}

output "lambda_function_url" {
  description = "URL for the Lambda function"
  value       = aws_lambda_function.flask_api.invoke_arn
}
