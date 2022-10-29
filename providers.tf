terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.36.1"
    }
  }
}

provider "aws" {
  region                   = "us-east-1"
  shared_config_files      = ["$HOME\\.aws\\config"]
  shared_credentials_files = ["$HOME\\.aws\\credentials"]
}