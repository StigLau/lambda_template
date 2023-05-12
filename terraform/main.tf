module "skarab_sfn" {
  source = "./modules/sfn"
  deployment_prefix = var.deployment_prefix
  lambda_arn = module.skarab_lambda.lambda_arn
}

module "skarab_lambda" {
  source = "./modules/lambda"
  deployment_prefix = var.deployment_prefix
  lambda_payload_filename = var.lambda_payload_filename
}

#terraform {
#  backend "s3" {
#    bucket = "lambda-demo-terraform"
#    key = "lambda-dev.tfstate"
#    region = var.aws_region
#        dynamodb_table = "lambda-dev-terraform-state"
#  }
#}