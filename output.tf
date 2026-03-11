output "workspace_name" {
  value = terraform.workspace
}

output "bucket_name" {
  value = aws_s3_bucket.terraform-remote-state-workspace1.id
}

output "bucket_arn" {
  value = aws_s3_bucket.terraform-remote-state-workspace1.arn
}