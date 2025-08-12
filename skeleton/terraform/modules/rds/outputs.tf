# RDS 모듈 출력값 정의

output "db_instance_id" {
  description = "The ID of the RDS instance"
  value       = var.create_cluster ? null : aws_db_instance.main.id
}

output "db_instance_endpoint" {
  description = "The endpoint of the RDS instance"
  value       = var.create_cluster ? null : aws_db_instance.main.endpoint
}

output "db_instance_address" {
  description = "The address of the RDS instance"
  value       = var.create_cluster ? null : aws_db_instance.main.address
}

output "db_instance_port" {
  description = "The port of the RDS instance"
  value       = var.create_cluster ? null : aws_db_instance.main.port
}

output "db_instance_arn" {
  description = "The ARN of the RDS instance"
  value       = var.create_cluster ? null : aws_db_instance.main.arn
}

output "db_instance_status" {
  description = "The status of the RDS instance"
  value       = var.create_cluster ? null : aws_db_instance.main.status
}

# Aurora 클러스터 출력값
output "db_cluster_id" {
  description = "The ID of the RDS cluster"
  value       = var.create_cluster ? aws_rds_cluster.main[0].id : null
}

output "db_cluster_endpoint" {
  description = "The endpoint of the RDS cluster"
  value       = var.create_cluster ? aws_rds_cluster.main[0].endpoint : null
}

output "db_cluster_reader_endpoint" {
  description = "The reader endpoint of the RDS cluster"
  value       = var.create_cluster ? aws_rds_cluster.main[0].reader_endpoint : null
}

output "db_cluster_port" {
  description = "The port of the RDS cluster"
  value       = var.create_cluster ? aws_rds_cluster.main[0].port : null
}

output "db_cluster_arn" {
  description = "The ARN of the RDS cluster"
  value       = var.create_cluster ? aws_rds_cluster.main[0].arn : null
}

output "db_cluster_status" {
  description = "The status of the RDS cluster"
  value       = var.create_cluster ? aws_rds_cluster.main[0].status : null
}

# 클러스터 인스턴스 출력값
output "db_cluster_instance_ids" {
  description = "List of RDS cluster instance IDs"
  value       = var.create_cluster ? aws_rds_cluster_instance.main[*].id : []
}

output "db_cluster_instance_endpoints" {
  description = "List of RDS cluster instance endpoints"
  value       = var.create_cluster ? aws_rds_cluster_instance.main[*].endpoint : []
}

# 공통 출력값
output "db_subnet_group_id" {
  description = "The ID of the DB subnet group"
  value       = aws_db_subnet_group.main.id
}

output "db_subnet_group_arn" {
  description = "The ARN of the DB subnet group"
  value       = aws_db_subnet_group.main.arn
}

output "db_parameter_group_id" {
  description = "The ID of the DB parameter group"
  value       = aws_db_parameter_group.main.id
}

output "db_parameter_group_arn" {
  description = "The ARN of the DB parameter group"
  value       = aws_db_parameter_group.main.arn
}

output "db_option_group_id" {
  description = "The ID of the DB option group"
  value       = var.create_option_group ? aws_db_option_group.main[0].id : null
}

output "db_option_group_arn" {
  description = "The ARN of the DB option group"
  value       = var.create_option_group ? aws_db_option_group.main[0].arn : null
}

output "db_security_group_id" {
  description = "The ID of the DB security group"
  value       = aws_security_group.rds.id
}

output "db_security_group_arn" {
  description = "The ARN of the DB security group"
  value       = aws_security_group.rds.arn
}

# 연결 정보 (민감한 정보)
output "db_connection_string" {
  description = "Database connection string"
  value = var.create_cluster ? (
    "postgresql://${var.db_username}:${var.db_password}@${aws_rds_cluster.main[0].endpoint}:${aws_rds_cluster.main[0].port}/${var.db_name}"
  ) : (
    "postgresql://${var.db_username}:${var.db_password}@${aws_db_instance.main.endpoint}:${aws_db_instance.main.port}/${var.db_name}"
  )
  sensitive = true
}

output "db_host" {
  description = "Database host"
  value       = var.create_cluster ? aws_rds_cluster.main[0].endpoint : aws_db_instance.main.endpoint
}

output "db_port" {
  description = "Database port"
  value       = var.create_cluster ? aws_rds_cluster.main[0].port : aws_db_instance.main.port
}

output "db_name" {
  description = "Database name"
  value       = var.db_name
}

output "db_username" {
  description = "Database username"
  value       = var.db_username
  sensitive   = true
} 