provider "aws" {
  region = "ap-south-1"
}

# -------------------------
# VPC
# -------------------------
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
  create_igw         = true

  tags = {
    Terraform   = "true"
    Environment = "devops"
  }
}

# -------------------------
# Security Group
# -------------------------
resource "aws_security_group" "example" {
  name        = "example"
  description = "Example security group"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
    description = "HTTPS from internal VPC"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Environment = "devops"
  }
}

# -------------------------
# EC2 Instance
# -------------------------

resource "aws_instance" "app_server" {
  ami           = "ami-006f82a1d5a27da54"
  instance_type = var.instance_type

  subnet_id = module.vpc.public_subnets[0]

  vpc_security_group_ids = [
    aws_security_group.example.id
  ]

  tags = {
    Name        = var.instance_hostname
    Environment = "devops"
  }
}
