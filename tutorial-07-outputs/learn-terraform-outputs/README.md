rary
/
README.md



Terraform Output Values – AWS Infrastructure
Overview
This project demonstrates how to use Terraform output values to export structured information about AWS resources.

Terraform outputs can be used to:

Expose resource information from Terraform configurations.

Pass information from child modules to root modules.

Provide values to automation tools.

Query infrastructure information from the command line.

Mark sensitive values to reduce accidental disclosure.

Generate machine-readable JSON output.

This tutorial deploys application infrastructure on AWS and demonstrates VPC, load balancer, EC2 instances, and database outputs. fileciteturn0file0L11-L13

Prerequisites
Before starting, you need:

Terraform v1.2 or later installed locally.

An AWS account.

AWS credentials configured for Terraform.

Basic familiarity with the Terraform workflow. fileciteturn0file0L23-L28

Cost Warning: Some resources used in this tutorial may not qualify for the AWS Free Tier. Destroy the infrastructure after completing the tutorial to avoid unnecessary charges. fileciteturn0file0L32-L34

1. Clone the Repository
git clone https://github.com/hashicorp-education/learn-terraform-outputs
cd learn-terraform-outputs
The example repository contains Terraform configuration for a web application including a VPC, load balancer, EC2 instances, and a database. fileciteturn0file0L36-L50

2. Initialize Terraform
terraform init
Terraform downloads the required providers and initializes the working directory. fileciteturn0file0L56-L70

3. Create the Infrastructure
Run:

terraform apply
Confirm the operation by entering:

yes
The tutorial creates 46 resources in the example configuration. fileciteturn0file0L76-L90

4. Configure Terraform Outputs
It is recommended to keep output declarations in a separate file named:

outputs.tf
VPC ID
output "vpc_id" {
  description = "ID of project VPC"
  value       = module.vpc.vpc_id
}
fileciteturn0file0L96-L107

Load Balancer URL
output "lb_url" {
  description = "URL of load balancer"
  value       = "http://${module.elb_http.elb_dns_name}/"
}
Web Server Count
output "web_server_count" {
  description = "Number of web servers provisioned"
  value       = length(module.ec2_instances.instance_ids)
}
The lb_url output builds a URL from the load balancer DNS name, while web_server_count uses the length() function to calculate the number of provisioned instances. fileciteturn0file0L116-L135

5. Apply the Output Configuration
After adding or changing outputs, run:

terraform apply
The infrastructure does not need to change, but Terraform updates the state with the new output values. fileciteturn0file0L137-L160

Example:

Outputs:

lb_url = "http://<load-balancer-dns-name>/"
vpc_id = "vpc-xxxxxxxx"
web_server_count = 4
6. Query Terraform Outputs
Display All Outputs
terraform output
Display One Output
terraform output lb_url
Get Raw Output
Use -raw when you need a clean value without quotation marks:

terraform output -raw lb_url
The raw value can be passed directly to other commands. fileciteturn0file0L172-L200

Test the Load Balancer
curl $(terraform output -raw lb_url)
Example response:

<html><body><div>Hello, world!</div></body></html>
fileciteturn0file0L204-L210

7. Sensitive Outputs
Terraform allows outputs to be marked as sensitive.

Example:

output "db_username" {
  description = "Database administrator username"
  value       = aws_db_instance.database.username
  sensitive   = true
}

output "db_password" {
  description = "Database administrator password"
  value       = aws_db_instance.database.password
  sensitive   = true
}
fileciteturn0file0L218-L237

When running:

terraform output
Terraform displays:

db_password = <sensitive>
db_username = <sensitive>
This helps prevent accidental exposure when Terraform displays output values. fileciteturn0file0L245-L268

Important Security Note
sensitive = true does not encrypt the value.

Terraform still stores sensitive output values in the Terraform state file. Therefore, the state file must be protected securely. fileciteturn0file0L280-L304

Also note that querying a sensitive output directly can reveal its value:

terraform output db_password
fileciteturn0file0L268-L274

8. Generate JSON Output
For automation and scripting, Terraform supports JSON output:

terraform output -json
This returns output values together with their type and sensitivity information. fileciteturn0file0L306-L344

Example structure:

{
  "vpc_id": {
    "sensitive": false,
    "type": "string",
    "value": "vpc-xxxxxxxx"
  },
  "web_server_count": {
    "sensitive": false,
    "type": "number",
    "value": 4
  }
}
Security Note: Terraform does not redact sensitive values when using terraform output -json, because the JSON output is intended for automation tools. fileciteturn0file0L306-L344

9. Useful Terraform Commands
Command	Purpose
terraform init	Initialize the Terraform working directory
terraform apply	Create/update infrastructure and outputs
terraform output	Display all outputs
terraform output <name>	Display a specific output
terraform output -raw <name>	Return a raw output value
terraform output -json	Return outputs in JSON format
curl $(terraform output -raw lb_url)	Test the load balancer
10. Key Learnings
By completing this tutorial, you learn how to:

Define Terraform output values.

Export values from modules.

Query individual Terraform outputs.

Use -raw for command-line automation.

Mark database credentials as sensitive.

Understand the limitations of sensitive = true.

Generate JSON output for automation.

Use Terraform outputs with shell commands and other tools.

11. Clean Up
After completing the tutorial, destroy the AWS infrastructure to prevent unnecessary charges:

terraform destroy
Review the resources that Terraform plans to remove and confirm with:

yes