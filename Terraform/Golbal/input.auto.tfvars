Vpc_block = {
  vpc_name = "k8s_vpc"
  vpc_cidr = "10.0.0.0/16"
}
public_subnet_block = {
  public_cidr       = ["10.0.1.0/24", "10.0.2.0/24"]
  public_name       = "k8s_public_subnet"
  availability_zone = ["ap-south-1a", "ap-south-1b"]
}
ig_block = {
  k8s_ig_name = "k8s_ig"
  k8s_rt_name = "k8s_rt"
}


eks_cluster_name ="devops_eks"
eks_iam_role_name = "eks_iam_role"
