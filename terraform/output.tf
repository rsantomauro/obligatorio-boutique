output "cluster_name" {
  description = "Kubernetes Cluster Name"
  value       = local.cluster_name
}

output "cluster_id" {
  description = "EKS cluster ID"
  value       = module.eks.cluster_id
}

output "cluster_endpoint" {
  description = "Endpoint for EKS control plane"
  value       = module.eks.cluster_endpoint
}

output "ecr_name" {
  description = "ECR url, can be use to fullfill the yaml k8s deployment image and tag"
  value       = aws_ecr_repository.boutique_ecr.repository_url
}