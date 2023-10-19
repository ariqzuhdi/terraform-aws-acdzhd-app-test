locals {
  service_name   = "acdzhd"
  product_domain = "acd"

  lb_cluster_role = "lbint"
  lb_cluster_name = "${local.service_name}-${local.lb_cluster_role}"

  lb_tg_health_check = {
    port = local.app_port
  }

  lb_route53_record_name = var.lb_route53_record_name == "" ? local.service_name : var.lb_route53_record_name

  app_cluster_role = "app"
  app_cluster_name = "${local.service_name}-${local.app_cluster_role}"

  app_port    = 61102
  secure_port = 443

  asg_health_check_type         = "ELB"
  asg_wait_for_capacity_timeout = "7m"
}

