resource "aws_iam_role" "eks_cluster_iam" {
      name = "${var.cluster_name}-cluster-role"
      assume_role_policy = jsonencode({
      Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
      Service = "eks.amazonaws.com"
       }
      }]
       Version = "2012-10-17"
      })
}

resource "aws_iam_policy_attachment" "eks_cluster_policy_attachment_1" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role = aws_iam_role.eks_cluster.name
}

resource "aws_eks_cluster" "eks_cluster" {

  
}