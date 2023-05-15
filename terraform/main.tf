terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

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

module "apigw" {
  source = "./modules/apigw"
  sfn_arn = module.sfn.sfn_arn
}
