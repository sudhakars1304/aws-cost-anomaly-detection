# SNS Topic for Cost Anomaly Notifications
resource "aws_sns_topic" "cost_anomaly" {
  name = "aws-cost-anomaly"
}

resource "aws_sns_topic_policy" "cost_anomaly_policy" {
  arn = aws_sns_topic.cost_anomaly.arn
  policy = jsonencode({
    Version = "2008-10-17"
    Statement = [
      {
        Sid       = "AWSAnomalyDetectionSNSPublishingPermissions"
        Effect    = "Allow"
        Principal = {
          Service = "costalerts.amazonaws.com"
        }
        Action   = "SNS:Publish"
        Resource = aws_sns_topic.cost_anomaly.arn
      }
    ]
  })
}
