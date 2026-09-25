# Tutorial 08 — Terraform Remote State with Amazon S3

## 📌 Overview

This tutorial demonstrates how to configure **Terraform Remote State using an Amazon S3 backend**.

Instead of storing Terraform state only on the local machine, Terraform can store the state file as an object inside an Amazon S3 bucket.

According to the official HashiCorp documentation, the S3 backend stores Terraform state at the S3 object path specified by the `key` configuration inside the configured bucket.

### Official Documentation

* [Terraform S3 Backend Documentation](https://developer.hashicorp.com/terraform/language/backend/s3)

---

## 🎯 Objectives

The objectives of this tutorial were:

* Create an Amazon S3 bucket using Terraform.
* Enable S3 Bucket Versioning.
* Configure Terraform to use S3 as a remote backend.
* Store `terraform.tfstate` remotely in S3.
* Verify the remote state from the AWS Console.
* Understand Terraform state locking.
* Understand S3 object versioning.
* Practice cleaning up versioned S3 objects and delete markers.
* Destroy the AWS resources after completing the lab.

---

## 🏗️ Architecture

```text
                Terraform
                    |
                    |
             terraform init
                    |
                    v
          +-------------------+
          |    S3 Bucket      |
          |                   |
          |  tutorial-08/     |
          |  terraform.tfstate|
          |                   |
          +-------------------+
                    |
                    v
             Remote State
```

---

## 📁 Project Structure

```text
tutorial-08-remote-state/
│
├── .terraform/
├── .terraform.lock.hcl
│
├── backend.tf
├── main.tf
├── variables.tf
├── outputs.tf
│
├── terraform.tfstate
├── terraform.tfstate.backup
│
├── Aws S3 Bucket .png
├── S3 bucket GUI .png
├── S3 bucket versioning.png
├── Versioning enable.png
├── Tfbackup list object .png
└── Tfstate backup into s3.png
```

---

# 1. Terraform S3 Backend

The S3 backend configuration is defined in `backend.tf`.

Example:

```hcl
terraform {
  backend "s3" {
    bucket = "chatur-terraform-s3-backend-demo-2026-001"
    key    = "tutorial-08/terraform.tfstate"
    region = "ap-south-1"
  }
}
```

### Configuration Explanation

| Setting  | Description                                 |
| -------- | ------------------------------------------- |
| `bucket` | Name of the S3 bucket                       |
| `key`    | Location/path of the Terraform state object |
| `region` | AWS region where the S3 bucket exists       |

HashiCorp documents `
