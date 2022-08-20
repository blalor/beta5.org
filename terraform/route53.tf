data "aws_route53_zone" "main" {
    name = var.site_name
    private_zone = false
}

resource "aws_route53_record" "cert_validation" {
    zone_id = data.aws_route53_zone.main.zone_id

    for_each = {
        for dvo in aws_acm_certificate.main.domain_validation_options : dvo.domain_name => {
            name   = dvo.resource_record_name
            record = dvo.resource_record_value
            type   = dvo.resource_record_type
        }
    }

    allow_overwrite = true
    name            = each.value.name
    records         = [ each.value.record ]
    ttl             = 60
    type            = each.value.type
}

resource "aws_route53_record" "site" {
    zone_id = data.aws_route53_zone.main.zone_id

    name = var.site_name
    type = "A"

    alias {
        zone_id = aws_cloudfront_distribution.main.hosted_zone_id
        name    = aws_cloudfront_distribution.main.domain_name
        evaluate_target_health = false
    }
}

## https://docs.aws.amazon.com/ses/latest/DeveloperGuide/dns-txt-records.html
resource "aws_route53_record" "pbe_verification" {
    zone_id = data.aws_route53_zone.main.zone_id
    name = "_amazonses.${aws_ses_domain_identity.pbe.domain}"
    type = "TXT"
    ttl = "60"
    records = [
        aws_ses_domain_identity.pbe.verification_token,
    ]
}

resource "aws_route53_record" "pbe_dkim" {
    count = 3

    zone_id = data.aws_route53_zone.main.zone_id
    name = "${element(aws_ses_domain_dkim.pbe.dkim_tokens, count.index)}._domainkey.${aws_ses_domain_identity.pbe.domain}"
    type = "CNAME"
    ttl = "60"
    records = [
        "${element(aws_ses_domain_dkim.pbe.dkim_tokens, count.index)}.dkim.amazonses.com",
    ]
}

resource "aws_route53_record" "pbe_mx" {
    zone_id = data.aws_route53_zone.main.zone_id

    name = aws_ses_domain_identity.pbe.domain
    type = "MX"
    records = [
        "10 inbound-smtp.${var.aws_region}.amazonaws.com",
    ]

    ttl = "60"
}

resource "aws_route53_record" "keybase_proof" {
    zone_id = data.aws_route53_zone.main.zone_id
    name = "_keybase.${var.site_name}"
    type = "TXT"
    ttl = "60"
    records = [
        "keybase-site-verification=PAZ7Vv-DG1Zz00W2qBO9A4iEC5ZlsimjZLirwOOEG-E",
    ]
}
