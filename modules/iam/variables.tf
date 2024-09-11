variable "role_name" {
  description = "The name of the IAM role"
  type        = string
}

variable "sso_role_arn" {
  description = "The ARN of the SSO role that can assume this role"
  type        = string
}
