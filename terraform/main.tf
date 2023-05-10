provider "aws" {
}
resource "aws_lambda_function" "hello_world_function" {
  function_name = "skarab_function"
  filename = "${var.lambda_payload_filename}"

  role = "${aws_iam_role.lambda_apigateway_iam_role.arn}"
  #role = aws_iam_role.UnicornStockBrokerFunctionRole.arn
  handler = "no.lau.skarab.LambdaHandler"
  source_code_hash = "${filebase64sha256(var.lambda_payload_filename)}"
  runtime = "java17"

  snap_start {
    apply_on = "PublishedVersions"
  }

  #timeout     = "200"
  #memory_size = "2048"
  #publish = true


  environment {
    variables = {
      currentLocation = "Hæstepølse"
    }
  }
}

