locals {
    sns_arn = aws_sns_topic.alarm.arn
    dimensions_map = {cluster = {ClusterName = var.cluster_name},service= {ServiceName = var. ecs_service_names }}
    thresholds = {
        CPUUtilizationHighThreshold = min(max(var.cpu_utilization_high_threshold, 0), 100)
        MemoryUtilizationHighThreshold = min(max(var.memory_utilization_high_threshold, 0), 100)
        BurstBalanceThreshold = min(max(var.burst_balance_threshold, 0), 100)
        FreeStorageSpaceThreshold =max(var.free_storage_space_threshold, 0)
    }
    alarm_dimensions = local.dimensions_map[local.thresholds.selected_dimensions]
    dimensions = local.dimensions_map[var.ecs_service_names == [] ? "cluster" : "service"]

        alarm_names = toest ([
            "freeable_memory",
            "cpu_utilization_too_high",
            "cpu_credit_balance_too_low",
            "disk_queue_dept_too_high",
            "freeable_memory_too_low",
            "free_storage_space_threshold"
        ])
}


resource "aws_cloudwatch_metric_alarm" "cpu_utilization_higher_than_expected" {
  for_each                  = var.module_enabled ? toset(var.ecs_service_names) : toset ([])
  alarm_name                = "${each.value}-cpu-utilization-high"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = 2
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = 120
  statistic                 = "Average"
  threshold                 = 80

  alarm_description         = "This metric monitors ec2 cpu utilization"
  alarm_actions = [aws_sns_topic.alarm.arn]
  ok_actions    = [aws_sns_topic.alarm.arn]
  treat_missing_data = "notBreaching"
  dimensions = {ServiceName = each.value,ClusterName= var.cluster_name}
}

# Here we can add more metric alarms, such as: 
# - DeploymentCount
# - RunningTaskCount
# - DesiredTaskCount
# - CpuUtilized
# - MemoryUtilized
# - EphemeralStorageUtilized
# - StorageWriteBytes
# - etc, etc, etc.