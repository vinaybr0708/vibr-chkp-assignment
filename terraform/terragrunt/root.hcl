# Root Terragrunt configuration

# Remote Backend & State Lock
remote_state {
  backend = "s3"

  config = {
    bucket         = "vibr-chkp-tfstate"                 # existing S3 bucket for state
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = "ap-south-1"
    encrypt        = true
    # dynamodb_table = "vibr-chkp-tfstate-lock"            # for state locking
  }
}


# Terraform Source (inherited by children)
terraform {
  extra_arguments "common_vars" {
    commands = get_terraform_commands_that_need_vars()
    required_var_files = []
  }
}


# Common inputs shared across modules
inputs = {
  region     = "ap-south-1"
  owner_name = "Vinay B R"

  tags = {
    Terraform   = "True"
    Environment = "Assignment"
    Owner       = "Vinay B R"
  }

  # Path to index.html in repo root
  index_html_path = "${abspath("${get_terragrunt_dir()}/../../index.html")}"
}