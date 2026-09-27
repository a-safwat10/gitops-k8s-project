# This tells Terraform which provider to use and which AWS region
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS provider — region comes from our variable
provider "aws" {
  region = var.aws_region
}

# Create a VPC — this is your private network in AWS
# Think of it as buying a plot of land in the cloud
resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name    = "gitops-vpc"
    Project = "gitops-k8s-project"
  }
}

# Create a public subnet inside the VPC
# This is a section of your network that can reach the internet
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name    = "gitops-public-subnet"
    Project = "gitops-k8s-project"
  }
}

# Create an Internet Gateway
# This is the door between your VPC and the public internet
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name    = "gitops-igw"
    Project = "gitops-k8s-project"
  }
}
