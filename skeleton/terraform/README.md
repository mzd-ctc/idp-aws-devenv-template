# {{ values.project_name | title }} - {{ values.environment_type | upper }} Infrastructure

🏗️ **AWS Terraform Infrastructure for {{ values.project_name }} project in {{ values.environment_type }} environment**

## 📋 프로젝트 개요

- **팀**: {{ values.team_name }}
- **환경**: {{ values.environment_type }}
- **리전**: {{ values.aws_region }}
- **프로젝트**: {{ values.project_name }}
- **리소스 접두사**: {{ values.project_name }}

## 🏗️ 인프라 구성

### 생성되는 리소스

{% if values.create_eks == "true" %}
#### 🚢 EKS (Elastic Kubernetes Service)
- **클러스터명**: `{{ values.project_name }}-eks`
- **노드 타입**: t3.medium, t3.large
- **버전**: 최신 안정 버전
- **노드 그룹**: Auto Scaling Group 기반

{% endif %}
{% if values.create_rds == "true" %}
#### 🗄️ RDS (Relational Database Service)
- **엔진**: PostgreSQL
- **인스턴스 클래스**: db.t3.micro
- **스토리지**: GP3 (기본 20GB, 자동 확장)
- **백업**: 7일 보관, 자동 백업 활성화

{% endif %}
#### 🌐 VPC (Virtual Private Cloud)
- **CIDR 블록**: {{ values.vpc_cidr }}
- **서브넷**: 
  - Public Subnets (2개 AZ)
  - Private Subnets (2개 AZ)
- **NAT Gateway**: Private 서브넷을 위한 인터넷 접근
- **Internet Gateway**: Public 서브넷 인터넷 연결

## 🚀 시작하기

### 사전 요구사항

1. **AWS CLI** 설치 및 구성
   ```bash
   aws configure
   ```

2. **Terraform** 설치 (v1.5+)
   ```bash
   # macOS
   brew install terraform
   
   # Linux
   curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
   sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
   sudo apt-get update && sudo apt-get install terraform
   ```

3. **kubectl** 설치 (EKS 사용 시)
   ```bash
   # macOS
   brew install kubectl
   
   # Linux
   curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
   chmod +x kubectl
   sudo mv kubectl /usr/local/bin/
   ```

### 로컬 실행

1. **Terraform 초기화**
   ```bash
   cd terraform
   terraform init
   ```

2. **변수 확인**
   ```bash
   # terraform.tfvars 파일 확인
   cat terraform.tfvars
   ```

3. **계획 확인**
   ```bash
   terraform plan
   ```

4. **인프라 생성**
   ```bash
   terraform apply
   ```

5. **생성 확인**
   ```bash
   terraform output
   ```

### GitHub Actions 사용

#### 🔧 자동 설정된 Variables & Secrets

이 프로젝트는 Backstage Scaffolder를 통해 생성되었으며, 다음 Variables와 Secrets가 자동으로 설정되었습니다:

**📋 Variables (공개 변수):**
- `AWS_REGION`: AWS 리전 ({{ values.aws_region }})
- `TEAM_NAME`: 팀 이름 ({{ values.team_name }})
- `ENVIRONMENT_TYPE`: 환경 타입 ({{ values.environment_type }})
- `PROJECT_NAME`: 프로젝트명 ({{ values.project_name }})
- `VPC_CIDR`: VPC CIDR 블록 ({{ values.vpc_cidr }})
- `CREATE_EKS`: EKS 생성 여부 ({{ values.create_eks | string }})
- `CREATE_RDS`: RDS 생성 여부 ({{ values.create_rds | string }})

**🔐 Secrets (보안 변수):**
- `AWS_ACCESS_KEY_ID`: AWS Access Key ID
- `AWS_SECRET_ACCESS_KEY`: AWS Secret Access Key

#### 🚀 워크플로우 실행

1. **자동 실행**: `main` 브랜치에 푸시 시 자동으로 `plan` 실행
2. **수동 실행**: GitHub Actions → "Terraform CI/CD" → "Run workflow"
   - Action: `plan` (검토용) 또는 `apply` (배포용)

#### ⚙️ Variables/Secrets 수정

필요한 경우 GitHub 레포지토리 설정에서 Variables와 Secrets를 수정할 수 있습니다:

1. **Variables 수정**: Settings → Secrets and variables → Actions → Variables 탭
2. **Secrets 수정**: Settings → Secrets and variables → Actions → Secrets 탭

> 💡 **팁**: Variables는 공개적으로 볼 수 있으므로 민감한 정보는 Secrets에 저장하세요.

## 📁 프로젝트 구조

