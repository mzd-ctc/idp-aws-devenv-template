# 모니터링 가이드

## 개요
이 문서는 AWS Terraform 인프라의 모니터링 설정 및 운영 방법을 설명합니다.

## CloudWatch 모니터링

### 기본 지표
- CPU 사용률
- 메모리 사용률
- 네트워크 트래픽
- 디스크 I/O

### 커스텀 지표
```bash
# 커스텀 지표 전송 예시
aws cloudwatch put-metric-data \
  --namespace "CustomMetrics" \
  --metric-data MetricName=CustomMetric,Value=123
```

## 로그 모니터링
- CloudWatch Logs
- VPC Flow Logs
- RDS 로그
- EKS 로그

## 알람 설정
```yaml
# CloudWatch 알람 예시
- name: "HighCPUUsage"
  threshold: 80
  period: 300
  evaluation_periods: 2
```

## 대시보드
- 운영 대시보드
- 개발자 대시보드
- 비용 대시보드

## 성능 모니터링
- 응답 시간
- 처리량
- 오류율
- 가용성

---
*이 문서는 자동 생성된 템플릿입니다. 실제 프로젝트에 맞게 수정해주세요.*
