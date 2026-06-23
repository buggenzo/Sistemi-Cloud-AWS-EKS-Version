output "rds_endpoint" {
  value       = split(":", aws_db_instance.postgres.endpoint)[0]
  description = "Indirizzo dell'RDS PostgreSQL"
}

output "eks_cluster_endpoint" {
  value       = aws_eks_cluster.eks_cluster.endpoint
  description = "Endpoint del Control Plane di EKS"
}

output "eks_cluster_name" {
  value       = aws_eks_cluster.eks_cluster.name
  description = "Nome del cluster EKS"
}

output "kubeconfig_command" {
  value       = "aws eks update-kubeconfig --region us-east-1 --name ${aws_eks_cluster.eks_cluster.name}"
  description = "Comando per configurare kubectl in locale"
}