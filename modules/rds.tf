resource "aws_cloudwatch_metric_alarm" "rds_memory_low" {
  alarm_name                = "rds_memory_low"
  comparison_operator       = "LessThanThreshold"
  evaluation_periods        = 2
  metric_name               = "FreeableMemory"
  namespace                 = "AWS/RDS"
  period                    = 60
  statistic                 = "Average"
  threshold                 = 80
  alarm_description         = "This metric monitors ec2 cpu utilization"
  alarm_actions = [aws_sns_topic.alarm.arn]
  ok_actions = [aws_sns_topic.alarm.arn]

  dimensions = {
    DBInstanceIdentifier = var.rds_identifier
  }
}

# Here we can add more metric alarms, such as:
# - WriteThroughput
# - WriteLatency
# - WriteOPS
# - SwapUsage
# - ReplicationSlotDiskUsage
# - TransactionLogsDiskUsage
# - DBLoadCPU
# - DatabaseConnections
# - CPUUtilization
# - EBSIOBalance%
# - DiskQueueDepth
# - NumberOfRecoveryPointsDeleting
# - NumberOfBackupJobsCreated
# - NumberOfBackupJobsCompleted
# - NumberOfBackupJobsRunning
# - ConfigurationItemsRecorded
# - ConfigurationRecorderInsufficientPermissionsFailure
# - IncomingBytes
# - IncomingLogEvents