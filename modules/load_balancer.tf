
resource "aws_cloudwatch_metric_alarm" "apigateway_4xx_error" {
  alarm_name                = "Healthy-Count"
  comparison_operator       = "LessThanOrEqualToThreshold"
  evaluation_periods        = 1
  metric_name               = "HealthyHostCount"
  namespace                 = "AWS/ApplicationELB"
  period                    = "60"
  statistic                 = "Average"
  threshold                 = "60"

  alarm_description         = "This alarm will notify us when there is 1 or more unhealthy hosts."

  alarm_actions = [aws_sns_topic.alarm.arn]
  ok_actions    = [aws_sns_topic.alarm.arn]

  treat_missing_data = "notBreaching"
  dimensions = {
    LoadBalancer = data.aws_lb.main.arn_suffix}
}

data "aws_lb" "main" {
    name = var.main_alb
}
# Here we can add more metric alarms, such as: 
# - UnHealthyHostCount
# - HealthyStateDNS
# - RequestCount
# - HTTPCode_Target_4xx_Count
# - AnomalousHostCount
# - MitigatedHostCount
# - RequestCountPerTarget
# - etc, etc, etc.
