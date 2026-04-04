---
name: aws-cost
description: Analyze AWS costs, billing, and pricing without MCP. Use when the user asks about cost analysis, cost forecast, pricing lookup, or billing reports.
---

# AWS Cost & Billing Management / AWS 비용 및 청구 관리
# MCP 없이 boto3/CLI로 직접 비용을 분석합니다.

## When to Use / 사용 시점
- "이번 달 비용 보여줘" / "Show this month's costs"
- "서비스별 비용 분석" / "Cost breakdown by service"
- "비용 예측" / "Cost forecast"
- "가격 조회" / "Pricing lookup"

## Cost Explorer / 비용 탐색기

### Current Month Cost / 이번 달 비용
```bash
aws ce get-cost-and-usage \
  --time-period Start=$(date -d "$(date +%Y-%m-01)" +%Y-%m-%d),End=$(date +%Y-%m-%d) \
  --granularity MONTHLY \
  --metrics "BlendedCost" "UnblendedCost"
```
```python
import boto3
from datetime import date
ce = boto3.client('ce')

today = date.today()
first_day = today.replace(day=1).isoformat()

ce.get_cost_and_usage(
    TimePeriod={'Start': first_day, 'End': today.isoformat()},
    Granularity='MONTHLY',
    Metrics=['BlendedCost', 'UnblendedCost']
)
```

### Cost by Service / 서비스별 비용
```python
ce.get_cost_and_usage(
    TimePeriod={'Start': '2026-03-01', 'End': '2026-03-08'},
    Granularity='DAILY',
    Metrics=['BlendedCost'],
    GroupBy=[{'Type': 'DIMENSION', 'Key': 'SERVICE'}]
)
```

### Cost Forecast / 비용 예측
```python
ce.get_cost_forecast(
    TimePeriod={'Start': today.isoformat(), 'End': today.replace(month=today.month+1, day=1).isoformat()},
    Metric='BLENDED_COST',
    Granularity='MONTHLY'
)
```

### Cost by Tag / 태그별 비용
```python
ce.get_cost_and_usage(
    TimePeriod={'Start': first_day, 'End': today.isoformat()},
    Granularity='MONTHLY',
    Metrics=['BlendedCost'],
    GroupBy=[{'Type': 'TAG', 'Key': 'Environment'}]
)
```

## Pricing / 가격 조회

### Service Price Lookup / 서비스 가격 조회
```python
pricing = boto3.client('pricing', region_name='us-east-1')

# List services / 서비스 목록
pricing.describe_services(MaxResults=10)

# EC2 pricing example / EC2 가격 예시
pricing.get_products(
    ServiceCode='AmazonEC2',
    Filters=[
        {'Type': 'TERM_MATCH', 'Field': 'instanceType', 'Value': 't3.medium'},
        {'Type': 'TERM_MATCH', 'Field': 'location', 'Value': 'Asia Pacific (Seoul)'},
        {'Type': 'TERM_MATCH', 'Field': 'operatingSystem', 'Value': 'Linux'},
    ],
    MaxResults=5
)
```

## Billing / 청구

### Billing Groups / 청구 그룹
```python
billing = boto3.client('billingconductor')
billing.list_billing_groups()
billing.list_account_associations()
```

### Cost Anomaly Detection / 비용 이상 탐지
```python
ce.get_anomalies(
    DateInterval={'StartDate': '2026-03-01', 'EndDate': '2026-03-08'},
    MaxResults=10
)
```

### Free Tier Usage / 프리 티어 사용량
```python
ft = boto3.client('freetier')
ft.get_free_tier_usage()
```

## Quick Reference / 빠른 참조

| Task / 작업 | CLI Command / CLI 명령 |
|------|---------|
| Monthly cost / 월간 비용 | `aws ce get-cost-and-usage --time-period Start=2026-03-01,End=2026-03-31 --granularity MONTHLY --metrics BlendedCost` |
| Daily breakdown / 일별 분석 | Add `--granularity DAILY` |
| By service / 서비스별 | Add `--group-by Type=DIMENSION,Key=SERVICE` |
| By region / 리전별 | Add `--group-by Type=DIMENSION,Key=REGION` |
| By account / 계정별 | Add `--group-by Type=DIMENSION,Key=LINKED_ACCOUNT` |
