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
  shared_config_files      = ["C:\\Users\\jty21\\.aws\\config"]
  shared_credentials_files = ["C:\\Users\\jty21\\.aws\\credentials"]
}