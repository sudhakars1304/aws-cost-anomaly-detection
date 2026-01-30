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

# Cost Anomaly SNS alert Subscription
resource "aws_ce_anomaly_subscription" "cost_anomaly_alert" {
  name      = var.subscription_name
  frequency = "IMMEDIATE"

  monitor_arn_list = ["arn:aws:ce::${var.account_id}:anomalymonitor/8aaf1133-17e0-4d52-949c-0eac8a81c05c"]

  # Use OR condition with separate threshold expressions
  threshold_expression {
    and {
        dimension {
          key           = "ANOMALY_TOTAL_IMPACT_ABSOLUTE"
          values        = ["100"]
          match_options = ["GREATER_THAN_OR_EQUAL"]
        }
      }
      and {
        dimension {
          key           = "ANOMALY_TOTAL_IMPACT_PERCENTAGE"
          values        = ["40"]
          match_options = ["GREATER_THAN_OR_EQUAL"]
        }
      }
    }


  subscriber {
    type    = "SNS"
    address = aws_sns_topic.cost_anomaly.arn
  }
}
