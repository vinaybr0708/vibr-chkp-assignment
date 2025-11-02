variable "region" {
  default = "ap-south-1"
}

variable "bucket_name" {
  default = "vibr-chkp-assignment-bucket"
}

variable "owner_name" {
  default = "Vinay B R"
}

variable "tags" {
  type = map(string)
  default = {
    Terraform = "True"
  }
}
