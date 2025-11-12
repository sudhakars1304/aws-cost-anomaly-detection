variable "function_name" {
  description = "Name of the Lambda function"
  type        = string
}

variable "integration_url" {
  description = "Webhook URL for integration"
  type        = string
}

variable "account_id" {
  description = "AWS Account ID"
  type        = string
}

variable "sns_topic_arn" {
  description = "ARN of the SNS topic for Lambda trigger"
  type        = string
}
