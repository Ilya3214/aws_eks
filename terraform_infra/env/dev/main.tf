module "vpc" {
  source      = "../../modules/vpc"
  cidr_block  = "10.0.0.0/16"
  public_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  environment = var.environment
}
module "security_group" {
  source      = "../../modules/SG"
  name        = "docker-sg"
  description = "Allow inbound traffic for Docker"
  vpc_id      = module.vpc.vpc_id
  ports       = [22, 80, 8080, 443, 9000]
  cidr_blocks = ["0.0.0.0/0"]
  environment = var.environment
}

module "iam" {
  source = "../../modules/iam"
  environment = var.environment
}

# module "ec2" {
#   source             = "../../modules/ec2"
#   ami_id             = "ami-0c02fb55956c7d316" # Replace with your desired AMI ID
#   instance_type      = "t2.micro"
#   subnet_id          = module.vpc.public_subnet_ids[0] # Attach to an existing public subnet
#   security_group_id  = module.security_group.id        # Use an existing security group
#   key_name           = "linuxkey"                     # Specify the SSH key
#   associate_public_ip = true
#   iam_instance_profile = module.iam.ec2_instance_profile_name

#   tags = {
#     Environment = var.environment
#   }
#   environment = var.environment
# }

# module "ec2_1" {
#   source             = "../../modules/ec2"
#   ami_id             = "ami-0c02fb55956c7d316" # Replace with your desired AMI ID
#   instance_type      = "t2.micro"
#   subnet_id          = module.vpc.public_subnet_ids[0] # Attach to an existing public subnet
#   security_group_id  = module.security_group.id        # Use an existing security group
#   key_name           = "linuxkey"                     # Specify the SSH key
#   associate_public_ip = true
#   iam_instance_profile = module.iam.ec2_instance_profile_name

#   tags = {
#     Environment = var.environment
#   }
#   environment = var.environment
# }

module "sonarqube" {
  source             = "../../modules/sonarqube"
  ami_id             = "ami-0c02fb55956c7d316" # Replace with your desired AMI ID
  instance_type      = "t3.medium"
  subnet_id          = module.vpc.public_subnet_ids[0] # Attach to an existing public subnet
  security_group_id  = module.security_group.id        # Use an existing security group
  key_name           = "linuxkey"                     # Specify the SSH key
  associate_public_ip = true
  iam_instance_profile = module.iam.ec2_instance_profile_name

  tags = {
    Environment = var.environment
  }
  environment = var.environment
  
}