resource "aws_cloudwatch_dashboard" "main" {
  dashboard_name = var.dashboard_name
  dashboard_body = jsonencode({
    widgets = local.widgets
  })
}

data "aws_region" "current" {}

locals {
  aws_region = data.aws_region.current.name

  widgets = [for service_names in var.service_names : {
    type   = "metric"
    width  = 10
    height = 6
    properties = {
      view    = "timeSeries"
      stacked = false
      metrics = [
        ["AWS/ECS", "CPUUtilization", "ServiceName", service_names, "ClusterName", var.cluster_name, { color = "#d62728", stat = "Maximum" }],
        [".", "MemoryUtilization", ".", ".", ".", ".", { yAxis = "right", color = "#1f77b4", stat = "Maximum" }]
      ]
      region = local.aws_region,
      annotations = {
        horizontal = [
          {
            color = "#ff9896",
            label = "100% CPU",
            value = 100
          },
          {
            color = "#9edae5",
            label = "100% Memory",
            value = 100,
            yAxis = "right"
          },
        ]
      }
      yAxis = {
        left = {
          min = 0
        }
        right = {
          min = 0
        }
      }
      title  = "${var.cluster_name} / ${service_names}"
      period = 300
    }
  }]
}
