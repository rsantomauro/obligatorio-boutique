module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "~> 18.0"
  cluster_name    = local.cluster_name
  cluster_version = "1.22"

  # cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = true

  vpc_id      = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

/*
  eks_managed_node_group_defaults = {
    disk_size      = 20
    instance_types = ["t2.small"]
  }

  eks_managed_node_groups = {
    boutique-node = {
      min_size     = 2
      max_size     = 3
      desired_size = 2

      instance_types = ["t2.small"]
      capacity_type  = "SPOT"
    }
  }
*/
  create_iam_role = false
  iam_role_name = "LabRole"
  iam_role_use_name_prefix = "true"
  iam_role_arn    = "arn:aws:iam::320466714090:role/LabRole"


  enable_irsa = "false"
  attach_cluster_encryption_policy = "false"
}

