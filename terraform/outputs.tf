output "vpc_id" {
  value = aws_vpc.main.id
}

output "cluster_endpoint" {
  value = aws_eks_cluster.cluster.endpoint
}
