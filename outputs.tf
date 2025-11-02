# Output the S3 bucket name and CloudFront domain name
output "bucket_name" {
  value = module.s3.bucket_name
}

# Output the CloudFront distribution domain name
output "cloudfront_distribution_domain" {
  value = module.cloudfront.cloudfront_domain_name
}
