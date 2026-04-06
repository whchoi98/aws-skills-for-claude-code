---
name: aws-cloudwatch
description: Monitor AWS with CloudWatch and CloudTrail without MCP. Use when the user asks about logs, metrics, alarms, or API audit trail.
---

# AWS CloudWatch & CloudTrail / AWS 모니터링 및 감사
# MCP 없이 boto3/CLI로 직접 모니터링합니다.

## When to Use / 사용 시점
- "로그 그룹 보여줘" / "Show log groups"
- "CloudWatch 메트릭 조회" / "Query CloudWatch metrics"
- "알람 상태 확인" / "Check alarm status"
- "API 호출 이력 조회" / "Show API call history"

## CloudWatch Logs / 로그

### List Log Groups / 로그 그룹 목록
```bash
aws logs describe-log-groups --query 'logGroups[].{Name:logGroupName,Size:storedBytes}'
```
```python
import boto3
logs = boto3.client('logs')
logs.describe_log_groups()
```

### Query Logs with Insights / Insights로 로그 쿼리
```bash
# Start query / 쿼리 시작
aws logs start-query \
  --log-group-names "/aws/lambda/my-function" \
  --start-time $(date -d '1 hour ago' +%s) \
  --end-time $(date +%s) \
  --query-string 'fields @timestamp, @message | filter @message like /ERROR/ | limit 50'

# Get results / 결과 조회
aws logs get-query-results --query-id <QUERY_ID>
```
```python
import time
response = logs.start_query(
    logGroupNames=['/aws/lambda/my-function'],
    startTime=int(time.time()) - 3600,
    endTime=int(time.time()),
    queryString='fields @timestamp, @message | filter @message like /ERROR/ | limit 50'
)
query_id = response['queryId']

# Wait and get results / 대기 후 결과 조회
time.sleep(5)
logs.get_query_results(queryId=query_id)
```

## CloudWatch Metrics / 메트릭

### Get Metric Data / 메트릭 데이터 조회
```python
cw = boto3.client('cloudwatch')

# EC2 CPU utilization / EC2 CPU 사용률
from datetime import datetime, timedelta
cw.get_metric_data(
    MetricDataQueries=[{
        'Id': 'cpu',
        'MetricStat': {
            'Metric': {
                'Namespace': 'AWS/EC2',
                'MetricName': 'CPUUtilization',
                'Dimensions': [{'Name': 'InstanceId', 'Value': 'i-1234567890abcdef0'}]
            },
            'Period': 300,
            'Stat': 'Average'
        }
    }],
    StartTime=datetime.utcnow() - timedelta(hours=1),
    EndTime=datetime.utcnow()
)
```

## CloudWatch Alarms / 알람

### List Active Alarms / 활성 알람 목록
```bash
aws cloudwatch describe-alarms --state-value ALARM \
  --query 'MetricAlarms[].{Name:AlarmName,State:StateValue,Reason:StateReason}'
```
```python
cw.describe_alarms(StateValue='ALARM')
```

### Alarm History / 알람 이력
```python
cw.describe_alarm_history(
    AlarmName='my-alarm',
    HistoryItemType='StateUpdate',
    MaxRecords=10
)
```

## CloudTrail / API 감사 추적

### Recent API Events / 최근 API 이벤트
```bash
aws cloudtrail lookup-events --max-results 10 \
  --query 'Events[].{Time:EventTime,Event:EventName,User:Username}'
```
```python
ct = boto3.client('cloudtrail', region_name='us-east-1')
ct.lookup_events(MaxResults=10)

# Filter by user / 사용자로 필터
ct.lookup_events(
    LookupAttributes=[{'AttributeKey': 'Username', 'AttributeValue': 'admin'}],
    MaxResults=20
)
```

### CloudTrail Lake Query / CloudTrail Lake 쿼리
```python
# Query across event data stores / 이벤트 데이터 스토어 전체 쿼리
ct.start_query(QueryStatement="""
    SELECT eventTime, eventName, userIdentity.arn
    FROM <EVENT_DATA_STORE_ID>
    WHERE eventTime > '2024-01-01'
    ORDER BY eventTime DESC
    LIMIT 100
""")
```

## Common Patterns / 일반적인 패턴

### Error Rate Dashboard / 에러율 대시보드
```python
# Lambda errors in last hour / 지난 1시간 Lambda 에러
logs.start_query(
    logGroupNames=['/aws/lambda/my-func'],
    startTime=int(time.time()) - 3600,
    endTime=int(time.time()),
    queryString='stats count(*) as total, sum(@message like /ERROR/) as errors by bin(5m)'
)
```
