variable "aws_region" {
  description = "AWS region for deployment"
  type        = string
  default     = "us-east-1"
}

variable "twelve_data_api_key" {
  description = "API key for Twelve Data"
  type        = string
  default     = "5b461858dec54d978503f8318cd37392"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "Dev"
}