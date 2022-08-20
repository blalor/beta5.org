terraform {
    required_version = ">= 1.2.7"

    backend "s3" {
        # bucket = "…" ## partial
        # region = "…" ## partial
        key = "jekyll-site/terraform.tfstate"
    }

    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~> 4.27"
        }

        random = {
            source = "hashicorp/random"
            version = "~> 3.3"
        }
    }
}
