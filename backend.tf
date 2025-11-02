# Configure the Terraform backend to use Amazon S3 for state storage

terraform {
  backend "s3" {
    bucket         = "vibr-chkp-tfstate"      
    key            = "infra/terraform.tfstate"  
    region         = "ap-south-1"
    encrypt        = true
  }
}
