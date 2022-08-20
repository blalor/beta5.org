provider "aws" {
    version = "~> 2.34"
    region  = var.aws_region
}

provider "aws" {
    alias = "us-east-1"

    version = "~> 2.34"
    region  = "us-east-1"
}

provider "random" {
    version = "~> 2.0"
}
