variable "aws_region" {
  type = string
}

variable "deployment_prefix" {
  type = string
  description = "The prefix identifier used when defining resource names"
  default = "AppIdGoesHere"
}

variable "lambda_payload_filename" {
  type = string
  description = "Where the lambda jar file is located"
}