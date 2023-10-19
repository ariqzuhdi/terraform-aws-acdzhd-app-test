output "lb_security_group_id" {
  description = "The ID of LB security group"
  value       = aws_security_group.lb_sg.id
}

output "lb_cluster_name" {
  description = "The cluister name of LB"
  value       = local.lb_cluster_name
}

output "app_instance_profile_arn" {
  description = "The ARN of application instance profile"
  value       = module.iam_role.instance_profile_arn
}

output "app_instance_profile_name" {
  description = "The name of application instance profile"
  value       = module.iam_role.instance_profile_name
}

output "app_security_group_id" {
  description = "The ID of application security group"
  value       = aws_security_group.app_sg.id
}

output "app_role_arn" {
  description = "The ARN of application role"
  value       = module.iam_role.role_arn
}

output "app_role_id" {
  description = "The ARN of application role"
  value       = module.iam_role.role_unique_id
}

output "app_role_name" {
  description = "The ARN of application role"
  value       = module.iam_role.role_name
}

output "lb_target_group_arn" {
  description = "The lbint target group for the application"
  value       = module.lbint.tg_arn
}

output "asg_health_check_type" {
  description = "The asg health check type"
  value       = local.asg_health_check_type
}

output "asg_wait_for_capacity_timeout" {
  description = "The asg wait for capacity timeout"
  value       = local.asg_wait_for_capacity_timeout
}

output "asg_name" {
  description = "The asg name"
  value       = module.app_asg.asg_name
}

output "lb_target_group_name" {
  description = "The lbint target group name for the application"
  value       = module.lbint.tg_name
}

output "launch_template_name" {
  description = "The name of the launch template used by the auto scaling group"
  value       = module.app_asg.launch_template_name
}

