variable "deployment_prefix" {
  description = "Prefix of the deployment"
  type        = string
}

variable "vpc_id" {
  description = "AWS VPC ID"
  type        = string
}

variable "ssh_ingress_cidr_blocks" {
  description = "Allowed CIDR blocks for the SSH for the worker K8s Nodes."
  type        = list(string)
}

variable "control_plane_ingress_cidr_blocks" {
  description = "Allowed CIDR blocks for communication with Control Panel."
  type        = list(string)
}
