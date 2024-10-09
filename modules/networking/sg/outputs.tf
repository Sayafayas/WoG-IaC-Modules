output "all_worker_node_groups_sg_id" {
  description = "K8s Nodes SG"
  value       = aws_security_group.all_worker_node_groups.id
}

output "eks_control_plane_sg_id" {
  description = "Control Panel SG"
  value       = aws_security_group.eks_control_plane.id
}
