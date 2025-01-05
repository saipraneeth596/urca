provider "aws" {
  region = var.aws_region
}

variable "aws_region" {
  description = "AWS region for deployment"
  default     = "us-east-1"
}

variable "twelve_data_api_key" {
  description = "API key for Twelve Data"
  type        = string
  default     = "5b461858dec54d978503f8318cd37392"
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

resource "aws_lambda_function" "flask_api" {
  function_name = "flask_api_function"
  runtime       = "python3.12"
  handler       = "app.lambda_handler"  # Ensure this matches your Flask app's handler
  role          = aws_iam_role.lambda_exec.arn

  filename         = "${path.module}/deployment-package.zip"
  source_code_hash = filebase64sha256("${path.module}/deployment-package.zip")

  environment {
    variables = {
      AWS_REGION            = var.aws_region
      TWELVE_DATA_API_KEY   = var.twelve_data_api_key
    }
  }
}

resource "aws_api_gateway_rest_api" "lambda_api" {
  name        = "lambda_api"
  description = "API Gateway for Flask-based Lambda"
}

resource "aws_api_gateway_resource" "lambda_proxy" {
  rest_api_id = aws_api_gateway_rest_api.lambda_api.id
  parent_id   = aws_api_gateway_rest_api.lambda_api.root_resource_id
  path_part   = "{proxy+}"
}

resource "aws_api_gateway_method" "proxy_method" {
  rest_api_id   = aws_api_gateway_rest_api.lambda_api.id
  resource_id   = aws_api_gateway_resource.lambda_proxy.id
  http_method   = "ANY"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "proxy_integration" {
  rest_api_id = aws_api_gateway_rest_api.lambda_api.id
  resource_id = aws_api_gateway_resource.lambda_proxy.id
  http_method = aws_api_gateway_method.proxy_method.http_method
  type        = "AWS_PROXY"
  integration_http_method = "POST"
  uri = aws_lambda_function.flask_api.invoke_arn
}

resource "aws_lambda_permission" "api_gateway" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.flask_api.arn
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_api_gateway_rest_api.lambda_api.execution_arn}/*/*"
}

resource "aws_api_gateway_deployment" "lambda_api_deployment" {
  rest_api_id = aws_api_gateway_rest_api.lambda_api.id
  depends_on = [aws_api_gateway_integration.proxy_integration]
}

resource "aws_api_gateway_stage" "prod" {
  deployment_id = aws_api_gateway_deployment.lambda_api_deployment.id
  rest_api_id   = aws_api_gateway_rest_api.lambda_api.id
  stage_name    = "prod"
}

output "api_gateway_url" {
  description = "Base URL for the API Gateway"
  value       = "${aws_api_gateway_rest_api.lambda_api.execution_arn}/prod"
}

output "lambda_role_arn" {
  value = aws_iam_role.lambda_exec.arn
}

output "lambda_function_url" {
  description = "URL for the Lambda function"
  value       = aws_lambda_function.flask_api.invoke_arn
}