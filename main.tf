locals {
  retool_image = "tryretool/backend:${var.retool_version}"
}

data "aws_caller_identity" "current" {}

data "aws_subnets" "subnets" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
}