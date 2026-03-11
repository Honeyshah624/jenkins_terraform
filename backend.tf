terraform {
  backend "s3" {
    bucket       = "terraform-remote-state-workspace1"
    key          = "terraform-workspaces/terraform.tfstate"
    region       = "ap-south-1"
    encrypt      = true
    use_lockfile = true
  }
}