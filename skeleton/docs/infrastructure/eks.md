# EKS (Elastic Kubernetes Service)

## 개요
이 문서는 AWS EKS 클러스터 구성에 대한 상세 정보를 제공합니다.

## EKS 클러스터 구성
- 클러스터 버전
- 노드 그룹
- Fargate 프로파일
- OIDC 제공자

## 구성 예시
```hcl
resource "aws_eks_cluster" "main" {
  name     = "main-cluster"
  role_arn = aws_iam_role.eks_cluster.arn
  
  vpc_config {
    subnet_ids = var.subnet_ids
  }
}
```

## 노드 그룹 관리
- Auto Scaling 그룹
- 스팟 인스턴스
- 온디맨드 인스턴스

## 보안
- IAM 역할
- 보안 그룹
- 네트워크 정책

## 모니터링
- CloudWatch 로그
- 메트릭 수집

---
*이 문서는 자동 생성된 템플릿입니다. 실제 프로젝트에 맞게 수정해주세요.*
