terraform {
    required_version = ">= 0.13"

    backend "s3" {
        # bucket = "…" ## partial
        # region = "…" ## partial
        key = "jekyll-site/terraform.tfstate"
    }

    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~> 2.34"
        }

        random = {
            source = "hashicorp/random"
            version = "~> 2.0"
        }
    }
}
