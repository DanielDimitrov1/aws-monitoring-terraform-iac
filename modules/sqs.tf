resource "aws_cloudwatch_metric_alarm" "cpu_utilization_higher_than_expected" {
  for_each                  = toset(var.sqs_names) 
  alarm_name                = "sqs-queue-delay-${each.value}"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "3"
  metric_name               = "ApproximateAgeOfOldestMessage"
  namespace                 = "AWS/SQS"
  period                    = "60"
  statistic                 = "Average"
  threshold                 = "20"

  alarm_description         = "Approximate age of theoldest message in the chosen queues-${each.value}"
  alarm_actions = [aws_sns_topic.alarm.arn]
  ok_actions    = [aws_sns_topic.alarm.arn]
  treat_missing_data = "notBreaching"
  QueueName = each.value
}

# Here we can add more metric alarms, such as:
# - SendMessageSize
# - NumberOfMessagesSent
# - NumberOfMessagesReceived
# - NewConnections