output "lambda_function_arn" {
  description = "ARN of the Lambda function"
  value       = aws_lambda_function.integration_lambda.arn
}

output "lambda_function_name" {
  description = "Name of the Lambda function"
  value       = aws_lambda_function.integration_lambda.function_name
}

output "iam_role_arn" {
  description = "ARN of the IAM role for Lambda execution"
  value       = aws_iam_role.integration_lambda_exec_role.arn
}
