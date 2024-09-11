resource "aws_iam_role" "example" {
  name = var.role_name
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          AWS = var.sso_role_arn
        }
      }
    ]
  })
}

resource "aws_iam_policy" "eks_create_cluster_policy" {
  name = "${var.role_name}-eks-create-cluster-policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = "eks:CreateCluster"
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "eks_create_cluster_attachment" {
  role       = aws_iam_role.example.name
  policy_arn = aws_iam_policy.eks_create_cluster_policy.arn
}
