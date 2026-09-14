output "cluster_id" {
  value = aws_eks_cluster.main_eks.id
}


output "cluster_arn" {
  value = aws_eks_cluster.main_eks.arn
}

output "fargate_profile_id" {
  value = aws_eks_fargate_profile.main_fargate.id
}
