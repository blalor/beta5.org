variable "bucket" {
    type = string
    description = "bucket where deployment package and images are stored"
}

variable "bucket_region" {
    type = string
    description = "the region where the bucket resides"
}

variable "container_image_uri" {
    type = string
    description = "ECR container image URI"
}

variable "photos_prefix" {
    type = string
    description = "prefix in bucket where images are stored"
}

variable "api_gateway_exec_arn" {
    type = string
    description = "full execution arn for the api gateway"
}

locals {
    fn_name = "thumbor"
}
