# resource "aws_s3_bucket" "qa_bucket" {
#   bucket = "qa-environment-bucket"
#   acl    = "private"

#   tags = {
#     Environment = "QA"
#   }
# }

# resource "aws_iam_role" "qa_lambda_exec" {
#   name = "qa_lambda_execution_role"

#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Action    = "sts:AssumeRole"
#         Principal = {
#           Service = "lambda.amazonaws.com"
#         }
#         Effect    = "Allow"
#         Sid       = ""
#       }
#     ]
#   })
# }