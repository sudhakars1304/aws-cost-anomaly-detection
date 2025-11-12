# IAM Role for Lambda Execution
resource "aws_iam_role" "integration_lambda_exec_role" {
  name = "${var.function_name}-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = { Service = "lambda.amazonaws.com" }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# IAM Policy for Lambda logging permissions
resource "aws_iam_policy" "lambda_logging_policy" {
  name        = "${var.function_name}-logging-policy"
  description = "Policy for Lambda function CloudWatch logging permissions"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = "arn:aws:logs:ap-east-1:${var.account_id}:log-group:/aws/lambda/${var.function_name}:*"
      }
    ]
  })
}

# Attach the policy to the role
resource "aws_iam_role_policy_attachment" "lambda_logging_attachment" {
  role       = aws_iam_role.integration_lambda_exec_role.name
  policy_arn = aws_iam_policy.lambda_logging_policy.arn
}

# CloudWatch Log Group for Lambda
resource "aws_cloudwatch_log_group" "integration_lambda_loggroup" {
  name              = "/aws/lambda/${var.function_name}"
  retention_in_days = 60
}

# Lambda function code archive
data "archive_file" "integration_lambda_zip" {
  type        = "zip"
  output_path = "${path.module}/lambda_function.zip"
  
  source {
    content  = file("${path.module}/script/index.py")
    filename = "index.py"
  }
}

# Lambda Function
resource "aws_lambda_function" "integration_lambda" {
  function_name = var.function_name
  handler       = "index.lambda_handler"
  runtime       = "python3.10"
  role          = aws_iam_role.integration_lambda_exec_role.arn
  filename      = data.archive_file.integration_lambda_zip.output_path
  timeout       = 60
  memory_size   = 128

  environment {
    variables = {
      IntegrationURL = var.integration_url
    }
  }

  depends_on = [
    aws_iam_role.integration_lambda_exec_role,
    aws_cloudwatch_log_group.integration_lambda_loggroup
  ]
}

# Lambda Permission for SNS
resource "aws_lambda_permission" "allow_sns" {
  statement_id  = "AllowExecutionFromSNS"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.integration_lambda.function_name
  principal     = "sns.amazonaws.com"
  source_arn    = var.sns_topic_arn
}

# SNS Subscription to Lambda
resource "aws_sns_topic_subscription" "lambda_sns_subscription" {
  topic_arn = var.sns_topic_arn
  protocol  = "lambda"
  endpoint  = aws_lambda_function.integration_lambda.arn
}
