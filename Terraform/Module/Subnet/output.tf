output "public_id" {
    value = aws_subnet.k8s_public_subnet.id
  
}
output "public_ip" {
    value = aws_subnet.k8s_public_subnet.cidr_block
  
}