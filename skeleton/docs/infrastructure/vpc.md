# VPC (Virtual Private Cloud)

## 개요
이 문서는 AWS VPC 구성에 대한 상세 정보를 제공합니다.

## VPC 구성 요소
- CIDR 블록
- 서브넷
- 라우팅 테이블
- 인터넷 게이트웨이
- NAT 게이트웨이

## 구성 예시
```hcl
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  
  tags = {
    Name = "main-vpc"
  }
}
```

## 보안 그룹
- 인바운드 규칙
- 아웃바운드 규칙

## 모니터링
- VPC Flow Logs
- CloudWatch 지표

---
*이 문서는 자동 생성된 템플릿입니다. 실제 프로젝트에 맞게 수정해주세요.*
