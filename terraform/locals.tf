locals {
  aws_ecr_url = "${data.aws_caller_identity.current.account_id}.dkr.ecr.${var.region}.amazonaws.com"
}

locals {
  cluster_name = "boutique-eks-${random_string.suffix.result}"
}