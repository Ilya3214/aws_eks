variable "name" {
  description = "Name of the security group"
  type        = string
}

variable "description" {
  description = "Description of the security group"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC where the security group will be created"
  type        = string
}

variable "ports" {
  description = "List of ports to allow inbound traffic"
  type        = list(number)
  default     = [22, 80, 443] # SSH, HTTP, HTTPS by default
}

variable "cidr_blocks" {
  description = "Allowed CIDR blocks for ingress"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "environment" {
  type        = string
  description = "Environment (dev, prod, etc.)"
}