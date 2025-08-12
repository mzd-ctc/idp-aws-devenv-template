# EKS 모듈 변수 정의

variable "environment_name" {
  description = "Environment name (e.g., team-a-dev)"
  type        = string
}

variable "environment_type" {
  description = "Environment type (dev, stg, prod)"
  type        = string
  validation {
    condition     = contains(["dev", "stg", "prod"], var.environment_type)
    error_message = "Environment type must be dev, stg, or prod."
  }
}

variable "team_name" {
  description = "Team name"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs"
  type        = list(string)
}

variable "kubernetes_version" {
  description = "Kubernetes version"
  type        = string
  default     = "1.28"
}

variable "public_access_cidrs" {
  description = "List of CIDR blocks for public access"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "node_group_desired_size" {
  description = "Desired number of worker nodes"
  type        = number
  default     = 2
}

variable "node_group_max_size" {
  description = "Maximum number of worker nodes"
  type        = number
  default     = 4
}

variable "node_group_min_size" {
  description = "Minimum number of worker nodes"
  type        = number
  default     = 1
}

variable "node_group_instance_types" {
  description = "List of instance types for worker nodes"
  type        = list(string)
  default     = ["t3.medium"]
}

variable "tags" {
  description = "Additional tags for resources"
  type        = map(string)
  default     = {}
} 