terraform {
  required_version = ">= 1.2.0"

  backend "s3" {
    bucket         = "tf-state"
    key            = "global/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "tf-lock"
    encrypt        = true
  }
}
