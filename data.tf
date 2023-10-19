data "aws_route53_zone" "selected" {
  zone_id = var.route53_private_zone_id
}

data "aws_caller_identity" "current" {
}

