Collaborate Using HCP Terraform



Overview



This tutorial demonstrates how to migrate a local Terraform workspace to HCP Terraform and use the Terraform CLI to trigger remote runs.



The main goal is to move Terraform state and execution from the local machine to HCP Terraform, making infrastructure management easier to collaborate on with a team. HCP Terraform provides a secure remote execution environment and stores Terraform state and sensitive variables remotely. fileciteturn0file0L19-L23



Prerequisites



Before starting, you need:



Terraform CLI 1.2.0 or later



AWS CLI



An AWS account with credentials that can create resources in the us-west-2 region



The Terraform configuration and infrastructure from the previous tutorials fileciteturn0file0L25-L32



What We Will Do



Re-create the AWS infrastructure with Terraform.



Create an HCP Terraform account and organization.



Log in to HCP Terraform from the Terraform CLI.



Connect the local Terraform configuration to HCP Terraform.



Migrate the existing Terraform state to HCP Terraform.



Configure AWS credentials in the HCP Terraform workspace.



Run terraform apply remotely.



Destroy the infrastructure.



Delete the HCP Terraform workspace and project.



Step 1: Create the AWS Resources



Re-create the infrastructure from the previous tutorial:



terraform apply



Confirm the operation by entering:



yes



The example creates VPC-related resources and completes with 15 resources added. fileciteturn0file0L34-L79



Step 2: Create an HCP Terraform Account



Create an HCP Terraform account and organization. If you already have an account, you can use the existing organization. fileciteturn0file0L85-L92



Step 3: Log in with Terraform CLI



Run:



terraform login



Terraform opens the HCP Terraform token workflow in your browser. Generate an API token and paste it into the terminal when prompted. Terraform stores the CLI credentials locally for subsequent commands. fileciteturn0file0L93-L140



Step 4: Connect the Workspace to HCP Terraform



Update terraform.tf by adding a cloud block:



terraform {

&#x20; cloud {

&#x20;   organization = "your-organization-name"



&#x20;   workspaces {

&#x20;     project = "Learn Terraform"

&#x20;     name    = "learn-terraform-aws-get-started"

&#x20;   }

&#x20; }



&#x20; required\_providers {

&#x20;   aws = {

&#x20;     source  = "hashicorp/aws"

&#x20;     version = "\~> 5.92"

&#x20;   }

&#x20; }



&#x20; required\_version = ">= 1.2.0"

}



Replace your-organization-name with your HCP Terraform organization name. fileciteturn0file0L179-L216



Step 5: Migrate Terraform State



Re-initialize Terraform:



terraform init



Terraform will ask whether to migrate the existing state to HCP Terraform.



Enter:



yes



After successful initialization, the workspace state is migrated to HCP Terraform. fileciteturn0file0L218-L256



Step 6: Configure AWS Credentials



In the HCP Terraform workspace, open the Variables page.



Add these as Environment Variables and mark them Sensitive:



AWS\_ACCESS\_KEY\_ID

AWS\_SECRET\_ACCESS\_KEY



These credentials allow HCP Terraform to authenticate with AWS and provision the resources. fileciteturn0file0L258-L265



Security: Never commit AWS access keys or HCP Terraform API tokens to GitHub or other source-control repositories.



Step 7: Configure the EC2 Instance



Enable the EC2 instance configuration in main.tf:



resource "aws\_instance" "app\_server" {

&#x20; ami           = data.aws\_ami.ubuntu.id

&#x20; instance\_type = var.instance\_type



&#x20; vpc\_security\_group\_ids = \[module.vpc.default\_security\_group\_id]

&#x20; subnet\_id              = module.vpc.private\_subnets\[0]



&#x20; tags = {

&#x20;   Name = var.instance\_name

&#x20; }

}



Also enable the output in outputs.tf:



output "instance\_hostname" {

&#x20; description = "Private DNS name of the EC2 instance."

&#x20; value       = aws\_instance.app\_server.private\_dns

}



fileciteturn0file0L267-L300



Step 8: Run Terraform Remotely



Run:



terraform apply



HCP Terraform prepares and executes the run remotely while streaming the output to your terminal.



Confirm with:



yes



The HCP Terraform run can also be viewed from the URL displayed in the terminal. fileciteturn0file0L302-L357



Step 9: Destroy the Infrastructure



When the lab is complete, destroy the infrastructure:



terraform destroy



Confirm:



yes



The tutorial demonstrates a complete remote destroy operation through HCP Terraform. fileciteturn0file0L359-L413



Step 10: Delete the HCP Terraform Workspace



After destroying the infrastructure:



Open the HCP Terraform workspace.



Go to Settings > Destruction and Deletion.



Select Delete from HCP Terraform.



Follow the prompts.



If required, delete the associated project from its Settings page. fileciteturn0file0L417-L421



Key Commands



terraform login

terraform init

terraform plan

terraform apply

terraform destroy



Architecture / Workflow



Local Machine

&#x20;    |

&#x20;    | Terraform CLI

&#x20;    v

HCP Terraform

&#x20;    |

&#x20;    +--> Remote Terraform Plan

&#x20;    |

&#x20;    +--> Remote Terraform Apply

&#x20;    |

&#x20;    +--> Remote State Storage

&#x20;    |

&#x20;    v

AWS Infrastructure



Key Learning



HCP Terraform can execute Terraform operations remotely.



Terraform state can be stored remotely in HCP Terraform.



Terraform CLI can trigger HCP Terraform runs.



AWS credentials can be stored as sensitive workspace variables.



HCP Terraform supports CLI-driven, API-driven, and VCS-driven workflows. fileciteturn0file0L19-L23

