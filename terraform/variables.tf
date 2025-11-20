variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "env" {
  description = "Deployment environment (dev|staging|prod)"
  type        = string
  default     = "dev"
}
