# IAM Role
module "iam_role" {
  source         = "github.com/traveloka/terraform-aws-iam-role.git//modules/instance?ref=v1.0.2"
  environment    = var.environment
  product_domain = local.product_domain
  service_name   = local.service_name
  cluster_role   = local.app_cluster_role
}

resource "aws_iam_role_policy_attachment" "commonEC2" {
  role       = module.iam_role.role_name
  policy_arn = var.commonec2_policy_arn
}

resource "aws_iam_role_policy_attachment" "ssm_policy" {
  role       = module.iam_role.role_name
  policy_arn = var.ssm_policy_arn
}

# IAM Policies
resource "aws_iam_role_policy" "app_policy" {
  name   = "${local.service_name}-app-policy"
  role   = module.iam_role.role_name
  policy = data.aws_iam_policy_document.app.json
}

data "aws_iam_policy_document" "app" {
  statement {
    effect = "Allow"

    actions = [
      "ssm:GetParameter",
      "ssm:GetParameterHistory",
      "ssm:GetParameters",
      "ssm:GetParametersByPath",
    ]

    resources = [
      "arn:aws:ssm:*:${data.aws_caller_identity.current.account_id}:parameter/tvlk-secret/${local.service_name}/*",
    ]
  }
}

