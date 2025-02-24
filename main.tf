module "modules" {
  source = "./modules"
  dashboard_name = "Dashboard"
  cluster_name = var.cluster_name
  rds_identifier = var.rds_identifier
  service_names = var.service_names
  service_log_group = var.service_log_group
  ecs_service_names = var.ecs_service_names
  main_alb =  var.main_alb
  api_gateway_stage_name = var.api_gateway_stage_name
  sqs_names = var.sqs_names
}