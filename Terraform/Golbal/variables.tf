variable "Vpc_block" {
    type = object({
      vpc_cidr = string
      vpc_name = string
    })
  
}
variable "public_subnet_block" {
    type = object({
      public_cidr = list(any)
      public_name= string
      availability_zone =list(any)
    })
  
}
variable "ig_block" {
  type = object({
    k8s_ig_name = string
    k8s_rt_name = string
  })
  
}
variable "eks_cluster_name" {
  type = string
}

variable "eks_iam_role_name" {
  type = string
}