```
{{ values.github_repo }}/
├── terraform/
│   ├── main.tf              # 메인 Terraform 설정
│   ├── variables.tf         # 변수 정의
│   ├── outputs.tf           # 출력 값
│   ├── terraform.tfvars     # 환경별 변수값
│   └── modules/
│       ├── vpc/             # VPC 모듈
│       │   ├── main.tf
│       │   ├── variables.tf
│       │   └── outputs.tf
│       {% if values.create_eks == "true" %}
│       ├── eks/             # EKS 모듈
│       │   ├── main.tf
│       │   ├── variables.tf
│       │   └── outputs.tf
│       {% endif %}
│       {% if values.create_rds == "true" %}
│       └── rds/             # RDS 모듈
│           ├── main.tf
│           ├── variables.tf
│           └── outputs.tf
│       {% endif %}
├── .github/workflows/
│   └── terraform.yml        # CI/CD 파이프라인
├── README.md                # 이 파일
├── .gitignore              # Git 제외 설정
└── catalog-info.yaml       # Backstage 카탈로그
```

## 🔧 모듈별 설정

### VPC 모듈
- **CIDR**: {{ values.vpc_cidr }}
- **AZ**: 2개 가용영역 사용
- **서브넷**: Public/Private 각 2개씩
- **태그**: 환경별 자동 태깅

{% if values.create_eks == "true" %}
### EKS 모듈
- **클러스터 버전**: 최신 안정 버전
- **노드 그룹**: Auto Scaling Group
- **인스턴스 타입**: t3.medium, t3.large
- **스케일링**: 최소 1, 최대 5 노드

{% endif %}
{% if values.create_rds == "true" %}
### RDS 모듈
- **엔진**: PostgreSQL
- **버전**: 최신 안정 버전
- **인스턴스**: db.t3.micro
- **스토리지**: GP3, 자동 확장
- **백업**: 7일 보관

{% endif %}
## 🔐 보안 설정

### 네트워크 보안
- **VPC**: 격리된 네트워크 환경
- **Security Groups**: 최소 권한 원칙
- **NACL**: 서브넷 레벨 접근 제어

### IAM 설정
- **EKS Service Account**: IRSA (IAM Roles for Service Accounts)
- **RDS**: 최소 권한 데이터베이스 접근

### 암호화
- **EBS**: 기본 암호화 활성화
- **RDS**: 저장 데이터 암호화
- **S3**: 객체 레벨 암호화

## 📊 모니터링 및 로깅

### CloudWatch
- **메트릭**: CPU, 메모리, 네트워크
- **로그**: 애플리케이션 로그 수집
- **알람**: 임계값 기반 알림

### AWS X-Ray
- **분산 추적**: 마이크로서비스 추적
- **성능 분석**: 병목 지점 식별

## 💰 비용 최적화

### 비용 관리 팁
1. **리소스 태깅**: 환경별 비용 추적
2. **Auto Scaling**: 수요에 따른 자동 확장
3. **Reserved Instances**: 장기 사용 시 할인
4. **Spot Instances**: 비용 절약 (개발환경)

### 예상 월 비용 ({{ values.environment_type }} 환경)
{% if values.create_eks == "true" %}
- **EKS**: ~$73/월 (관리 비용)
- **EC2 노드**: ~$30-150/월 (인스턴스 타입에 따라)
{% endif %}
{% if values.create_rds == "true" %}
- **RDS**: ~$15-100/월 (인스턴스 클래스에 따라)
{% endif %}
- **VPC**: ~$50/월 (NAT Gateway, 데이터 전송)
- **총 예상**: ~$100-300/월

## 🚨 문제 해결

### 일반적인 문제들

#### Terraform 오류
```bash
# 상태 확인
terraform state list

# 상태 새로고침
terraform refresh

# 특정 리소스 재생성
terraform taint aws_vpc.main
```

#### EKS 연결 문제
```bash
# kubeconfig 업데이트
aws eks update-kubeconfig --region {{ values.aws_region }} --name {{ values.project_name }}-eks

# 노드 상태 확인
kubectl get nodes
kubectl describe nodes
```

#### RDS 연결 문제
```bash
# 보안 그룹 확인
aws ec2 describe-security-groups --group-ids $(terraform output -raw rds_security_group_id)

# 엔드포인트 확인
terraform output rds_endpoint
```

## 🔄 업데이트 및 유지보수

### 정기 업데이트
1. **Terraform 버전**: 분기별 업데이트
2. **EKS 버전**: 6개월마다 업데이트
3. **RDS 버전**: 보안 패치 적용
4. **모듈 업데이트**: 최신 기능 활용

### 백업 및 복구
- **RDS**: 자동 백업 (7일)
- **EKS**: etcd 백업 (관리됨)
- **Terraform State**: S3 백엔드 사용

## 📞 지원 및 연락처

### 팀 정보
- **팀명**: {{ values.team_name }}
- **담당자**: {{ values.team_name }}@company.com
- **슬랙**: #{{ values.team_name }}-devops

### 유용한 링크
- [AWS Console](https://console.aws.amazon.com/)
- [Terraform 문서](https://www.terraform.io/docs)
- [EKS 문서](https://docs.aws.amazon.com/eks/)
- [RDS 문서](https://docs.aws.amazon.com/rds/)

---

**⚠️ 주의사항**: 이 인프라는 {{ values.environment_type }} 환경용입니다. 운영 환경에서는 추가적인 보안 검토가 필요합니다.

**📅 생성일**: {{ "now" | strftime("%Y-%m-%d") }}
**🔧 관리툴**: Terraform v1.5+
**🏢 관리팀**: {{ values.team_name }} 