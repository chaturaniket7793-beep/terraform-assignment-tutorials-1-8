\# Tutorial 1 – What is Infrastructure as Code with Terraform



\## Objective



Understand the fundamentals of Infrastructure as Code (IaC) and how Terraform is used to define, manage, and automate infrastructure.



\## Official Tutorial



HashiCorp Terraform – What is Infrastructure as Code with Terraform



https://developer.hashicorp.com/terraform/tutorials/aws-get-started/infrastructure-as-code



\## Completed



\* \[x] Watched the HashiCorp tutorial video

\* \[x] Completed the theory/interactive content

\* \[x] Learned the basic Terraform workflow

\* \[x] Understood Terraform state and providers



\## Key Learnings



\### Infrastructure as Code



IaC allows infrastructure to be defined and managed using configuration files instead of manually creating resources through a graphical interface.



\### Terraform



Terraform is a declarative Infrastructure as Code tool from HashiCorp. It allows infrastructure to be defined in human-readable configuration files and manages the lifecycle of those resources.



\### Providers



Terraform providers allow Terraform to communicate with cloud platforms and other services through their APIs.



Examples:



\* AWS

\* Azure

\* Google Cloud

\* Kubernetes

\* GitHub



\### Declarative Configuration



Terraform describes the \*\*desired state\*\* of infrastructure rather than specifying every step required to create it.



\### Terraform State



Terraform uses a state file to keep track of the infrastructure it manages. Terraform compares the configuration with the current state to determine what changes are required.



\### Terraform Workflow



The basic Terraform workflow is:



```text

Scope

&#x20; ↓

Author

&#x20; ↓

Initialize

&#x20; ↓

Plan

&#x20; ↓

Apply

```



Common commands include:



```bash

terraform init

terraform plan

terraform apply

```



\## Key Takeaway



Terraform enables infrastructure to be managed as code in a consistent, repeatable, version-controlled, and automated way.



\## Status



\*\*Completed ✅\*\*



