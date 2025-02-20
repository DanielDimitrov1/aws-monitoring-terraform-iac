locals {
    env          = run_cmd("/bin/sh", "-c", "echo ${lower(split("/", get_original_terragrunt_dir())[length(split("/", get_original_terragrunt_dir())) - 2])}")
    region       = run_cmd("/bin/sh", "-c", "echo ${lower(split("/", get_original_terragrunt_dir())[length(split("/", get_original_terragrunt_dir())) - 1])}")
    tf_vars_file = "variables.${local.env}.tfvars"
}

inputs = {
    env     = local.env
    region  = local.region
}

terraform {
    source = "../../..//."
    extra_arguments "retry_lock" {
        commands = get_terraform_commands_that_need_locking()
        arguments = [
            "-lock-timeout=20m"
        ]
    }

    extra_arguments "auto_init" {
        commands = ["init"]
        arguments = [
            "-input=false", "-compact-warnings", "-var-file=${get_original_terragrunt_dir()}/${local.tf_vars_file}",
            "-out=${local.env}.tfplan", 
            "-reconfigure", 
            "-upgrade"
        ]
    }

    extra_arguments "auto_plan" {
        commands = ["plan"]
        arguments = [
            "-input=false", "-compact-warnings", "-var-file=${get_original_terragrunt_dir()}/${local.tf_vars_file}",
            "-out=${local.env}.tfplan"
        ]
    }
    extra_arguments "auto_approve" {
        commands = ["apply"]
        arguments = [
            "-input=false", "-compact-warnings", "-auto-approve", "${local.env}.tfplan"
        ]
    }
    extra_arguments "auto_destroy" {
        commands = ["destroy"]
        arguments = [
            "-input=false", "-compact-warnings", "-auto-approve", 
            "-var-file=${get_original_terragrunt_dir()}/${local.tf_vars_file}"
        ]
    }
}

generate "provider" {
    path = "providers.tf"
    if_exists = "overwrite_terragrunt"
    contents = <<EOF
      provider "aws" {
        region = "eu-west-1"
        profile = "${local.env}"
      }
    EOF
}


generate "required_providers" {
  path = "required_providers.tf"
  if_exists = "overwrite"
  contents = <<EOF
    terraform {
        required_providers {
            aws = {
                source = "hashicorp/aws"
                version = "=5.38.0"
            }
        }
    }
    EOF
}

remote_state {
    backend = "s3"
    generate = {
      path = "backend.tf"
      if_exists = "overwrite_terragrunt"
    }
    config = {
        encrypt         = true
        bucket          = "daniel-monitoring-s3-tfstate-${local.env}"
        key             = "${path_relative_to_include()}/terraform.tfstate"
        region          = local.region
        dynamodb_table  = "remote-lock-file"
        profile         = "${local.env}"
    }
}