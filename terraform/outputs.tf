# terraform/outputs.tf

output "cluster_endpoint" {
  description = "Endpoint for EKS cluster."
  value       = module.eks.cluster_endpoint
}

output "kubeconfig_command" {
  description = "Command to run to update your kubeconfig"
  value       = "aws eks update-kubeconfig --region ${var.aws_region} --name ${var.cluster_name}"
}