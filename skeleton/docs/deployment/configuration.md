# 설정 가이드

## 개요
이 문서는 AWS Terraform 인프라의 상세 설정 방법을 설명합니다.

## 환경별 설정

### 개발 환경 (dev)
```hcl
environment = "dev"
instance_type = "t3.micro"
allocated_storage = 20
```

### 스테이징 환경 (stg)
```hcl
environment = "stg"
instance_type = "t3.small"
allocated_storage = 50
```

### 운영 환경 (prod)
```hcl
environment = "prod"
instance_type = "t3.medium"
allocated_storage = 100
```

## 네트워크 설정
- CIDR 블록 범위
- 서브넷 분할
- 라우팅 테이블
- 보안 그룹 규칙

## 보안 설정
- IAM 역할 및 정책
- 암호화 설정
- 백업 정책
- 모니터링 설정

## 성능 튜닝
- 인스턴스 크기 조정
- 스토리지 최적화
- 캐싱 전략
- 로드 밸런싱

## 비용 최적화
- 리소스 태깅
- 자동 스케일링
- 스팟 인스턴스 활용
- 예약 인스턴스

---
*이 문서는 자동 생성된 템플릿입니다. 실제 프로젝트에 맞게 수정해주세요.*
