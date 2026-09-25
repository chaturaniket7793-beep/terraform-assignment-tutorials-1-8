provider "aws" {
  region = "ap-south-1"
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "terraform-learning-vpc"
  cidr = "10.0.0.0/16"

  azs = ["ap-south-1a"]

  private_subnets = [
    "10.0.2.0/24"
  ]

  public_subnets = [
    "10.0.1.0/24"
  ]

  enable_nat_gateway = false
  enable_vpn_gateway = false
  create_igw         = false

  tags = {
    Terraform   = "true"
    Environment = "devops"
  }
}

resource "aws_instance" "app_server" {
  ami           = "ami-006f82a1d5a27da54"
  instance_type = "t2.nano"

  subnet_id = module.vpc.public_subnets[0]

  tags = {
    Name        = "terraform-learning"
    Environment = "devops"
  }
}