# Variables are like parameters — they make your code reusable
# Instead of hardcoding "us-east-1" everywhere, we define it once here
# and reference it as var.aws_region anywhere in our code

variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Name tag applied to all resources — makes them easy to find in AWS console"
  type        = string
  default     = "gitops-k8s-project"
}
