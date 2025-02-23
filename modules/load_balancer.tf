data "aws_region" "current" {}
data "aws_caller_identity" "current" {}

resource "aws_cloudwatch_metric_alarm" "lb_4xx_error" {
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
  dimensions = "arn:aws:elasticloadbalancing:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:loadbalancer/app/main/f97903b029d2ff71"

}

#data "aws_lb" "main" {
#    name = var.main_alb
#}
# Here we can add more metric alarms, such as: 
# - UnHealthyHostCount
# - HealthyStateDNS
# - RequestCount
# - HTTPCode_Target_4xx_Count
# - AnomalousHostCount
# - MitigatedHostCount
# - RequestCountPerTarget
# - etc, etc, etc.
