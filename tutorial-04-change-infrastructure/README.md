# Terraform Tutorial 04 — Manage Infrastructure

## Overview

This tutorial demonstrates how Terraform manages changes to AWS infrastructure.

The project covers:

* Input variables
* Output values
* Terraform modules
* VPC and subnet creation
* Security groups
* EC2 instance configuration
* `terraform plan`
* `terraform apply`
* Terraform state

Terraform variables make the configuration more flexible, while outputs expose useful information from the infrastructure.

---

## Architecture

```text
AWS
│
└── VPC
    │
    ├── Public Subnet
    │   └── EC2 Instance
    │       └── Security Group
    │
    └── Private Subnet
```

The VPC is created using the reusable Terraform AWS VPC module. Terraform modules are reusable collections of configuration that can be used to manage infrastructure consistently.

---

## Project Structure

```text
tutorial-04-change-infrastructure/
│
├── main.tf
├── variable.tf
├── output.tf
├── terraform.tf
├── .terraform.lock.hcl
└── README.md
```

### Files

| File                  | Purpose                                                 |
| --------------------- | ------------------------------------------------------- |
| `main.tf`             | AWS provider, VPC, security group and EC2 configuration |
| `variable.tf`         | Input variables                                         |
| `output.tf`           | Terraform output values                                 |
| `terraform.tf`        | Terraform and provider configuration                    |
| `.terraform.lock.hcl` | Locks provider versions                                 |
| `README.md`           | Project documentation                                   |

---

## AWS Resources

This project creates:

* VPC
* Public subnet
* Private subnet
* Internet Gateway
* Route tables
* Security group
* EC2 instance

The VPC module creates and manages the networking resources defined in the configuration.

---

## Input Variables

The project uses variables instead of hard-coding the EC2 instance name and instance type.

Example:

```hcl
variable "instance_hostname" {
  description = "Value of the EC2 instance's Name tag."
  type        = string
  default     = "learn-terraform"
}

variable "instance_type" {
  description = "The EC2 instance's type."
  type        = string
  default     = "t2.nano"
}
```

Variables allow the EC2 configuration to be changed without modifying the main infrastructure configuration. The Terraform tutorial recommends keeping variable definitions in a separate variables file.

---

## Output Values

The project exposes the EC2 hostname and private DNS through Terraform outputs.

Example:

```hcl
output "instance_hostname" {
  description = "EC2 public DNS hostname"
  value       = aws_instance.app_server.public_dns
}

output "instance_private_dns" {
  description = "EC2 private DNS"
  value       = aws_instance.app_server.private_dns
}
```

Terraform outputs allow infrastructure information to be accessed by users and other automation tools.

View outputs with:

```powershell
terraform output
```

---

## Terraform Workflow

### 1. Initialize Terraform

```powershell
terraform init
```

This downloads the required providers and modules.

Whenever a new module is added, Terraform must be initialized again.

### 2. Format the configuration

```powershell
terraform fmt
```

### 3. Validate the configuration

```powershell
terraform validate
```

### 4. Create an execution plan

```powershell
terraform plan
```

The plan shows what Terraform intends to create, modify, or destroy before making changes.

### 5. Apply the configuration

```powershell
terraform apply
```

Confirm with:

```text
yes
```

### 6. View outputs

```powershell
terraform output
```

### 7. View Terraform state

```powershell
terraform state list
```

Terraform state keeps track of the infrastructure resources managed by the configuration. The tutorial demonstrates using `terraform state list` to view the resources Terraform is managing.

---

## Changing Infrastructure

One of the main purposes of this tutorial is understanding how Terraform handles configuration changes.

For example, the EC2 instance type can be changed through a variable:

```powershell
terraform plan -var="instance_type=t2.large"
```

Terraform compares the desired configuration with the current state and creates an execution plan showing the required changes.

---

## Module

This project uses the Terraform AWS VPC module:

```hcl
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "terraform-learning-vpc"
  cidr = "10.0.0.0/16"

  azs = ["ap-south-1a"]

  private_subnets = [
    "10.0.2.0/24"
  ]

  public_subnets = [
    "10.0.1.0/24"
  ]

  enable_nat_gateway = false
  enable_vpn_gateway = false
  create_igw         = true
}
```

Using a module avoids having to manually define every individual VPC networking resource.

Terraform automatically determines dependencies between resources and modules and creates resources in the required order.

---

## Key Terraform Concepts Learned

### Variables

Variables make Terraform configurations reusable and configurable.

```text
var.instance_type
var.instance_hostname
```

### Outputs

Outputs expose information from deployed resources.

```text
aws_instance.app_server.private_dns
```

### Modules

Modules provide reusable infrastructure configurations.

```text
terraform-aws-modules/vpc/aws
```

### Plan

```powershell
terraform plan
```

Shows proposed infrastructure changes before applying them.

### Apply

```powershell
terraform apply
```

Applies the planned changes to AWS.

### State

```powershell
terraform state list
```

Shows resources currently tracked by Terraform.

---

## Cleanup

When the lab is complete, destroy the resources to avoid unnecessary AWS charges:

```powershell
terraform destroy
```

Review the proposed destruction and confirm with:

```text
yes
```

---

## Learning Outcome

After completing this tutorial, I learned how to:

* Manage AWS infrastructure using Terraform
* Use input variables
* Use output values
* Create reusable infrastructure with modules
* Create a VPC and subnets
* Configure an EC2 instance
* Configure a security group
* Preview changes using `terraform plan`
* Apply changes using `terraform apply`
* Inspect Terraform state
* Destroy infrastructure using Terraform

---

## Author

**Aniket Chatur**

DevOps / Cloud / Infrastructure Learning Project

Technologies:

```text
Terraform
AWS
EC2
VPC
Security Groups
Infrastructure as Code (IaC)
```
