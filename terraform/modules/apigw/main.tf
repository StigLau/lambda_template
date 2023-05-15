
variable "sfn_orchestrater_arn" {
  default = "arn:aws:states:eu-central-1:*account*:stateMachine:*step-function-entry-point*"
}
#var.aws_region = eu-central-1
#var.sfn_orchestrater_arn = arn:aws:states:eu-central-1:*account*:stateMachine:*step-function-entry-point*


resource "aws_api_gateway_integration" "endpoint_integration" {
  http_method             = "POST"
  integration_http_method = "POST"
  type                    = "AWS"
  passthrough_behavior    = "NEVER"
  uri                     = "arn:aws:apigateway:${var.aws_region}:states:action/StartExecution"

  request_templates = {
    "application/json" = <<EOF
{
    "input": "$util.escapeJavaScript($input.json('$'))",
    "stateMachineArn": "${var.sfn_orchestrater_arn}"
}
EOF
  }
  resource_id = ""
  rest_api_id = ""
}