# AWS EKS Infrastructure with Terraform

This repository contains the **Infrastructure as Code (IaC)** used to provision the AWS infrastructure for my end-to-end EKS DevOps project.

The infrastructure is managed with **Terraform** using reusable modules and a GitLab CI/CD pipeline for validation, planning, deployment, and teardown.

## Infrastructure Workflow

```text
Infrastructure Change
        |
        v
   GitLab CI/CD
        |
        +--> terraform fmt
        |
        +--> TFLint
        |
        +--> terraform validate
        |
        v
   terraform plan
        |
        v
 Manual Approval
        |
        v
   terraform apply
        |
        v
   AWS Infrastructure
        |
        v
     Amazon EKS
```

## Key Features

- Infrastructure provisioned with Terraform
- Reusable Terraform modules
- Environment-specific configuration
- Amazon EKS infrastructure
- Automated Terraform validation and planning
- TFLint for Terraform code quality
- GitLab CI/CD for infrastructure workflows
- AWS authentication through GitLab OIDC
- Manual approval before infrastructure changes are applied
- Manual, confirmed destroy workflow

## Repository Structure

```text
iac-eks/
├── enviroment/
│   └── dev/              # Development environment configuration
├── modules/              # Reusable Terraform modules
├── .gitlab-ci.yml        # Infrastructure CI/CD pipeline
├── .tflint.hcl           # TFLint configuration
└── .gitignore
```

## CI/CD Pipeline

The GitLab pipeline uses the following stages:

```text
Validate
   ↓
Plan
   ↓
Apply
   ↓
Destroy
```

### Validate

Checks Terraform formatting, runs TFLint, and validates the Terraform configuration.

### Plan

Generates a Terraform execution plan so infrastructure changes can be reviewed before deployment.

### Apply

Applies the saved Terraform plan. This stage requires **manual approval** on the default branch.

### Destroy

Provides a manually triggered and confirmed workflow for removing the provisioned infrastructure.

## AWS Authentication

The pipeline uses **GitLab OIDC** to assume an AWS IAM role.

This avoids storing long-lived AWS access keys in the CI/CD pipeline and allows Terraform jobs to use temporary AWS credentials.

## Technologies

- Terraform
- AWS
- Amazon EKS
- GitLab CI/CD
- GitLab OIDC
- AWS IAM
- TFLint

## Related Repositories

- [code_source_eks](https://github.com/Odjeissi/code_source_eks) — Flask application and CI/CD pipeline
- [ks8](https://github.com/Odjeissi/ks8) — Kubernetes, GitOps, Prometheus, and Grafana configuration

## What This Repository Demonstrates

This repository demonstrates a structured Infrastructure as Code workflow where AWS infrastructure is validated, reviewed through Terraform plans, and deployed through a controlled CI/CD pipeline using short-lived OIDC authentication.
