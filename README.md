Terraform Java snapstart Lambda template

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
> terraform apply -var-file=eu-west-1.tfvars

## Cleanup

> terraform destroy -var-file=eu-west-1.tfvars