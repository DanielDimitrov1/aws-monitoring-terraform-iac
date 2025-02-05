
resource "aws_cloudwatch_metric_alarm" "apigateway_4xx_error" {
  alarm_name                = "ApiGateway4xxErrorAlarm"
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = 1
  metric_name               = "4xx"
  namespace                 = "AWS/ApiGateway"
  period                    = 120
  statistic                 = "Sum"
  threshold                 = 5

  alarm_description         = "This metric monitors ApiGateway 4xx Errors"

  alarm_actions = [aws_sns_topic.alarm.arn]
  ok_actions    = [aws_sns_topic.alarm.arn]

  treat_missing_data = "notBreaching"
  dimensions = {
    #ApiId = var.api_gateway,
    Stage = var.api_gateway_stage_name}
}

# Here we can add more metric alarms, such as:
# - 5xxErrorAlarm
# - Latency
# - Count
# - IntegrationLatency
# - DataProcessed
