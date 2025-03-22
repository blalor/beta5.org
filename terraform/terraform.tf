terraform {
    required_version = ">= 1.11.2"

    backend "s3" {
        # bucket = "…" ## partial
        # region = "…" ## partial
        key = "jekyll-site/terraform.tfstate"
    }

    required_providers {
        aws = {
            source = "hashicorp/aws"

            ## see "NOTE on S3 Bucket Website Configuration" in 4.9 and greater
            ## also
            #> The website argument is read-only as of version 4.0 of the
            #> Terraform AWS Provider. See the
            #> aws_s3_bucket_website_configuration resource for configuration
            #> details.

            version = "< 4.0"
        }

        random = {
            source = "hashicorp/random"
            version = "~> 3.3"
        }
    }
}
