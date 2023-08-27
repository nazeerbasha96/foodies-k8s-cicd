variable "cluster_name" {
  type = string
}
variable "cluster_version" {
  type = string
}

variable "subnet_id" {
    type = list(string)
}
variable "eks_iam_role_name" {
  type = string
}