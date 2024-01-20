resource "aws_iam_role" "eks-iam-role" {
  name = var.eks_iam_role_name

  path = "/"

  assume_role_policy = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
  {
   "Effect": "Allow",
   "Principal": {
    "Service": "eks.amazonaws.com"
   },
   "Action": "sts:AssumeRole"
  }
 ]
}
EOF

}
resource "aws_iam_role_policy_attachment" "AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks-iam-role.name
}
resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryReadOnly-EKS" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks-iam-role.name
}

resource "aws_eks_cluster" "eks_cluster" {
  name     = var.cluster_name
  role_arn = aws_iam_role.eks-iam-role.arn
  version  = var.cluster_version

  vpc_config {
    subnet_ids = [var.subnet_id[0], var.subnet_id[1]]
    endpoint_private_access = false
    endpoint_public_access = true

  }
  depends_on = [ aws_iam_role_policy_attachment.AmazonEKSClusterPolicy ]
}
resource "aws_eks_addon" "corerdns" {
  addon_name = "corerdns"
  cluster_name = aws_eks_cluster.eks_cluster.name
  addon_version = "v1.10.1-eksbuild.1"  
  resolve_conflicts_on_create = "OVERWRITE"
}
# resource "aws_eks_addon" "Vpc-CNI" {
#   addon_name = "vpc-cni"
#   cluster_name = aws_eks_cluster.eks_cluster.name
#   resolve_conflicts_on_create = "OVERWRITE"
# }
# resource "aws_eks_addon" "kube-proxy" {
#   addon_name = "kube-proxy"
#   cluster_name = aws_eks_cluster.eks_cluster.name
#   resolve_conflicts_on_create = "OVERWRITE"
# }