resource "aws_instance" "ec2_instance" {
  ami                         = var.ami_id              # AMI ID for the instance
  instance_type               = var.instance_type       # Instance type (e.g., t2.micro)
  subnet_id                   = var.subnet_id           # Attach to the existing subnet
  vpc_security_group_ids      = [var.security_group_id] # Use the existing security group
  associate_public_ip_address = var.associate_public_ip # Whether to associate a public IP
  iam_instance_profile        = var.iam_instance_profile

  key_name = var.key_name # SSH key for access

  user_data = <<-EOT
    #!/bin/bash
    set -e  # Exit immediately if a command exits with a non-zero status

    # Обновление репозиториев пакетов
    sudo yum update -y

    # Install Docker
    sudo yum install -y docker
    if ! command -v docker &> /dev/null; then
        echo "Error: Docker installation failed" >&2
        exit 1
    fi

    # Start Docker
    sudo systemctl start docker
    sudo systemctl enable docker
    if ! systemctl is-active --quiet docker; then
        echo "Error: Docker service failed to start" >&2
        exit 1
    fi

    # Install Nginx
    sudo amazon-linux-extras install nginx1
    if ! command -v nginx &> /dev/null; then
        echo "Error: Nginx installation failed" >&2
        exit 1
    fi

    # Start Nginx
    sudo systemctl start nginx
    sudo systemctl enable nginx
    if ! systemctl is-active --quiet nginx; then
        echo "Error: Nginx service failed to start" >&2
        exit 1
    fi

    # Add ec2-user to the Docker group
    sudo usermod -aG docker ec2-user

    echo "Docker and Nginx installation and setup completed successfully!"
  EOT

  tags = merge({
    Name = "${var.environment}-ec2-instance"
  }, var.tags)
}