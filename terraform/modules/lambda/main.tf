resource "aws_lambda_function" "lambda_template_function" {
  function_name = "${var.deployment_prefix}_function"
  filename = var.lambda_payload_filename

  role = aws_iam_role.lambda_template_iam_role.arn
  handler = "template.LambdaHandler"
  source_code_hash = filebase64sha256(var.lambda_payload_filename)
  runtime = "java17"

  snap_start {
    apply_on = "PublishedVersions"
  }

  #timeout     = "200"
  #memory_size = "2048"
  publish = true

  environment {
    variables = {
      currentLocation = "Here"
    }
  }
}

