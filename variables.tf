#variable "email_id" {
#  description = "The email ID of the subscriber"
#  type        = string
#  default     = "aws.hkjc_core_master@hkjc.org.hk"
#}

variable "integration_url" {
  description = "Webhook URL for integration (e.g., Jira)"
  type        = string
}

variable "account_id" {
  description = "AWS Account ID"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "prod"
}
