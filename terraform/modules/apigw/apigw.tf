resource "aws_apigatewayv2_api" "lambda" {
  name = "sfn_gw"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_stage" "lambda" {
  api_id = aws_apigatewayv2_api.lambda.id

  name = "serverless_lambda_stage"
  auto_deploy = true

  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.api_gw.arn

    format = jsonencode({
      requestId = "$context.requestId"
      sourceIp = "$context.identity.sourceIp"
      requestTime = "$context.requestTime"
      protocol = "$context.protocol"
      httpMethod = "$context.httpMethod"
      resourcePath = "$context.resourcePath"
      routeKey = "$context.routeKey"
      status = "$context.status"
      responseLength = "$context.responseLength"
      integrationErrorMessage = "$context.integrationErrorMessage"
    }
    )
  }
}

resource "aws_apigatewayv2_integration" "sfn_integration" {
  api_id = aws_apigatewayv2_api.lambda.id
  integration_subtype = "StepFunctions-StartExecution"
  integration_type = "AWS_PROXY"
  credentials_arn = aws_iam_role.ApigwSfnRole.arn
  request_parameters = {
    StateMachineArn = var.sfn_arn
    Input           = "$request.body"
  }
}

resource "aws_apigatewayv2_route" "sfn_route" {
  api_id = aws_apigatewayv2_api.lambda.id
  route_key = "POST /sfn"
  #authorization_scopes = []
  #request_models       = {}
  target = "integrations/${aws_apigatewayv2_integration.sfn_integration.id}"
}

resource "aws_cloudwatch_log_group" "api_gw" {
  name = "/aws/api_gw/${aws_apigatewayv2_api.lambda.name}"
  retention_in_days = 30
}


#resource "aws_iam_role_policy_attachment" "lambda_policy" {
#  role       = aws_iam_role.lambda_exec.name
#  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
#}
#
#resource "aws_iam_role" "lambda_exec" {
#  name    = "api_gateway_role"
#
#  assume_role_policy = jsonencode({
#    "Version": "2012-10-17",
#    "Statement": [
#      {
#        "Sid": "",
#        "Effect": "Allow",
#        "Principal": {
#          "Service": [
#            "apigateway.amazonaws.com",
#            "lambda.amazonaws.com"
#          ]
#        },
#        "Action": "sts:AssumeRole"
#      }
#    ]
#  })
#}

#resource "aws_lambda_permission" "prod_api_gtw" {
#  statement_id  = "AllowExecutionFromApiGateway"
#  action        = "lambda:InvokeFunction"
#  function_name = aws_lambda_function.prod_options.function_name
#  principal     = "apigateway.amazonaws.com"
#
#  source_arn = "${aws_apigatewayv2_api.gateway_prod.execution_arn}/*/*"
#
#}