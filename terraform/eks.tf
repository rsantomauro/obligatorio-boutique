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

  create_iam_role = "false"
  iam_role_arn    = "arn:aws:iam::320466714090:role/LabRole"

  enable_irsa = "false"
  attach_cluster_encryption_policy = "false"
  iam_role_use_name_prefix = "false"
}