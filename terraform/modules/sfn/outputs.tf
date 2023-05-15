output "sfn_arn" {
  description = "Full ARN of the Task Definition (including both family and revision)."
  value       = aws_sfn_state_machine.sfn_state_machine.arn
}