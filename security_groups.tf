# LB
module "lb_sg_name" {
  source        = "github.com/traveloka/terraform-aws-resource-naming?ref=v0.17.0"
  name_prefix   = local.lb_cluster_name
  resource_type = "security_group"
}

resource "aws_security_group" "lb_sg" {
  name        = module.lb_sg_name.name
  description = "Security group for ${local.lb_cluster_name}"

  vpc_id = var.vpc_id

  tags = {
    Name          = module.lb_sg_name.name
    Service       = local.service_name
    ProductDomain = local.product_domain
    Environment   = var.environment
    Description   = "Security group for ${local.lb_cluster_name}"
    ManagedBy     = "terraform"
  }
}

# APP
module "app_sg_name" {
  source        = "github.com/traveloka/terraform-aws-resource-naming?ref=v0.17.0"
  name_prefix   = local.app_cluster_name
  resource_type = "security_group"
}

resource "aws_security_group" "app_sg" {
  name        = module.app_sg_name.name
  description = "Security group for ${local.app_cluster_name}"

  vpc_id = var.vpc_id

  tags = {
    Name          = module.app_sg_name.name
    Service       = local.service_name
    ProductDomain = local.product_domain
    Environment   = var.environment
    Description   = "Security group for ${local.app_cluster_name}"
    ManagedBy     = "terraform"
  }
}

# SG egress rules -> app to 443
resource "aws_security_group_rule" "allow_egress_from_app_to_all_443" {
  type        = "egress"
  from_port   = local.secure_port
  to_port     = local.secure_port
  protocol    = "TCP"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.app_sg.id
}

# SG egress rules -> app to 80
resource "aws_security_group_rule" "allow_egress_from_app_to_all_80" {
  type        = "egress"
  from_port   = "80"
  to_port     = "80"
  protocol    = "TCP"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.app_sg.id
}

# SG egress rules -> lbint to app
resource "aws_security_group_rule" "allow_egress_from_lb_to_app" {
  type      = "egress"
  from_port = local.app_port
  to_port   = local.app_port
  protocol  = "TCP"

  source_security_group_id = aws_security_group.app_sg.id
  security_group_id        = aws_security_group.lb_sg.id
}

# SG ingress rules -> lbint to app
resource "aws_security_group_rule" "allow_ingress_from_lb_to_app" {
  type      = "ingress"
  from_port = local.app_port
  to_port   = local.app_port
  protocol  = "TCP"

  source_security_group_id = aws_security_group.lb_sg.id
  security_group_id        = aws_security_group.app_sg.id
}

# app to acdso

resource "aws_security_group_rule" "from_app_to_acdso_sg" {
  type                     = "egress"
  from_port                = local.secure_port
  to_port                  = local.secure_port
  protocol                 = "tcp"
  security_group_id        = aws_security_group.app_sg.id
  source_security_group_id = var.acdso_sg_id
  description              = "egress rule from app to acdso"
}

resource "aws_security_group_rule" "allow_acdso_from_app_sg" {
  type                     = "ingress"
  from_port                = local.secure_port
  to_port                  = local.secure_port
  protocol                 = "tcp"
  security_group_id        = var.acdso_sg_id
  source_security_group_id = aws_security_group.app_sg.id
  description              = "ingress rule from acdso to aprhd"
}

# app to acdcgeo
resource "aws_security_group_rule" "from_app_to_acdcgeo_sg" {
  type                     = "egress"
  from_port                = local.secure_port
  to_port                  = local.secure_port
  protocol                 = "tcp"
  security_group_id        = aws_security_group.app_sg.id
  source_security_group_id = var.acdcgeo_sg_id
  description              = "egress rule from acdzhd to acdcgeo"
}

resource "aws_security_group_rule" "allow_acdcgeo_from_app_sg" {
  type                     = "ingress"
  from_port                = local.secure_port
  to_port                  = local.secure_port
  protocol                 = "tcp"
  security_group_id        = var.acdcgeo_sg_id
  source_security_group_id = aws_security_group.app_sg.id
  description              = "ingress rule from acdzhd to acdcgeo"
}

