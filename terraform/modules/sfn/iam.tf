resource "aws_iam_role" "sfn_execution_role" {
  name = "${var.deployment_prefix}SfnExecutionRole"
  assume_role_policy = data.aws_iam_policy_document.sfn_role_policy.json
}

data "aws_iam_policy_document" "sfn_role_policy" {
  statement {
    effect = "Allow"
    principals {
      type = "Service"
      identifiers = [
        "states.amazonaws.com"]
    }
    actions = [
      "sts:AssumeRole"]
  }
}

resource "aws_iam_role_policy" "sfn_execution_policy" {
  name = "${var.deployment_prefix}SfnExecutionRolePolicy"
  role = aws_iam_role.sfn_execution_role.id
  policy = data.aws_iam_policy_document.sfn_execution_policy.json
}

data "aws_iam_policy_document" "sfn_execution_policy" {

  statement {
    effect = "Allow"
    actions = [
      "lambda:InvokeFunction"]
    resources = [
      var.lambda_arn]
  }
}
