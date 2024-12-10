resource "aws_security_group" "docker_sg" {
  name        = var.name
  description = var.description
  vpc_id      = var.vpc_id

  # Dynamic ingress rules for multiple ports
  dynamic "ingress" {
    for_each = var.ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = var.cidr_blocks
    }
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.environment}-SG"
    Environment = var.environment
  }
}