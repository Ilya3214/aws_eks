resource "aws_instance" "sonarqube_instance" {
  ami                         = var.ami_id              # AMI ID for the instance
  instance_type               = var.instance_type       # Instance type (e.g., t2.micro)
  subnet_id                   = var.subnet_id           # Attach to the existing subnet
  vpc_security_group_ids      = [var.security_group_id] # Use the existing security group
  associate_public_ip_address = var.associate_public_ip # Whether to associate a public IP
  iam_instance_profile        = var.iam_instance_profile

  key_name = var.key_name # SSH key for access

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install docker -y
              systemctl start docker
              systemctl enable docker
              docker pull sonarqube:latest
              docker run -d --name sonarqube -p 9000:9000 sonarqube:latest
              EOF

  tags = merge({
    Name = "${var.environment}-sonarqube"
  }, var.tags)
}