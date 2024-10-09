# Kubernetes worker node SG
resource "aws_security_group" "all_worker_node_groups" {
  name        = "${var.deployment_prefix}-for-all-node-groups-sg"
  vpc_id      = var.vpc_id
  description = "What does this rule enable"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    description = "Inbound traffic only from internal VPC"
    cidr_blocks = var.ssh_ingress_cidr_blocks
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["10.10.0.0/16"]
    description = "What does this rule enable"
  }

  tags = {
    "Name"        = "${var.deployment_prefix}-for-all-node-groups-sg"
    "Description" = "Inbound traffic only from internal VPC"
  }
}

#EKS Control Panel SG
resource "aws_security_group" "eks_control_plane" {
  name        = "${var.deployment_prefix}-eks-control-plane-sg"
  vpc_id      = var.vpc_id
  description = "Security group for EKS control plane"

  # Allow inbound traffic to the Kubernetes API (port 443)
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    description = "Allow inbound Kubernetes API access"
    cidr_blocks = var.control_plane_ingress_cidr_blocks  # Specify allowed CIDR blocks (e.g., office IPs or VPC CIDR)
  }

  # Allow all outbound traffic from the control plane
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]  # Allow outbound access to all destinations
    description = "Allow all outbound traffic"
  }

  tags = {
    "Name"        = "${var.deployment_prefix}-eks-control-plane-sg"
    "Description" = "Security group for Kubernetes control plane communication"
  }
}
