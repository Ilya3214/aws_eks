output "instance_id" {
  description = "ID of the created EC2 instance"
  value       = aws_instance.sonarqube_instance.id
}

output "public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.sonarqube_instance.public_ip
}

output "private_ip" {
  description = "Private IP address of the EC2 instance"
  value       = aws_instance.sonarqube_instance.private_ip
}