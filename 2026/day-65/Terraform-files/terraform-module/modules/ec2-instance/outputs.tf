output "instance_id" {
  description = "ID of the EC2 instance"
  value = aws_instance.my_aws_instance.id
}

output "public_ip" {
  description = "Public IP address of instance"
  value = aws_instance.my_aws_instance.public_ip
}

output "private_ip" {
  description = "Private IP address of instance"
  value = aws_instance.my_aws_instance.private_ip
}
