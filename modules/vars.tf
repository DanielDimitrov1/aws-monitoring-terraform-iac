variable "module_enabled" {
  type = bool
  default = true
}

variable "ecs_service_names" {
    type = list(string)
}

variable "cluster_name" {
  type = string
}

variable "cpu_utilization_high_threshold" {
  default = 80
}

variable "memory_utilization_high_threshold" {
  default = 80
}
variable "burst_balance_threshold" {
  default = 20
}
variable "free_storage_space_threshold" {
  default = 64000000
}
variable "service_log_group" {}

variable "services_fail_namespace" {
    default = "ServiceFail"
}

variable "dashboard_name" {}  #see in main.tf file
variable "service_names" {}   #see in var.auto.tfvars file
variable "rds_identifier" {}  #see in var.auto.tfvars file
variable "api_gateway_stage_name" {}
variable "main_alb" {}
variable "sqs_names" {}