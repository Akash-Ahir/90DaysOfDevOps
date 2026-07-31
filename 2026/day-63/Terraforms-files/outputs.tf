output "vpc_id" {
  description = "vpc id"
  value       = aws_vpc.my_vpc.id
}
output "subnet_id" {
  description = "subnet id"
  value       = aws_subnet.my_subnet.id
}
output "instance_id" {
  description = "ec2 instance id"
  value       = aws_instance.my_server.id
}
output "instance_public_ip" {
  description = "ec2 instance public ip"
  value       = aws_instance.my_server.public_ip
}
output "instance_public_dns" {
  description = "ec2 instance public dns"
  value       = aws_instance.my_server.public_dns
}
output "security_group_id" {
  description = "security group id"
  value       = aws_security_group.my_security_group.id
}
