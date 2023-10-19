variable "environment" {
  type        = string
  description = "The environment this stack belongs to"
}

variable "vpc_id" {
  type        = string
  description = "The ID of the VPC this stack belongs to"
}

variable "lb_subnet_ids" {
  type        = list(string)
  description = "The list of subnet IDs to attach to the LB"
}

variable "listener_certificate_arn" {
  type        = string
  description = "The ARN of certificate to attach to the LB"
}

variable "lb_logs_s3_bucket_name" {
  type        = string
  description = "The S3 bucket where the LB access logs will be stored"
}

variable "lb_route53_record_name" {
  type        = string
  default     = ""
  description = "The name of Route 53 record pointing to the LB. The default is the service_name"
}

variable "route53_private_zone_id" {
  type        = string
  description = "The ID of Route 53 private zone"
}

variable "commonec2_policy_arn" {
  type        = string
  description = "Common EC2 Policy ARN"
}

variable "ssm_policy_arn" {
  type        = string
  description = "SSM access policy arn to attach to instance profile of asg."
}

variable "image_owner" {
  type        = string
  description = "The owner of the AMI ID"
}

variable "image_id" {
  type        = string
  description = "The AMI ID to spawn ASG instances from"
}

variable "launch_template_overrides" {
  type        = list
  description = "The list of launch template overrides"
}

variable "user_data" {
  type        = string
  description = "The user data to be passed to the launch template"
}

variable "asg_min_capacity" {
  type        = string
  description = "Minimum ASG capacity"
}

variable "asg_desired_capacity" {
  type        = string
  description = "Desired ASG capacity"
}

variable "asg_max_capacity" {
  type        = string
  description = "Maximum ASG capacity"
}

variable "asg_vpc_zone_identifier" {
  type        = list(string)
  description = "The list of subnet ids to spawn ASG instances to"
}

variable "lb_tg_health_check" {
  type        = map(string)
  default     = {}
  description = "The ALB target group's health check configuration, will be merged over the default on locals.tf"
}

variable "datadog_monitoring" {
  type        = map(string)
  default     = {}
  description = "The datadog monitoring configuration"
}

variable "mixed_instances_distribution" {
  type        = map(string)
  description = "Specify the distribution of on-demand instances and spot instances. See https://docs.aws.amazon.com/autoscaling/ec2/APIReference/API_InstancesDistribution.html"

  default = {
    on_demand_allocation_strategy            = "prioritized"
    on_demand_base_capacity                  = "0"
    on_demand_percentage_above_base_capacity = "100"
    spot_allocation_strategy                 = "lowest-price"
    spot_instance_pools                      = "2"
    spot_max_price                           = ""
  }
}

variable "asg_tags" {
  type        = list(string)
  description = "The list of tags to be attached to the ASG"
  default     = []
}

variable "acdso_sg_id" {
  type        = string
  description = "acdso sg id"
}

variable "acdcgeo_sg_id" {
  type        = string
  description = "acdcgeo sg id"
}

