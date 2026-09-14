resource "aws_eks_cluster" "main_eks" {
  name = var.cluster_name

  access_config {
    authentication_mode                         = "API"
    bootstrap_cluster_creator_admin_permissions = true
  }

  role_arn = aws_iam_role.cluster.arn
  version  = var.cluster_version

  vpc_config {
    endpoint_private_access = true
    endpoint_public_access  = true
    subnet_ids              = var.cluster_subnet_ids
  }

  bootstrap_self_managed_addons = false

  # Ensure that IAM Role permissions are created before and deleted
  # after EKS Cluster handling. Otherwise, EKS will not be able to
  # properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    aws_iam_role_policy_attachment.cluster_AmazonEKSClusterPolicy,
  ]

  upgrade_policy {
    support_type = "STANDARD"
  }


  tags = {
    Name        = "${var.env}-${var.cluster_name}"
    Environment = var.env
  }

}

# OIDC

resource "aws_iam_openid_connect_provider" "eks" {
  url = aws_eks_cluster.main_eks.identity[0].oidc[0].issuer

  client_id_list = [
    "sts.amazonaws.com"
  ]

  tags = {
    Name        = "${var.env}-eks-oidc"
    Environment = var.env
  }

}

# AWS Policy for the Cluster

resource "aws_iam_role" "cluster" {
  name = "eks-cluster-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "sts:AssumeRole",
          "sts:TagSession"
        ]
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "cluster_AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.cluster.name
}

# AWS Fargate Profile

resource "aws_eks_fargate_profile" "main_fargate" {
  cluster_name           = aws_eks_cluster.main_eks.name
  fargate_profile_name   = var.fargate_profile_name
  pod_execution_role_arn = aws_iam_role.fargate_profile_role.arn
  subnet_ids             = var.fargate_profile_subnet_ids

  dynamic "selector" {
    for_each = var.namespace

    content {
      namespace = selector.value
    }
  }

  depends_on = [aws_iam_role_policy_attachment.example-AmazonEKSFargatePodExecutionRolePolicy]
}

# AWS Policy for the Fargate Profile

resource "aws_iam_role" "fargate_profile_role" {
  name = "eks-fargate-profile-role"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "eks-fargate-pods.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "example-AmazonEKSFargatePodExecutionRolePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSFargatePodExecutionRolePolicy"
  role       = aws_iam_role.fargate_profile_role.name
}

# AWS Addon

resource "aws_eks_addon" "example" {
  cluster_name = aws_eks_cluster.main_eks.name
  addon_name   = "coredns"

  depends_on = [aws_eks_fargate_profile.main_fargate]
}
