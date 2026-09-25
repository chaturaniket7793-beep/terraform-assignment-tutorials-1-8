terraform {
  backend "s3" {
    bucket       = "chatur-terraform-s3-backend-demo-2026-001"
    key          = "tutorial-08/terraform.tfstate"
    region       = "ap-south-1"
    use_lockfile = true
  }
}