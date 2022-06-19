module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.2.0"

  name                 = "boutique_vpc"
  cidr                 = "${var.cidr_block}0.0/16"
  azs                  = data.aws_availability_zones.available.names
  private_subnets      = ["${var.cidr_block}1.0/24", "${var.cidr_block}2.0/24"]
  public_subnets       = ["${var.cidr_block}10.0/24", "${var.cidr_block}11.0/24"]
  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true

  tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
  }

  public_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                      = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"             = "1"
  }
}