---
name: aws-messaging
description: Manage AWS messaging services (SNS, SQS, MQ, Step Functions, Location) without MCP. Use when the user asks about queues, topics, messages, message brokers, or workflows.
---

# AWS Messaging & Integration / AWS 메시징 및 통합
# MCP 없이 boto3/CLI로 직접 메시징 서비스를 관리합니다.

## When to Use / 사용 시점
- "SQS 큐 목록" / "List SQS queues"
- "SNS 토픽 발행" / "Publish to SNS topic"
- "메시지 전송/수신" / "Send/receive messages"
- "Step Functions 워크플로" / "Step Functions workflows"

## SNS (Topics & Notifications) / SNS (토픽 및 알림)

```bash
# List topics / 토픽 목록
aws sns list-topics

# Publish message / 메시지 발행
aws sns publish --topic-arn <TOPIC_ARN> --message "Hello World"

# List subscriptions / 구독 목록
aws sns list-subscriptions-by-topic --topic-arn <TOPIC_ARN>

# Subscribe / 구독
aws sns subscribe --topic-arn <TOPIC_ARN> --protocol email --notification-endpoint user@example.com
```
```python
import boto3
sns = boto3.client('sns')

sns.list_topics()
sns.publish(TopicArn='arn:aws:sns:...', Message='Hello World')
sns.subscribe(TopicArn='arn:aws:sns:...', Protocol='email', Endpoint='user@example.com')
sns.list_subscriptions_by_topic(TopicArn='arn:aws:sns:...')
```

## SQS (Queues) / SQS (대기열)

```bash
# List queues / 대기열 목록
aws sqs list-queues

# Send message / 메시지 전송
aws sqs send-message --queue-url <URL> --message-body "Hello"

# Receive messages / 메시지 수신
aws sqs receive-message --queue-url <URL> --max-number-of-messages 10

# Get queue attributes / 대기열 속성
aws sqs get-queue-attributes --queue-url <URL> --attribute-names All

# Purge queue / 대기열 비우기
aws sqs purge-queue --queue-url <URL>
```
```python
sqs = boto3.client('sqs')

sqs.list_queues()
sqs.send_message(QueueUrl='https://sqs...', MessageBody='Hello')
sqs.receive_message(QueueUrl='https://sqs...', MaxNumberOfMessages=10)

# Send batch / 배치 전송
sqs.send_message_batch(
    QueueUrl='https://sqs...',
    Entries=[
        {'Id': '1', 'MessageBody': 'msg1'},
        {'Id': '2', 'MessageBody': 'msg2'},
    ]
)

# Dead letter queue check / 배달 못한 편지 대기열 확인
sqs.list_dead_letter_source_queues(QueueUrl='https://sqs...')
```

## Amazon MQ (RabbitMQ/ActiveMQ) / 메시지 브로커

```bash
# List brokers / 브로커 목록
aws mq list-brokers

# Describe broker / 브로커 상세
aws mq describe-broker --broker-id <BROKER_ID>
```
```python
mq = boto3.client('mq')
mq.list_brokers()
mq.describe_broker(BrokerId='broker-id')
mq.describe_broker_engine_types()
mq.describe_broker_instance_options()
```

## Step Functions / 워크플로

```bash
# List state machines / 상태 머신 목록
aws stepfunctions list-state-machines

# Start execution / 실행 시작
aws stepfunctions start-execution \
  --state-machine-arn <ARN> \
  --input '{"key": "value"}'

# List executions / 실행 목록
aws stepfunctions list-executions --state-machine-arn <ARN> --status-filter RUNNING
```
```python
sfn = boto3.client('stepfunctions')
sfn.list_state_machines()
sfn.start_execution(stateMachineArn='arn:...', input='{"key":"value"}')
sfn.list_executions(stateMachineArn='arn:...', statusFilter='RUNNING')
```

## Amazon Location / 위치 서비스

```python
location = boto3.client('location')

# Search places / 장소 검색
location.search_place_index_for_text(IndexName='default', Text='Seoul Station')

# Geocode / 지오코딩
location.search_place_index_for_position(IndexName='default', Position=[126.9718, 37.5519])

# Calculate route / 경로 계산
location.calculate_route(
    CalculatorName='default',
    DeparturePosition=[126.97, 37.55],
    DestinationPosition=[127.02, 37.50]
)
```
