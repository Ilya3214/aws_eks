module "vpc" {
  source      = "../../modules/vpc"
  cidr_block  = "10.0.0.0/16"
  public_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  environment = var.environment
}

module "iam" {
  source      = "../../modules/iam"
  environment = var.environment
}