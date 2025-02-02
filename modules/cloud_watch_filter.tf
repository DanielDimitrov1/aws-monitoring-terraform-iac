resource "aws_cloudwatch_log_metric_filter" "yada" {
  for_each = toset(var.service_log_group)
  name           = "${each.value}-FailFiletr"
  pattern        = "fail"
  log_group_name = "/ecs/${each.value}"     #we have already created the log groups for our ECS services

  metric_transformation {
    name      = each.value
    namespace = var.services_fail_namespace
    value     = "5"
  }
}