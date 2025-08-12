# RDS 모듈 - 데이터베이스 구성
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# RDS 서브넷 그룹
resource "aws_db_subnet_group" "main" {
  name       = "${var.environment_name}-db-subnet-group"
  subnet_ids = var.private_subnet_ids

  tags = {
    Name        = "${var.environment_name}-db-subnet-group"
    Environment = var.environment_type
    Team        = var.team_name
  }
}

# RDS 파라미터 그룹
resource "aws_db_parameter_group" "main" {
  family = "${var.engine}${var.engine_version}"
  name   = "${var.environment_name}-db-parameter-group"

  dynamic "parameter" {
    for_each = var.db_parameters
    content {
      name  = parameter.value.name
      value = parameter.value.value
    }
  }

  tags = {
    Name        = "${var.environment_name}-db-parameter-group"
    Environment = var.environment_type
    Team        = var.team_name
  }
}

# RDS 옵션 그룹
resource "aws_db_option_group" "main" {
  count                = var.create_option_group ? 1 : 0
  name                 = "${var.environment_name}-db-option-group"
  engine_name          = var.engine
  major_engine_version = var.engine_version

  tags = {
    Name        = "${var.environment_name}-db-option-group"
    Environment = var.environment_type
    Team        = var.team_name
  }
}

# RDS 보안 그룹
resource "aws_security_group" "rds" {
  name_prefix = "${var.environment_name}-rds-"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = var.db_port
    to_port         = var.db_port
    protocol        = "tcp"
    security_groups = var.allowed_security_group_ids
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.environment_name}-rds-sg"
    Environment = var.environment_type
    Team        = var.team_name
  }
}

# RDS 인스턴스
resource "aws_db_instance" "main" {
  identifier = "${var.environment_name}-db"

  # 엔진 설정
  engine         = var.engine
  engine_version = var.engine_version
  instance_class = var.instance_class

  # 스토리지 설정
  allocated_storage     = var.allocated_storage
  max_allocated_storage = var.max_allocated_storage
  storage_type          = var.storage_type
  storage_encrypted     = var.storage_encrypted

  # 네트워크 설정
  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [aws_security_group.rds.id]
  port                   = var.db_port

  # 데이터베이스 설정
  db_name  = var.db_name
  username = var.db_username
  password = var.db_password

  # 백업 설정
  backup_retention_period = var.backup_retention_period
  backup_window          = var.backup_window
  maintenance_window     = var.maintenance_window

  # 성능 설정
  parameter_group_name = aws_db_parameter_group.main.name
  option_group_name    = var.create_option_group ? aws_db_option_group.main[0].name : null

  # 모니터링 설정
  monitoring_interval = var.monitoring_interval
  monitoring_role_arn = var.monitoring_role_arn

  # 삭제 보호
  deletion_protection = var.deletion_protection
  skip_final_snapshot = var.skip_final_snapshot

  # 태그
  tags = {
    Name        = "${var.environment_name}-db"
    Environment = var.environment_type
    Team        = var.team_name
  }
}

# RDS 클러스터 (Aurora용)
resource "aws_rds_cluster" "main" {
  count = var.create_cluster ? 1 : 0

  cluster_identifier = "${var.environment_name}-cluster"

  # 엔진 설정
  engine         = var.engine
  engine_version = var.engine_version

  # 데이터베이스 설정
  database_name   = var.db_name
  master_username = var.db_username
  master_password = var.db_password

  # 네트워크 설정
  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [aws_security_group.rds.id]
  port                   = var.db_port

  # 백업 설정
  backup_retention_period = var.backup_retention_period
  preferred_backup_window = var.backup_window
  preferred_maintenance_window = var.maintenance_window

  # 스토리지 설정
  storage_encrypted = var.storage_encrypted

  # 삭제 보호
  deletion_protection = var.deletion_protection
  skip_final_snapshot = var.skip_final_snapshot

  # 태그
  tags = {
    Name        = "${var.environment_name}-cluster"
    Environment = var.environment_type
    Team        = var.team_name
  }
}

# RDS 클러스터 인스턴스 (Aurora용)
resource "aws_rds_cluster_instance" "main" {
  count = var.create_cluster ? var.cluster_instance_count : 0

  identifier         = "${var.environment_name}-cluster-${count.index + 1}"
  cluster_identifier = aws_rds_cluster.main[0].id
  instance_class     = var.instance_class

  # 성능 설정
  performance_insights_enabled = var.performance_insights_enabled
  monitoring_interval          = var.monitoring_interval
  monitoring_role_arn          = var.monitoring_role_arn

  # 태그
  tags = {
    Name        = "${var.environment_name}-cluster-${count.index + 1}"
    Environment = var.environment_type
    Team        = var.team_name
  }
} 