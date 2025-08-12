variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "${{ values.aws_region }}"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "${{ values.vpc_cidr }}"
}

variable "project_name" {
  description = "Project name"
  type        = string
  default     = "${{ values.project_name }}"
}

variable "environment_type" {
  description = "Environment type"
  type        = string
  default     = "${{ values.environment_type }}"
}

variable "team_name" {
  description = "Team name"
  type        = string
  default     = "${{ values.team_name }}"
}

variable "create_eks" {
  description = "Whether to create EKS cluster"
  type        = string
  default     = "${{ values.create_eks }}"
}

variable "create_rds" {
  description = "Whether to create RDS instance"
  type        = string
  default     = "${{ values.create_rds }}"
} 