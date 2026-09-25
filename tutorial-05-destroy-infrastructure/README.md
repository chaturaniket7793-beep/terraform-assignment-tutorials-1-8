\# Tutorial 05 – Destroy Infrastructure with Terraform



\## Objective



Learn how to remove individual Terraform-managed resources and destroy the complete infrastructure using Terraform.



\## What I Learned



\### 1. Remove a Single Resource



A resource can be removed from the Terraform configuration by commenting out its resource block.



Example:



```hcl

/\*

resource "aws\_instance" "app\_server" {

&#x20; ami           = "ami-xxxxxxxx"

&#x20; instance\_type = var.instance\_type



&#x20; subnet\_id = module.vpc.public\_subnets\[0]

}

\*/

```



Terraform no longer considers the EC2 instance part of the desired configu



