terraform {
  source = "../modules/s3"
}

include "root" {
  path = find_in_parent_folders("root.hcl")
}

inputs = {
  bucket_name = "vibr-chkp-products"
  tags = {
    Project = "VIBR Checkpoint"
    Owner   = "Vinay B R"
  }
}
