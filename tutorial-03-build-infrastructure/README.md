\# Tutorial 3 – Build Infrastructure with Terraform



\## Objective



Build AWS infrastructure using Terraform and understand the basic Terraform workflow:



```text

terraform init

terraform fmt

terraform validate

terraform plan

terraform apply

terraform state list

```



This tutorial is based on the official HashiCorp Terraform AWS tutorial.



\## Environment



\* Cloud Provider: AWS

\* AWS Region: `ap-south-1` (Mumbai)

\* Terraform CLI: `1.15.3`

\* AWS Provider: `hashicorp/aws`

\* Infrastructure: VPC, public subnet, private subnet, route tables, security resources and EC2 instance

\* EC2 Instance Type: `t2.nano`

\* Operating System: Ubuntu 24.04 AMD64

\* AMI ID: `ami-006f82a1d5a27da54`



\## Terraform Configuration



\### Terraform Version and Provider



```hcl

terraform {

&#x20; required\_version = ">= 1.2"



&#x20; required\_providers {

&#x20;   aws = {

&#x20;     source  = "hashicorp/aws"

&#x20;     version = "\~> 5.92"

&#x20;   }

&#x20; }

}

```



\### AWS Provider



```hcl

provider "aws" {

&#x20; region = "ap-south-1"

}

```



\### VPC



The VPC was created with:



```text

CIDR: 10.0.0.0/16

```



One public subnet and one private subnet were configured:



```text

Public Subnet:  10.0.1.0/24

Private Subnet: 10.0.2.0/24

Availability Zone: ap-south-1a

```



NAT Gateway and VPN Gateway were disabled.



\### EC2 Instance



```hcl

resource "aws\_instance" "app\_server" {

&#x20; ami           = "ami-006f82a1d5a27da54"

&#x20; instance\_type = "t2.nano"



&#x20; tags = {

&#x20;   Name        = "terraform-learning"

&#x20;   Environment = "devops"

&#x20; }

}

```



\## Terraform Workflow



\### 1. Initialize



```powershell

terraform init

```



Terraform initialized the working directory and downloaded the required modules and providers.



\### 2. Format



```powershell

terraform fmt

```



Used to format Terraform configuration according to Terraform's standard formatting.



\### 3. Validate



```powershell

terraform validate

```



Result:



```text

Success! The configuration is valid.

```



\### 4. Plan



```powershell

terraform plan

```



Terraform generated the execution plan before making changes.



The plan showed:



```text

Plan: 11 to add, 0 to change, 0 to destroy.

```



\### 5. Apply



```powershell

terraform apply

```



After reviewing the execution plan, the changes were approved.



Result:



```text

Apply complete! Resources: 11 added, 0 changed, 0 destroyed.

```



\## Resources Created



Terraform successfully created:



```text

1\. VPC

2\. Public subnet

3\. Private subnet

4\. Public route table

5\. Private route table

6\. Public route table association

7\. Private route table association

8\. Default network ACL

9\. Default security group

10\. Default route table

11\. EC2 instance

```



\### Important Resource IDs



VPC:



```text

vpc-0e65cd47c3632b42a

```



Public subnet:



```text

subnet-075772adbee73bf23

```



Private subnet:



```text

subnet-0e46653a7cfb4bb64

```



EC2 instance:



```text

i-088a7df5c389c6028

```



\## Terraform State



Terraform maintains infrastructure information in its state file:



```text

terraform.tfstate

```



The state allows Terraform to compare the desired configuration with the current infrastructure and determine what changes are required.



Useful commands:



```powershell

terraform state list

```



```powershell

terraform show

```



\## Key Learning



\### 1. Provider



The provider connects Terraform to AWS.



```hcl

provider "aws" {

&#x20; region = "ap-south-1"

}

```



\### 2. Resource



A resource represents infrastructure that Terraform creates and manages.



```hcl

resource "aws\_instance" "app\_server" {

&#x20; ...

}

```



\### 3. Module



The VPC was created using the Terraform Registry VPC module:



```hcl

module "vpc" {

&#x20; source = "terraform-aws-modules/vpc/aws"

}

```



\### 4. Plan Before Apply



`terraform plan` allows the infrastructure changes to be reviewed before they are applied.



\### 5. State



Terraform maintains a state file to track the infrastructure it manages.



\## Assignment Status



✅ Tutorial 1 – What is Infrastructure as Code with Terraform



✅ Tutorial 2 – Install Terraform



✅ Tutorial 3 – Build Infrastructure (AWS)



⬜ Tutorial 4 – Change Infrastructure



⬜ Tutorial 5 – Destroy Infrastructure



⬜ Tutorial 6 – Define Input Variables



⬜ Tutorial 7 – Query Data with Outputs



⬜ Tutorial 8 – Store Remote State (S3 Backend)



\## Official Tutorial



HashiCorp Terraform – Build Infrastructure with AWS:



https://developer.hashicorp.com/terraform/tutorials/aws-get-started/aws-create



\## Next Step



Continue with:



\*\*Tutorial 4 – Change Infrastructure\*\*



The next tutorial will demonstrate how Terraform detects configuration changes and updates existing infrastructure.



