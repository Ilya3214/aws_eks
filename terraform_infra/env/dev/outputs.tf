# output "vpc_id" {
#   value = aws_vpc.main.id
# }

# output "public_subnet_ids" {
#   value = aws_subnet.public[*].id
# }
# output "security_group_id" {
#   description = "ID of the Security Group"
#   value       = aws_security_group.docker_sg.id
# }


# output "ec2_public_ip" {
#   value = module.ec2.public_ip
# }

output "sonarqube_public_ip" {
  value = module.sonarqube.public_ip
}