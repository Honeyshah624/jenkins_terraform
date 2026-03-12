terraform {
  backend "s3" {
    bucket       = "terraform-remote-state-workspace2"
    key          = "terraform/terraform.tfstate"
    region       = "ap-south-1"
    encrypt      = true
    use_lockfile = true
  }
}