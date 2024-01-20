resource "aws_subnet" "k8s_public_subnet" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.public_cidr
  availability_zone       = var.availability_zone
  map_public_ip_on_launch = true
  tags = {
    "Name" = var.public_name
  }

}
