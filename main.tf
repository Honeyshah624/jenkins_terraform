resource "aws_s3_bucket" "terraform-remote-state-workspace1" {

  bucket = "terraform-remote-state-workspace1-${terraform.workspace}"

  tags = {
    ResourceOwner    = "Honey shah"
    CreateDate       = "11-March-2026"
    BusinessUnit     = "eInfochips"
    SubBusinessUnit  = "PES-IA"
    ProjectName      = "Testing and Learning"
    DeliveryManager  = "Shahid Raza"
  }
}


resource "aws_s3_bucket_versioning" "terraform-remote-state-workspace1_versioning" {

  bucket = aws_s3_bucket.terraform-remote-state-workspace1.id

  versioning_configuration {
    status = "Enabled"
  }
}