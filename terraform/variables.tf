
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
