# 설치 가이드

## 개요
이 문서는 AWS Terraform 인프라 설치 과정을 단계별로 안내합니다.

## 1단계: 저장소 클론
```bash
git clone https://github.com/[owner]/[repo].git
cd [repo]
```

## 2단계: Terraform 초기화
```bash
cd terraform
terraform init
```

## 3단계: 변수 설정
```bash
# terraform.tfvars 파일 생성 또는 수정
cp terraform.tfvars.example terraform.tfvars
```

## 4단계: 계획 확인
```bash
terraform plan
```

## 5단계: 인프라 생성
```bash
terraform apply
```

## 6단계: 출력 확인
```bash
terraform output
```

## 설치 후 확인사항
- VPC 생성 확인
- EKS 클러스터 상태 확인
- RDS 인스턴스 연결 확인
- 보안 그룹 설정 확인

## 문제 해결
- 로그 확인 방법
- 일반적인 오류 및 해결책
- 지원 채널

---
*이 문서는 자동 생성된 템플릿입니다. 실제 프로젝트에 맞게 수정해주세요.*
