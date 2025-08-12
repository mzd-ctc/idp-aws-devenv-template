# RDS (Relational Database Service)

## 개요
이 문서는 AWS RDS 인스턴스 구성에 대한 상세 정보를 제공합니다.

## RDS 인스턴스 구성
- 엔진 타입 (PostgreSQL, MySQL, Aurora 등)
- 인스턴스 클래스
- 스토리지 설정
- 백업 설정

## 구성 예시
```hcl
resource "aws_db_instance" "main" {
  identifier = "main-db"
  engine    = "postgres"
  
  instance_class = "db.t3.micro"
  allocated_storage = 20
  
  db_name  = "mydb"
  username = "dbuser"
  password = var.db_password
}
```

## 고가용성
- Multi-AZ 배포
- 읽기 전용 복제본
- 자동 백업

## 보안
- 암호화
- VPC 보안 그룹
- IAM 데이터베이스 인증

## 모니터링
- CloudWatch 지표
- 성능 인사이트
- 느린 쿼리 로그

---
*이 문서는 자동 생성된 템플릿입니다. 실제 프로젝트에 맞게 수정해주세요.*
