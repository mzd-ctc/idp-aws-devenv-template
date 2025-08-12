# API 참조

## 개요
이 문서는 AWS Terraform 인프라의 API 및 설정 옵션에 대한 상세 참조를 제공합니다.

## Terraform 변수

### 필수 변수
```hcl
variable "project_name" {
  description = "프로젝트 이름"
  type        = string
}

variable "environment_type" {
  description = "환경 타입 (dev, stg, prod)"
  type        = string
  default     = "dev"
}

variable "aws_region" {
  description = "AWS 리전"
  type        = string
  default     = "ap-northeast-2"
}
```

### 선택적 변수
```hcl
variable "create_eks" {
  description = "EKS 클러스터 생성 여부"
  type        = string
  default     = "false"
}

variable "create_rds" {
  description = "RDS 인스턴스 생성 여부"
  type        = string
  default     = "false"
}
```

## 출력 값
```hcl
output "vpc_id" {
  description = "생성된 VPC ID"
  value       = aws_vpc.main.id
}

output "eks_cluster_name" {
  description = "EKS 클러스터 이름"
  value       = aws_eks_cluster.main.name
}
```

## 리소스 타입
- `aws_vpc`: VPC 생성
- `aws_subnet`: 서브넷 생성
- `aws_eks_cluster`: EKS 클러스터
- `aws_db_instance`: RDS 인스턴스

## 태그 규칙
```hcl
tags = {
  Name        = "${var.project_name}-${var.environment_type}"
  Environment = var.environment_type
  Project     = var.project_name
  ManagedBy   = "terraform"
}
```

---
*이 문서는 자동 생성된 템플릿입니다. 실제 프로젝트에 맞게 수정해주세요.*
