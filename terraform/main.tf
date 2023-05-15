module "sfn" {
  source = "./modules/sfn"
  deployment_prefix = var.deployment_prefix
  lambda_arn = module.lambda.lambda_arn
}

module "lambda" {
  source = "./modules/lambda"
  deployment_prefix = var.deployment_prefix
  lambda_payload_filename = var.lambda_payload_filename
}

module "apigw-2" {
  source = "./modules/apigw-2"
#  apigw_input =module.lambda.lambda_properties
  apigw_target_arn = module.sfn.sfn_arn
#  deployment_prefix = var.deployment_prefix
}

#terraform {
#  backend "s3" {
#    bucket = "lambda-demo-terraform"
#    key = "lambda-dev.tfstate"
#    region = var.aws_region
#        dynamodb_table = "lambda-dev-terraform-state"
#  }
#}
