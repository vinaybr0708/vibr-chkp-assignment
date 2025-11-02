output "bucket_name" {
  value = aws_s3_bucket.vibrs3.bucket
}

output "bucket_domain_name" {
  value = aws_s3_bucket.vibrs3.bucket_regional_domain_name
}
