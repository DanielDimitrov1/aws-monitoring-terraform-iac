resource "aws_sns_topic" "alarm" {
  name = "alaram"
  delivery_policy = file("${path.module}/aws_sns_topic.delivery_policy.json")
}
data "aws_caller_identity" "current" {}

resource "aws_kms_key" "sns_alarm" {
  description = "This is a key for sns encryption"
  policy = <<POLICY
  {
    "Version": "2012-10-17",
    "Id": "key-default-1",
    "Statement": [
      {
        "Sid": "EnableIAMUserPermissions",
        "Effect": "Allow",
        "Principal": {
          "AWS": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root",
          "Service": [
            "cloudwatch.amazonaws.com"
          ]
        },
        "Action": "kms:*",
        "Resource": "*"
      }
    ]
  }
POLICY
}
resource "aws_kms_alias" "sns_key" {
    name = "alias/snskey"
    target_key_id = aws_kms_key.sns_alarm.key_id
    lifecycle {
      ignore_changes = [target_key_id]
    }
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