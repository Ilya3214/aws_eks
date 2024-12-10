output "id" {
  description = "ID of the Docker security group"
  value       = aws_security_group.docker_sg.id
}