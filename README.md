# Terraform Java snapstart Lambda template
This is a template for enabling the craziest architecture ever: 
* Easy packaing of ANY horrible (Spring Boot?) java-app inside AWS Lambda
* Snapstart for enabling lighting-fast startup
* Step Functions for performing orchestration of 1-many lambdas (functions from one or more apps)
* API Gateway for http access
* Terraform for easy deployment

_NOTE: Auhtentication || Security || Batteries NOT INCLUDED_

## Terraform config example:
### Add file ./eu-west-1.tfvars
> 
> deployment_prefix = "LambdaTesting"
> 
> aws_region = "eu-west-1"
>
> lambda_payload_filename = "../target/lambda-template-0.1.0.jar"

## Deployment

> mvn clean package
> 
> cd terraform
> 
> terraform init
> 
> _terraform apply -var-file=eu-west-1.tfvars #DEPLOY TO AWS:_

## Invoking
curl "$(terraform output -raw base_url)/your_bath"

## Cleanup

> terraform destroy -var-file=eu-west-1.tfvars
> 
## Setting up bucket-storage for Terraform state

> terraform {
> 
>   backend "s3" {
> 
>     bucket = "lambda-demo-terraform"
> 
>     key = "lambda-dev.tfstate"
> 
>     region = var.aws_region
> 
>     dynamodb_table = "lambda-dev-terraform-state"
> 
>   }
> 
> }

#Inspiration 

https://developer.hashicorp.com/terraform/tutorials/aws/lambda-api-gateway
