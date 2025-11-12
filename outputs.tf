output "sns_topic_arn" {
  description = "ARN of the SNS Topic for cost anomaly alerts"
  value       = module.aws-cost-anomaly.sns_topic_arn
}

output "lambda_function_arn" {
  description = "ARN of the AWS Lambda function"
  value       = module.lambda.lambda_function_arn
}

#output "anomaly_monitor_arn" {
#  description = "ARN of the Cost Anomaly Monitor"
#  value       = module.aws-cost-anomaly.anomaly_monitor_arn
#}
