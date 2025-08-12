# AWS Terraform Infrastructure

Welcome to the AWS Terraform Infrastructure documentation.

## Overview

This infrastructure is built using Terraform and provides a scalable, secure, and maintainable AWS environment for your applications.

## Quick Start

1. **Prerequisites**
   - AWS CLI configured
   - Terraform installed (version >= 1.5)
   - Appropriate AWS permissions

2. **Installation**
   ```bash
   cd terraform
   terraform init
   terraform plan
   terraform apply
   ```

3. **Configuration**
   - Edit `terraform.tfvars` to customize your environment
   - Review `variables.tf` for available options

## Architecture

The infrastructure includes:

- **VPC**: Custom VPC with public and private subnets
- **EKS**: Kubernetes cluster (optional)
- **RDS**: Database instance (optional)
- **Security Groups**: Proper network security
- **IAM**: Least privilege access

## Components

- [VPC Configuration](infrastructure/vpc.md)
- [EKS Cluster](infrastructure/eks.md)
- [RDS Database](infrastructure/rds.md)

## Team Information

- **Team**: ${{ values.team_name }}
- **Environment**: ${{ values.environment_type }}
- **Project**: ${{ values.project_name }}

## Support

For issues and support, please visit our [GitHub repository](https://github.com/${{ values.github_owner }}/${{ values.github_repo }}).
