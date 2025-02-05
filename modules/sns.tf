resource "aws_sns_topic" "user_updates" {
  name            = "user-updates-topic"
  kms_master_key_id = aws_kms_key.sns_alarm.key_id
  delivery_policy = <<EOF
{
  "http": {
    "defaultHealthyRetryPolicy": {
      "minDelayTarget": 20,
      "maxDelayTarget": 20,
      "numRetries": 3,
      "numMaxDelayRetries": 0,
      "numNoDelayRetries": 0,
      "numMinDelayRetries": 0,
      "backoffFunction": "linear"
    },
    "disableSubscriptionOverrides": false,
    "defaultThrottlePolicy": {
      "maxReceivesPerSecond": 1
    }
  }
}
EOF
}

resource "aws_kms_alias" "sns_key" {
    name = "alias/snskey"
    target_key_id = aws_kms_key.sns_alarm.key_id
}

# Here we can add more metric alarms, such as:
# - ActiveConnections
# - PublishSize
# - NumberOfNotificationsFailed
# - NumberOfNotificationsDelivered
# - NumberOfMessagesPublished
# - SMSSuccessRate
# - BytesProcessed
# - PacketsDropped
# - NewConnections