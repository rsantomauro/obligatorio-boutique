module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "~> 18.0"
  cluster_name    = local.cluster_name
  cluster_version = "1.22"

  cluster_endpoint_private_access = true
  # cluster_endpoint_public_access  = true

  /* 
  cluster_addons = {
    coredns = {
      resolve_conflicts = "OVERWRITE"
    }
    kube-proxy = {}
    vpc-cni = {
      resolve_conflicts = "OVERWRITE"
    }
  } */

  vpc_id      = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  eks_managed_node_group_defaults = {
    disk_size      = 20
    instance_types = ["t2.small"]
  }

  # EKS Managed Node Group(s)
  eks_managed_node_groups = {
    blue = {}
    green = {
      min_size     = 1
      max_size     = 10
      desired_size = 1

      instance_types = ["t2.small"]
      capacity_type  = "SPOT"
    }
  }

  create_iam_role = "false"
  iam_role_arn    = "arn:aws:iam::320466714090:role/LabRole"
}