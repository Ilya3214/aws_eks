terraform {
  backend "s3" {
    bucket         = "terraform-ilya3214-backend"
    key            = "terraform/tfstate/aws-eks-cluster-prod/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform_lock_table"
    encrypt        = true
  }
}