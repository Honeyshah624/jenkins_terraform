output "workspace_name" {
  value = terraform.workspace
}

output "bucket_name" {
  value = aws_s3_bucket.terraform-remote-state-workspace2
}

output "bucket_arn" {
  value = aws_s3_bucket.terraform-remote-state-workspace2.arn
}