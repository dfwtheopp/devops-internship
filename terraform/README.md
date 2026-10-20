# Day 10 - Terraform

## About this project

For Day 10 of my DevOps internship, I am learning how to use Terraform to create and manage AWS infrastructure through code instead of setting everything up manually in the AWS console.

This project builds on the networking work I did on Day 9, where I learned about VPCs, subnets, route tables, Internet Gateways, and security groups.

The aim is to practise writing Terraform configuration, checking it for errors, reviewing the changes it plans to make, and understanding how Terraform keeps track of the resources it manages.

## What I am setting up

The configuration defines these AWS resources:

* **VPC:** A separate network for this Terraform exercise.
* **Public subnet:** A subnet designed for resources that may need internet access.
* **Private subnet:** A subnet without a direct route to the internet.
* **Internet Gateway:** Connects the VPC to the internet through the appropriate routes.
* **Route tables:** Control how traffic leaves the subnets.
* **Application security group:** Allows traffic on port 8000 from an approved IP address.
* **Database security group:** Allows PostgreSQL traffic on port 5432 from the application security group.

I am using a separate VPC for this exercise so I can practise managing the resources with Terraform without taking over the VPC I created manually on Day 9.

For now, I am focusing on the networking setup. I am not creating an EC2 instance, deploying the application, or setting up a database in this exercise.

## Files in this folder

* `main.tf` contains the AWS provider configuration and the resources.
* `variables.tf` contains values that can be configured, such as the region and network ranges.
* `outputs.tf` specifies the resource IDs Terraform should display.
* `terraform.tfvars.example` provides an example of the required variable configuration.
* `README.md` explains the project and the commands used.

## Running Terraform

I will run these commands from inside the `terraform` directory.

First, initialize Terraform:

```bash
terraform init
```

This prepares the working directory and downloads the AWS provider.

Next, format the configuration:

```bash
terraform fmt
```

Then check that the configuration is valid:

```bash
terraform validate
```

Once the configuration passes validation and AWS authentication is set up, I can review the proposed changes:

```bash
terraform plan
```

This is an important step because it shows which resources Terraform intends to create, change, or remove before anything is applied.

After reviewing the plan, I can create the resources by running:

```bash
terraform apply
```

I will review the proposed actions before approving them.

To check the outputs and inspect the infrastructure recorded in Terraform state, I can use:

```bash
terraform output
terraform show
```

## Terraform state and credentials

Terraform uses a state file to keep track of the resources it manages. This file is important because Terraform uses it when planning future changes.

State files may contain sensitive information, so I should not commit them to Git or share them publicly. I will also keep local variable files containing personal configuration out of the repository.

AWS credentials should be configured securely and must never be pasted into `main.tf` or committed to Git.

The `.terraform.lock.hcl` file should be committed so that the selected provider versions can be reproduced.

## Cleaning up

After practising with the infrastructure, I can preview what Terraform would delete by running:

```bash
terraform plan -destroy
```

If the plan is correct and I am ready to remove the resources, I can run:

```bash
terraform destroy
```

I must check the proposed deletions before confirming them and make sure I am only removing resources belonging to this exercise.

## Current scope

This project currently defines the network and security-group configuration. Since I have not deployed an application instance or database through Terraform, I will not claim that application access or database connectivity has been tested.
