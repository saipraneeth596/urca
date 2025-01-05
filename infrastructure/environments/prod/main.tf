# resource "aws_s3_bucket" "prod_bucket" {
#   bucket = "my-prod-bucket-${var.environment}"
#   acl    = "private"

#   tags = {
#     Environment = var.environment
#     Project     = "MyProject"
#   }
# }

# resource "aws_iam_role" "prod_lambda_exec" {
#   name = "prod_lambda_execution_role"

#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Effect = "Allow"
#         Principal = {
#           Service = "lambda.amazonaws.com"
#         }
#         Action = "sts:AssumeRole"
#       }
#     ]
#   })
# }

# resource "aws_lambda_function" "prod_lambda" {
#   function_name = "prod_lambda_function"
#   role          = aws_iam_role.prod_lambda_exec.arn
#   handler       = "index.handler"
#   runtime       = "nodejs14.x"
#   s3_bucket     = aws_s3_bucket.prod_bucket.bucket
#   s3_key        = "lambda/prod_lambda.zip"
# }