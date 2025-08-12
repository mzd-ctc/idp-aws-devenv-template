# RDS 모듈 변수 정의

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

variable "allowed_security_group_ids" {
  description = "List of security group IDs allowed to access RDS"
  type        = list(string)
  default     = []
}

# 데이터베이스 엔진 설정
variable "engine" {
  description = "Database engine"
  type        = string
  default     = "postgres"
  validation {
    condition     = contains(["postgres", "mysql", "aurora-postgresql", "aurora-mysql"], var.engine)
    error_message = "Engine must be postgres, mysql, aurora-postgresql, or aurora-mysql."
  }
}

variable "engine_version" {
  description = "Database engine version"
  type        = string
  default     = "15.4"
}

variable "db_name" {
  description = "Database name"
  type        = string
  default     = "appdb"
}

variable "db_username" {
  description = "Database master username"
  type        = string
  default     = "dbadmin"
  sensitive   = true
}

variable "db_password" {
  description = "Database master password"
  type        = string
  sensitive   = true
}

variable "db_port" {
  description = "Database port"
  type        = number
  default     = 5432
}

# 인스턴스 설정
variable "instance_class" {
  description = "Database instance class"
  type        = string
  default     = "db.t3.micro"
}

variable "allocated_storage" {
  description = "Allocated storage in GB"
  type        = number
  default     = 20
}

variable "max_allocated_storage" {
  description = "Maximum allocated storage in GB"
  type        = number
  default     = 100
}

variable "storage_type" {
  description = "Storage type"
  type        = string
  default     = "gp2"
  validation {
    condition     = contains(["gp2", "gp3", "io1"], var.storage_type)
    error_message = "Storage type must be gp2, gp3, or io1."
  }
}

variable "storage_encrypted" {
  description = "Enable storage encryption"
  type        = bool
  default     = true
}

# 백업 설정
variable "backup_retention_period" {
  description = "Backup retention period in days"
  type        = number
  default     = 7
}

variable "backup_window" {
  description = "Backup window"
  type        = string
  default     = "03:00-04:00"
}

variable "maintenance_window" {
  description = "Maintenance window"
  type        = string
  default     = "sun:04:00-sun:05:00"
}

# 모니터링 설정
variable "monitoring_interval" {
  description = "Monitoring interval in seconds"
  type        = number
  default     = 60
}

variable "monitoring_role_arn" {
  description = "IAM role ARN for monitoring"
  type        = string
  default     = null
}

variable "performance_insights_enabled" {
  description = "Enable Performance Insights"
  type        = bool
  default     = false
}

# 클러스터 설정 (Aurora용)
variable "create_cluster" {
  description = "Create Aurora cluster instead of single instance"
  type        = bool
  default     = false
}

variable "cluster_instance_count" {
  description = "Number of cluster instances"
  type        = number
  default     = 2
}

# 옵션 그룹 설정
variable "create_option_group" {
  description = "Create option group"
  type        = bool
  default     = false
}

variable "db_parameters" {
  description = "Database parameters"
  type = list(object({
    name  = string
    value = string
  }))
  default = []
}

# 삭제 보호
variable "deletion_protection" {
  description = "Enable deletion protection"
  type        = bool
  default     = false
}

variable "skip_final_snapshot" {
  description = "Skip final snapshot on deletion"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Additional tags for resources"
  type        = map(string)
  default     = {}
} 