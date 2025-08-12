# 문제 해결 가이드

## 개요
이 문서는 AWS Terraform 인프라 운영 중 발생할 수 있는 문제들과 해결 방법을 설명합니다.

## 일반적인 문제들

### 1. VPC 연결 문제
**증상**: 인스턴스 간 통신 불가
**해결 방법**:
- 보안 그룹 규칙 확인
- 라우팅 테이블 확인
- NACL 설정 확인

### 2. EKS 클러스터 문제
**증상**: 노드 그룹이 Ready 상태가 아님
**해결 방법**:
```bash
# 노드 상태 확인
kubectl get nodes
kubectl describe node [node-name]

# 로그 확인
kubectl logs -n kube-system [pod-name]
```

### 3. RDS 연결 문제
**증상**: 데이터베이스 연결 실패
**해결 방법**:
- 보안 그룹 설정 확인
- 서브넷 그룹 확인
- 엔드포인트 확인

## 로그 수집
```bash
# CloudWatch 로그 확인
aws logs describe-log-groups
aws logs filter-log-events --log-group-name [log-group]

# Terraform 상태 확인
terraform show
terraform state list
```

## 디버깅 도구
- AWS CLI
- Terraform CLI
- kubectl (EKS)
- CloudWatch Insights

## 지원 채널
- 팀 내부 Slack 채널
- AWS Support
- Terraform 커뮤니티

---
*이 문서는 자동 생성된 템플릿입니다. 실제 프로젝트에 맞게 수정해주세요.*
