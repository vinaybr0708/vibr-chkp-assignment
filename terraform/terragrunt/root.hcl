# Root Terragrunt configuration

# Remote Backend & State Lock
remote_state {
  backend = "s3"

  config = {
    bucket         = "vibr-chkp-tfstate"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = "ap-south-1"
    encrypt        = true

    # Only use DynamoDB lock table if env var TERRAGRUNT_DISABLE_LOCK is NOT set
    dynamodb_table = (
      getenv("TERRAGRUNT_DISABLE_LOCK", "") == "" ?
      "vibr-chkp-tfstate-lock" :
      ""
    )
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
