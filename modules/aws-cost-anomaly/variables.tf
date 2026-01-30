#variable "email_id" {
#  description = "Email address for notifications"
#  type        = string
#}

variable "subscription_name" {
  description = "Name for the cost anomaly subscription"
  type        = string
  default     = "cost-anomaly-alert"
}

variable "account_id" {
  description = "AWS Account ID"
  type        = string
}

variable "function_name" {
  description = "Lambda function name"
  type        = string
}

variable "existing_monitor_name" {
  description = "Name of the existing cost anomaly monitor"
  type        = string
  default     = "Default-service-monitor"
}


variable "anomaly_threshold_amount" {
  description = "Dollar amount threshold to trigger anomaly alerts"
  type        = string
  default     = "100"
}

variable "anomaly_threshold_percentage" {
  description = "Percentage threshold to trigger anomaly alerts"
  type        = string
  default     = "40"
}
