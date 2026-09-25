# Tutorial 2 – Install Terraform

## Objective

Install Terraform CLI and verify that Terraform is working correctly.

## What I Learned

* Installed Terraform CLI.
* Verified Terraform installation using `terraform -help`.
* Learned how to check help for individual Terraform commands.
* Learned about Terraform version compatibility.
* Learned how to enable Terraform tab completion.
* Understood the basic Terraform CLI workflow.

## Verification

Terraform installation was verified successfully using:

```bash
terraform -help
```

Command-specific help can be checked using:

```bash
terraform plan -help
```

## Terraform Basic Workflow

```text
Write Terraform Configuration
        ↓
terraform init
        ↓
terraform plan
        ↓
terraform apply
        ↓
Infrastructure Created
```

## Tutorial Status

✅ Completed

## Official Tutorial

HashiCorp Terraform – Install Terraform

https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli

## Next Step

Proceed to the next Terraform tutorial and learn how to create and manage AWS infrastructure using Terraform.
