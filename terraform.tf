terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.56"
    }
  }

  required_version = ">= 1.15.0"
}

provider "aws" {
  region = var.region

  default_tags {
    tags = {
      Project   = "ssm-lab"
      Owner     = "panduhimal"
      Env       = var.environment
      ManagedBy = "terraform"
    }
  }
}
