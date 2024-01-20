resource "aws_internet_gateway" "k8s_ig" {
    vpc_id = var.vpc_id
    tags = {
        "Name" = var.k8s_ig_name
    }
  
}
resource "aws_route_table" "k8s_rt" {
    vpc_id = var.vpc_id
    route  {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.k8s_ig.id
    }
  tags = {
    "Name" = var.k8s_rt_name

  }
}
resource "aws_route_table_association" "k8s_rt_asscote" {
    count = length(var.public_id)
    route_table_id = aws_route_table.k8s_rt.id
    subnet_id = element(var.public_id, count.index)

  
}