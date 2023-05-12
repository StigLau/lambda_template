output "lambda_arn" {
  description = "Full ARN of the Task Definition (including both family and revision)."
  value       = aws_lambda_function.lambda_template_function.arn
}