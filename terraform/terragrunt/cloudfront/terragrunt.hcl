terraform {
  source = "../modules/cloudfront"
}

include "root" {
  path = find_in_parent_folders("root.hcl")
}

# Reference the S3 module as a dependency
dependency "s3" {
  config_path = "../s3"

  # Optional - mock outputs for plan phase (prevents error if S3 not applied yet)
  mock_outputs = {
    bucket_name        = "mock-bucket"
    bucket_domain_name = "mock-bucket.s3.amazonaws.com"
  }
}

inputs = {
  # automatically fetched from S3 outputs
  bucket_name        = dependency.s3.outputs.bucket_name
  bucket_domain_name = dependency.s3.outputs.bucket_domain_name

  tags = {
    Project = "VIBR Checkpoint"
    Owner   = "Vinay B R"
  }
}
