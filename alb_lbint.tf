# ALB
module "lbint" {
  source = "github.com/traveloka/terraform-aws-alb-single-listener?ref=v0.4.2"

  service_name   = local.service_name
  environment    = var.environment
  product_domain = local.product_domain
  description    = "Application Load Balancer for ${local.app_cluster_name}"

  vpc_id                   = var.vpc_id
  lb_subnet_ids            = var.lb_subnet_ids
  lb_security_groups       = [aws_security_group.lb_sg.id]
  listener_certificate_arn = var.listener_certificate_arn
  lb_logs_s3_bucket_name   = var.lb_logs_s3_bucket_name
  cluster_role             = local.app_cluster_role

  tg_port         = local.app_port
  tg_health_check = merge(local.lb_tg_health_check, var.lb_tg_health_check)
}

# Route53 private zone
resource "aws_route53_record" "lbint_record" {
  zone_id = var.route53_private_zone_id
  name    = "${local.lb_route53_record_name}.${data.aws_route53_zone.selected.name}"
  type    = "A"

  alias {
    name                   = lower(module.lbint.lb_dns)
    zone_id                = module.lbint.lb_zone_id
    evaluate_target_health = false
  }
}

