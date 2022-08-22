module "fn_thumbor" {
    source = "./modules/functions/thumbor"

    container_image_uri = var.thumbor_image_uri

    bucket = aws_s3_bucket.site_bucket.id
    bucket_region = aws_s3_bucket.site_bucket.region

    photos_prefix = local.photos_prefix

    # The /*/* portion grants access from any method on any resource
    # within the API Gateway "REST API".
    api_gateway_exec_arn = "${aws_api_gateway_deployment.main.execution_arn}/*/*"
}
