# 배포 전제 조건

## 개요
이 문서는 AWS Terraform 인프라 배포를 위한 전제 조건을 설명합니다.

## 필수 도구
- Terraform CLI (v1.5+)
- AWS CLI
- Git
- Docker (선택사항)

## AWS 계정 설정
- AWS 계정 생성
- IAM 사용자 생성
- Access Key ID 및 Secret Access Key 발급
- 적절한 권한 부여

## IAM 권한
```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ec2:*",
        "eks:*",
        "rds:*",
        "s3:*",
        "iam:*"
      ],
      "Resource": "*"
    }
  ]
}
```

## 네트워크 요구사항
- 인터넷 연결
- 방화벽 설정
- VPN 접근 (필요시)

## 리소스 제한 확인
- AWS 서비스 제한
- 리전별 가용성
- 비용 예상치

---
*이 문서는 자동 생성된 템플릿입니다. 실제 프로젝트에 맞게 수정해주세요.*
