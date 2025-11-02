# Call the S3 module to create an S3 bucket
module "s3" {
  source      = "./modules/s3"
  bucket_name = var.bucket_name
  owner_name  = var.owner_name
  tags        = var.tags
}

# Call the CloudFront module to create a CloudFront distribution
module "cloudfront" {
  source            = "./modules/cloudfront"
  bucket_name       = module.s3.bucket_name
  bucket_domain_name = module.s3.bucket_domain_name
  owner_name        = var.owner_name
  tags              = var.tags
}

# Output the S3 bucket name and CloudFront domain name
output "s3_bucket_name" {
  value = module.s3.bucket_name
}

# Output the CloudFront domain name
output "cloudfront_domain_name" {
  value = module.cloudfront.cloudfront_domain_name
}
