terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "6.0"
    }
  }

    backend "s3" {
      bucket = "84s-state-bucket"
      key = "vpc-test-demo"
      region = "us-east-1"
      use_lockfile = true
      encrypt = true
    }

}

provider "aws" {
  region = "us-east-1"
}
