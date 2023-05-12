locals {
  state_machine_name = "${var.deployment_prefix}StepFunction"
}

resource "aws_sfn_state_machine" "sfn_state_machine" {
  name = local.state_machine_name
  role_arn = aws_iam_role.sfn_execution_role.arn
  definition = templatefile("${path.module}/files/sfn.template.json", {
    lambda_arn = var.lambda_arn
    job_name = "${var.deployment_prefix}Job"
  })
}
