# ASG
module "app_asg" {
  source = "github.com/traveloka/terraform-aws-autoscaling?ref=v0.3.8"

  service_name   = local.service_name
  environment    = var.environment
  product_domain = local.product_domain
  description    = "autoscaling group for ${local.lb_cluster_name}"
  application    = "java-8"

  security_groups       = [aws_security_group.app_sg.id]
  instance_profile_name = module.iam_role.instance_profile_name

  image_owners = [var.image_owner]

  image_filters = [
    {
      name   = "image-id"
      values = [var.image_id]
    },
  ]

  launch_template_overrides = var.launch_template_overrides

  mixed_instances_distribution = var.mixed_instances_distribution

  user_data                     = var.user_data
  asg_min_capacity              = var.asg_min_capacity
  asg_max_capacity              = var.asg_max_capacity
  asg_desired_capacity          = var.asg_desired_capacity
  asg_vpc_zone_identifier       = var.asg_vpc_zone_identifier
  asg_lb_target_group_arns      = [module.lbint.tg_arn]
  asg_health_check_type         = local.asg_health_check_type
  asg_wait_for_capacity_timeout = local.asg_wait_for_capacity_timeout

  asg_tags = concat([
    {
      key                 = "AmiId"
      value               = var.image_id
      propagate_at_launch = true
    },
    var.datadog_monitoring],
    var.asg_tags)
}

