terraform {
    required_version = ">= 0.12"

    backend "s3" {
        # bucket = "…" ## partial
        # region = "…" ## partial
        key = "jekyll-site/terraform.tfstate"
    }
}
