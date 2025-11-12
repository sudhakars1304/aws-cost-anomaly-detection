# Cost Anomaly Module (SNS + Cost Explorer)
module "aws-cost-anomaly" {
  source = "./modules/aws-cost-anomaly"

  #email_id      = var.email_id
  account_id    = var.account_id
  function_name = "aws-cost-anomaly-integration"
}

# Lambda Module (Lambda + IAM + Logging)
module "lambda" {
  source = "./modules/lambda"

  function_name   = "aws-cost-anomaly-integration"
  integration_url = var.integration_url
  account_id      = var.account_id
  sns_topic_arn   = module.aws-cost-anomaly.sns_topic_arn
}
