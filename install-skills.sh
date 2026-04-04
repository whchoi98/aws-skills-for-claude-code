#!/usr/bin/env bash
set -euo pipefail

# Kiro CLI Global Skills Installer
# Works on macOS and Linux
# Usage: bash install-skills.sh

KIRO_DIR="${HOME}/.kiro"
SKILLS_DIR="${KIRO_DIR}/skills"
AGENTS_DIR="${KIRO_DIR}/agents"

echo "🔧 Installing Kiro CLI global skills..."
echo "   Target: ${SKILLS_DIR}"
echo ""

mkdir -p "${AGENTS_DIR}"

install_skill() {
  local name="$1"
  local dir="${SKILLS_DIR}/${name}"
  mkdir -p "${dir}"
  cat > "${dir}/SKILL.md"
  echo "  ✅ ${name}"
}


install_skill "arm-soc-migration" << 'EOF'
---
name: arm-soc-migration
description: Guides migration of code between Arm SoCs with architecture-aware analysis and safe migration practices. Use when mentioning Arm SoC, Cortex migration, embedded migration, or Arm architecture porting.
---

# Arm SoC Migration

## Overview
Migrate embedded, automotive, or general-purpose applications between Arm SoCs (e.g., Graviton → Raspberry Pi, NXP i.MX8 → NVIDIA Jetson Orin).

## Workflows
1. Discovery — Scan codebase for platform-specific code, compare architectures
2. Planning — Migration plan, risk assessment, performance impact analysis
3. Implementation — Refactor into HAL layers, update build systems
4. Validation — Cross-compilation, benchmarking, functional tests

## Key Rules
- Preserve behavior: no silent API or timing changes
- Isolate SoC-specific code in HAL layers
- Maintain safety properties and error handling
- Document all changes

## MCP Server Config (Docker)
```json
{
  "mcpServers": {
    "arm-mcp-server": {
      "command": "docker",
      "args": ["run", "--rm", "-i", "--pull=always", "armlimited/arm-mcp:latest"],
      "env": { "FASTMCP_LOG_LEVEL": "ERROR" }
    }
  }
}
```
EOF

install_skill "aws-agentcore" << 'EOF'
---
name: aws-agentcore
description: Build, test, and deploy AI agents using AWS Bedrock AgentCore with local development workflow. Use when mentioning AgentCore, Bedrock agents, or AI agent deployment on AWS.
---

# AWS Bedrock AgentCore

## Overview
Build and deploy AI agents using AWS Bedrock AgentCore. Supports Strands, Claude, OpenAI SDKs and Bedrock/OpenAI model providers. Infrastructure via CDK or Terraform.

## MCP Tools
- search_agentcore_docs - Search AgentCore documentation
- fetch_agentcore_doc - Retrieve specific doc pages
- manage_agentcore_runtime - Runtime configuration and deployment
- manage_agentcore_memory - Agent memory operations
- manage_agentcore_gateway - Gateway configuration

## Getting Started
1. Use `agentcore create` for new agent projects
2. Run `agentcore dev` for local development with hot reloading
3. Test locally before cloud deployment
4. Deploy with `agentcore deploy`

## Troubleshooting
- "Could not find entrypoint module" → Ensure `.bedrock_agentcore.yaml` exists
- "Port 8080 already in use" → CLI auto-tries next port
- "AWS authentication failed" → Run `aws login`
- "Model access denied" → Check Bedrock model permissions

## MCP Server Config
```json
{
  "mcpServers": {
    "agentcore": {
      "command": "uvx",
      "args": ["awslabs.agentcore-mcp-server@latest"]
    }
  }
}
```
EOF

install_skill "aws-amplify" << 'EOF'
---
name: aws-amplify
description: Build full-stack apps with AWS Amplify Gen 2 using TypeScript, guided workflows, and best practices. Use when mentioning Amplify, Amplify Gen 2, fullstack AWS app, Cognito auth, or GraphQL backend.
---

# AWS Amplify Gen 2

## Overview
Build full-stack applications with TypeScript code-first development. Covers auth, data models, storage, functions, AI/ML integration, and deployment.

## Workflow Phases
1. Backend: Create resources (auth, data, storage, functions)
2. Sandbox: Deploy to sandbox environment for testing
3. Frontend: Integrate with React, Next.js, Vue, Angular, Flutter, Swift
4. Production: Deploy to production

## Key Principles
- Always follow the amplify-workflow steering file
- Validate prerequisites (Node.js, npm, AWS credentials) first
- Execute phases one at a time with user confirmation
- Do not load phase steering files directly; use the orchestrator

## MCP Server Config
```json
{
  "mcpServers": {
    "aws-mcp": {
      "command": "uvx",
      "args": ["awslabs.aws-mcp@latest"]
    }
  }
}
```
EOF

install_skill "aws-cloudwatch" << 'EOF'
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
EOF

install_skill "aws-cost" << 'EOF'
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
EOF

install_skill "aws-data" << 'EOF'
---
name: aws-data
description: Query and manage AWS data services (DynamoDB, Aurora, Redshift, ElastiCache, Neptune, S3 Tables) without MCP. Use when the user asks about databases, caching, data queries, or data management.
---

# AWS Data Services / AWS 데이터 서비스
# MCP 없이 boto3/CLI로 직접 데이터 서비스를 관리합니다.

## When to Use / 사용 시점
- "DynamoDB 테이블 조회" / "Query DynamoDB tables"
- "Aurora 쿼리 실행" / "Run Aurora queries"
- "Redshift 데이터 조회" / "Query Redshift data"
- "ElastiCache 관리" / "Manage ElastiCache"

## DynamoDB

```bash
# List tables / 테이블 목록
aws dynamodb list-tables

# Scan table / 테이블 스캔
aws dynamodb scan --table-name my-table --max-items 10

# Query / 쿼리
aws dynamodb query --table-name my-table \
  --key-condition-expression "PK = :pk" \
  --expression-attribute-values '{":pk": {"S": "user#123"}}'

# Put item / 항목 추가
aws dynamodb put-item --table-name my-table \
  --item '{"PK": {"S": "user#123"}, "SK": {"S": "profile"}, "name": {"S": "John"}}'
```
```python
import boto3
ddb = boto3.client('dynamodb')

ddb.list_tables()
ddb.scan(TableName='my-table', Limit=10)
ddb.query(
    TableName='my-table',
    KeyConditionExpression='PK = :pk',
    ExpressionAttributeValues={':pk': {'S': 'user#123'}}
)

# Using resource API (simpler) / 리소스 API 사용 (더 간단)
table = boto3.resource('dynamodb').Table('my-table')
table.get_item(Key={'PK': 'user#123', 'SK': 'profile'})
table.put_item(Item={'PK': 'user#123', 'SK': 'profile', 'name': 'John'})
```

## Aurora PostgreSQL / MySQL (RDS Data API)

```python
rds = boto3.client('rds-data')

# Execute SQL / SQL 실행
rds.execute_statement(
    resourceArn='arn:aws:rds:...:cluster:...',
    secretArn='arn:aws:secretsmanager:...',
    database='mydb',
    sql='SELECT * FROM users LIMIT 10'
)

# With parameters / 파라미터 사용
rds.execute_statement(
    resourceArn='...', secretArn='...', database='mydb',
    sql='SELECT * FROM users WHERE id = :id',
    parameters=[{'name': 'id', 'value': {'longValue': 42}}]
)
```

## Amazon Redshift

```python
redshift_data = boto3.client('redshift-data')

# Execute query / 쿼리 실행
response = redshift_data.execute_statement(
    ClusterIdentifier='my-cluster',
    Database='mydb',
    DbUser='admin',
    Sql='SELECT * FROM sales ORDER BY amount DESC LIMIT 10'
)

# Get results / 결과 조회
import time
time.sleep(5)
redshift_data.get_statement_result(Id=response['Id'])

# List databases / 데이터베이스 목록
redshift_data.list_databases(ClusterIdentifier='my-cluster', Database='dev', DbUser='admin')
```

## ElastiCache / Valkey / Redis

```bash
# List replication groups / 복제 그룹 목록
aws elasticache describe-replication-groups

# List cache clusters / 캐시 클러스터 목록
aws elasticache describe-cache-clusters

# List serverless caches / 서버리스 캐시 목록
aws elasticache describe-serverless-caches
```
```python
ec = boto3.client('elasticache')
ec.describe_replication_groups()
ec.describe_cache_clusters()
ec.describe_serverless_caches()
```

## Amazon Neptune (Graph DB)

```python
neptune = boto3.client('neptunedata')

# OpenCypher query / OpenCypher 쿼리
neptune.execute_open_cypher_query(
    openCypherQuery='MATCH (n) RETURN n LIMIT 10'
)

# Gremlin query / Gremlin 쿼리
neptune.execute_gremlin_query(
    gremlinQuery='g.V().limit(10)'
)

# Get graph status / 그래프 상태
neptune.get_engine_status()
```

## S3 Tables

```python
s3t = boto3.client('s3tables')
s3t.list_table_buckets()
s3t.list_namespaces(tableBucketARN='arn:...')
s3t.list_tables(tableBucketARN='arn:...', namespace='default')
```

## Quick Reference / 빠른 참조

| Service / 서비스 | List / 목록 | Query / 쿼리 |
|---------|------|-------|
| DynamoDB | `aws dynamodb list-tables` | `aws dynamodb query --table-name T` |
| Aurora | `aws rds describe-db-clusters` | RDS Data API `execute_statement` |
| Redshift | `aws redshift describe-clusters` | Redshift Data API `execute_statement` |
| ElastiCache | `aws elasticache describe-replication-groups` | Connect via redis-cli |
| Neptune | `aws neptune describe-db-clusters` | neptune-data `execute_open_cypher_query` |
EOF

install_skill "aws-graviton-migration" << 'EOF'
---
name: aws-graviton-migration
description: Analyze source code for Graviton (Arm64) compatibility, identify issues, and suggest fixes for language runtimes and dependencies. Use when mentioning Graviton, Arm64 migration, x86 to Arm, or aarch64 porting.
---

# Graviton Migration

## Overview
Migrate workloads from x86 to AWS Graviton (Arm64). Scans code for x86-specific dependencies, checks Docker image compatibility, and suggests Arm-compatible alternatives.

## Steps
1. Check Dockerfiles with check_image/skopeo for Arm compatibility
2. Verify each package via knowledge_base_search for Arm support
3. Scan requirements.txt/dependencies line-by-line
4. Run migrate_ease_scan on codebase (C++, Python, Go, JS, Java)
5. Generate analysis report with recommendations
6. Get user confirmation before code changes

## Supported Languages
C++, Python, Go, JavaScript, Java

## MCP Server Config (Docker)
```json
{
  "mcpServers": {
    "arm-mcp-server": {
      "command": "docker",
      "args": ["run", "--rm", "-i", "--pull=always", "armswdev/arm-mcp:latest"],
      "env": { "FASTMCP_LOG_LEVEL": "ERROR" }
    }
  }
}
```

Requires Docker installed and running.
EOF

install_skill "aws-healthomics" << 'EOF'
---
name: aws-healthomics
description: Create, migrate, run, debug and optimize genomics workflows in AWS HealthOmics. Use when mentioning HealthOmics, WDL, CWL, Nextflow, genomics, or bioinformatics pipelines.
---

# AWS HealthOmics

## Overview
Create, migrate, run, debug and identify optimization opportunities for genomics workflows (WDL, Nextflow, CWL) in AWS HealthOmics.

## When to Use
- Creating workflows from Git repos or local files
- Running deployed HealthOmics workflows
- Batch runs (multiple samples)
- Migrating existing WDL/Nextflow workflows
- Diagnosing workflow creation issues or run failures
- Using public containers via ECR Pullthrough Caches

## Setup
1. Ensure valid AWS credentials
2. Get account number: `aws sts get-caller-identity`
3. Create `.healthomics/config.toml` with omics_iam_role and run_output_uri
4. Requires `uvx` installed

## MCP Server Config
```json
{
  "mcpServers": {
    "healthomics": {
      "command": "uvx",
      "args": ["awslabs.aws-healthomics-mcp-server@latest"],
      "env": {
        "AWS_PROFILE": "default",
        "AWS_REGION": "us-east-1"
      }
    }
  }
}
```
EOF

install_skill "aws-iac" << 'EOF'
---
name: aws-infrastructure-as-code
description: Build well-architected AWS infrastructure with CDK and CloudFormation - latest documentation, validation, compliance, and troubleshooting. Use when mentioning CDK, CloudFormation, cfn-lint, cfn-guard, or AWS IaC.
---

# AWS Infrastructure as Code

## Key Tools
- search_cdk_documentation / search_cdk_samples_and_constructs - CDK docs and code samples
- cdk_best_practices - Comprehensive CDK best practices
- read_iac_documentation_page - Full documentation pages
- validate_cloudformation_template - cfn-lint validation
- check_cloudformation_template_compliance - cfn-guard security compliance
- troubleshoot_cloudformation_deployment - Pattern-based failure analysis with CloudTrail
- search_cloudformation_documentation - CloudFormation docs

## CDK Development Workflow
1. Research: search_cdk_documentation + search_cdk_samples_and_constructs
2. Best Practices: cdk_best_practices
3. Write CDK Code
4. Synthesize: `cdk synth`
5. Validate: validate_cloudformation_template + check_cloudformation_template_compliance
6. Deploy: `cdk deploy`
7. Troubleshoot: troubleshoot_cloudformation_deployment (if needed)

## Best Practices
- Prefer L2 constructs, use L3 for patterns, avoid L1 unless necessary
- Search before coding to find proven patterns
- Always synthesize (`cdk synth`) to validate before deployment
- Check compliance before production
- Supports TypeScript, Python, Java, C#, Go

## MCP Server Config
```json
{
  "mcpServers": {
    "aws-iac": {
      "command": "uvx",
      "args": ["awslabs.aws-iac-mcp-server@latest"],
      "env": {
        "AWS_PROFILE": "default",
        "AWS_REGION": "us-east-1",
        "FASTMCP_LOG_LEVEL": "ERROR"
      }
    }
  }
}
```

Most features work without AWS credentials. Credentials only needed for deployment and troubleshooting.
EOF

install_skill "aws-iam" << 'EOF'
---
name: aws-iam
description: Manage AWS IAM users, roles, groups, and policies without MCP. Use when the user asks to list users, create roles, attach policies, manage access keys, or check IAM permissions.
---

# AWS IAM Management / AWS IAM 관리
# MCP 없이 boto3/CLI로 직접 IAM을 관리합니다.

## When to Use / 사용 시점
- "IAM 사용자 목록 보여줘" / "Show IAM users"
- "역할 만들어줘" / "Create a role"
- "정책 연결해줘" / "Attach a policy"
- "액세스 키 관리" / "Manage access keys"

## Available Operations / 사용 가능한 작업

### Users / 사용자
```bash
# List users / 사용자 목록
aws iam list-users

# Get user details / 사용자 상세정보
aws iam get-user --user-name <USERNAME>

# Create user / 사용자 생성
aws iam create-user --user-name <USERNAME>

# Delete user / 사용자 삭제
aws iam delete-user --user-name <USERNAME>
```

```python
import boto3
iam = boto3.client('iam')

# List users / 사용자 목록
iam.list_users()

# Get user details / 사용자 상세정보
iam.get_user(UserName='username')

# Create user / 사용자 생성
iam.create_user(UserName='username')
```

### Roles / 역할
```bash
# List roles / 역할 목록
aws iam list-roles

# Create role with trust policy / 신뢰 정책으로 역할 생성
aws iam create-role --role-name <ROLE_NAME> \
  --assume-role-policy-document file://trust-policy.json
```

```python
import json
# Create role / 역할 생성
trust_policy = {
    "Version": "2012-10-17",
    "Statement": [{
        "Effect": "Allow",
        "Principal": {"Service": "lambda.amazonaws.com"},
        "Action": "sts:AssumeRole"
    }]
}
iam.create_role(
    RoleName='my-role',
    AssumeRolePolicyDocument=json.dumps(trust_policy)
)
```

### Policies / 정책
```bash
# List customer policies / 고객 관리형 정책 목록
aws iam list-policies --scope Local

# Get policy document / 정책 문서 조회
aws iam get-policy-version --policy-arn <ARN> --version-id v1

# Attach policy to user / 사용자에 정책 연결
aws iam attach-user-policy --user-name <USER> --policy-arn <ARN>

# Attach policy to role / 역할에 정책 연결
aws iam attach-role-policy --role-name <ROLE> --policy-arn <ARN>
```

```python
# Attach managed policy / 관리형 정책 연결
iam.attach_user_policy(UserName='user', PolicyArn='arn:aws:iam::aws:policy/ReadOnlyAccess')
iam.attach_role_policy(RoleName='role', PolicyArn='arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess')

# Put inline policy / 인라인 정책 추가
iam.put_user_policy(UserName='user', PolicyName='my-policy', PolicyDocument=json.dumps(policy_doc))
```

### Groups / 그룹
```bash
aws iam list-groups
aws iam create-group --group-name <GROUP>
aws iam add-user-to-group --group-name <GROUP> --user-name <USER>
aws iam attach-group-policy --group-name <GROUP> --policy-arn <ARN>
```

### Access Keys / 액세스 키
```bash
aws iam create-access-key --user-name <USER>
aws iam delete-access-key --user-name <USER> --access-key-id <KEY_ID>
```

### Policy Simulation / 정책 시뮬레이션
```python
# Check if a principal can perform actions / 주체가 작업을 수행할 수 있는지 확인
iam.simulate_principal_policy(
    PolicySourceArn='arn:aws:iam::123456789012:user/testuser',
    ActionNames=['s3:GetObject', 's3:PutObject'],
    ResourceArns=['arn:aws:s3:::my-bucket/*']
)
```

## Notes / 참고
- All commands use the current AWS credentials / 모든 명령은 현재 AWS 자격 증명을 사용합니다
- IAM is a global service (no region needed) / IAM은 글로벌 서비스입니다 (리전 불필요)
- Use `--query` with CLI for filtered output / CLI에서 `--query`로 필터링된 출력 사용
EOF

install_skill "aws-infra" << 'EOF'
---
name: aws-infra
description: Manage AWS infrastructure (CloudFormation, Cloud Control API, ECS, EKS, Serverless) without MCP. Use when the user asks to create/list/manage AWS resources, deploy stacks, or manage containers.
---

# AWS Infrastructure Management / AWS 인프라 관리
# MCP 없이 boto3/CLI로 직접 인프라를 관리합니다.

## When to Use / 사용 시점
- "AWS 리소스 목록" / "List AWS resources"
- "CloudFormation 스택 관리" / "Manage CF stacks"
- "EKS 클러스터 정보" / "EKS cluster info"
- "ECS 서비스 상태" / "ECS service status"

## Cloud Control API (Any Resource) / 모든 리소스

### List/Get/Create Resources / 리소스 조회/생성
```python
import boto3
cc = boto3.client('cloudcontrol')

# List S3 buckets / S3 버킷 목록
cc.list_resources(TypeName='AWS::S3::Bucket')

# Get specific resource / 특정 리소스 조회
cc.get_resource(TypeName='AWS::S3::Bucket', Identifier='my-bucket')

# Create resource / 리소스 생성
import json
cc.create_resource(
    TypeName='AWS::S3::Bucket',
    DesiredState=json.dumps({"BucketName": "my-new-bucket"})
)
```
```bash
# List any resource type / 모든 리소스 타입 목록
aws cloudcontrol list-resources --type-name AWS::EC2::VPC
aws cloudcontrol list-resources --type-name AWS::Lambda::Function
aws cloudcontrol list-resources --type-name AWS::RDS::DBInstance
```

## CloudFormation / 스택 관리

### Stack Operations / 스택 작업
```bash
# List stacks / 스택 목록
aws cloudformation list-stacks --stack-status-filter CREATE_COMPLETE UPDATE_COMPLETE

# Describe stack / 스택 상세
aws cloudformation describe-stacks --stack-name my-stack

# Stack events / 스택 이벤트
aws cloudformation describe-stack-events --stack-name my-stack --max-items 20
```
```python
cf = boto3.client('cloudformation')
cf.list_stacks(StackStatusFilter=['CREATE_COMPLETE', 'UPDATE_COMPLETE'])
cf.describe_stacks(StackName='my-stack')
```

## EKS / Kubernetes 클러스터

### Cluster Management / 클러스터 관리
```bash
# List clusters / 클러스터 목록
aws eks list-clusters

# Describe cluster / 클러스터 상세
aws eks describe-cluster --name my-cluster

# List node groups / 노드 그룹 목록
aws eks list-nodegroups --cluster-name my-cluster

# Update kubeconfig / kubeconfig 업데이트
aws eks update-kubeconfig --name my-cluster --region ap-northeast-2
```
```python
eks = boto3.client('eks')
eks.list_clusters()
eks.describe_cluster(name='my-cluster')

# Get CloudWatch metrics for cluster / 클러스터 CloudWatch 메트릭 조회
cw = boto3.client('cloudwatch')
cw.get_metric_data(
    MetricDataQueries=[{
        'Id': 'pods',
        'MetricStat': {
            'Metric': {'Namespace': 'ContainerInsights', 'MetricName': 'pod_number_of_running_pods',
                       'Dimensions': [{'Name': 'ClusterName', 'Value': 'my-cluster'}]},
            'Period': 300, 'Stat': 'Average'
        }
    }],
    StartTime=datetime.utcnow() - timedelta(hours=1),
    EndTime=datetime.utcnow()
)
```

## ECS / 컨테이너 서비스

### Service Management / 서비스 관리
```bash
# List clusters / 클러스터 목록
aws ecs list-clusters

# List services / 서비스 목록
aws ecs list-services --cluster my-cluster

# Describe service / 서비스 상세
aws ecs describe-services --cluster my-cluster --services my-service

# List tasks / 태스크 목록
aws ecs list-tasks --cluster my-cluster --service-name my-service
```
```python
ecs = boto3.client('ecs')
ecs.list_clusters()
ecs.list_services(cluster='my-cluster')
ecs.describe_services(cluster='my-cluster', services=['my-service'])
```

## Lambda / 서버리스 함수

### Function Management / 함수 관리
```bash
# List functions / 함수 목록
aws lambda list-functions --query 'Functions[].{Name:FunctionName,Runtime:Runtime,Memory:MemorySize}'

# Invoke function / 함수 호출
aws lambda invoke --function-name my-func --payload '{"key":"value"}' output.json

# View logs / 로그 조회
aws logs tail /aws/lambda/my-func --since 1h --follow
```
```python
lam = boto3.client('lambda')
lam.list_functions()
lam.invoke(FunctionName='my-func', Payload=json.dumps({"key": "value"}))
```

## Support Cases / 지원 케이스
```python
support = boto3.client('support', region_name='us-east-1')
support.describe_cases(maxResults=10)
support.create_case(
    subject='Issue description',
    serviceCode='amazon-elastic-compute-cloud-linux',
    categoryCode='using-aws',
    severityCode='normal',
    communicationBody='Detailed description of the issue'
)
```
EOF

install_skill "aws-mcp" << 'EOF'
---
name: aws-mcp
description: Perform complex multi-step AWS tasks with real-time documentation, API execution, and Agent SOPs following AWS best practices. Use when mentioning AWS CLI, AWS API, AWS tasks, or AWS automation.
---

# Work with AWS

## Key Capabilities
- Execute 15,000+ AWS APIs with SigV4 authentication
- Search AWS documentation, best practices, and guides
- Pre-built Agent SOPs for complex workflows (VPC setup, Lambda deployment, etc.)
- Regional availability checks
- Cost management and optimization

## Tools
- search_documentation / read_documentation / recommend
- call_aws / suggest_aws_commands
- retrieve_agent_sop
- get_regional_availability / list_regions

## MCP Server Config
```json
{
  "mcpServers": {
    "aws-mcp": {
      "command": "uvx",
      "args": ["awslabs.aws-mcp@latest"],
      "env": {
        "AWS_PROFILE": "default",
        "AWS_REGION": "us-east-1"
      }
    }
  }
}
```

Requires AWS CLI v2+ and uv installed.
EOF

install_skill "aws-messaging" << 'EOF'
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
EOF

install_skill "aws-observability" << 'EOF'
---
name: aws-observability
description: Comprehensive AWS observability with CloudWatch Logs, Metrics, Alarms, Application Signals APM, CloudTrail auditing, and codebase observability gap analysis. Use when mentioning CloudWatch, observability, monitoring, logs, metrics, alarms, traces, or CloudTrail.
---

# AWS Observability

## Key Capabilities
- CloudWatch Logs Insights queries across up to 50 log groups
- Metrics & Alarms with recommended configurations
- Application Signals APM with distributed tracing and SLOs
- CloudTrail security auditing (Lake, CloudWatch Logs, Lookup Events)
- Codebase observability gap analysis (Python, Java, JS/TS, Go, Ruby, C#)

## MCP Servers
- awslabs.cloudwatch-mcp-server — Logs, Metrics, Alarms
- awslabs.cloudwatch-applicationsignals-mcp-server — APM, SLOs, tracing
- awslabs.cloudtrail-mcp-server — Security auditing
- awslabs.aws-documentation-mcp-server — AWS docs

## Scenario Routing
- Incident response / troubleshooting → incident-response workflow
- Log analysis → log-analysis workflow
- Alerting setup → alerting-setup workflow
- Performance monitoring → performance-monitoring workflow
- Security auditing → security-auditing workflow
- Observability gaps → observability-gap-analysis workflow

## MCP Server Config
```json
{
  "mcpServers": {
    "cloudwatch": {
      "command": "uvx",
      "args": ["awslabs.cloudwatch-mcp-server@latest"],
      "env": {
        "AWS_PROFILE": "default",
        "AWS_REGION": "us-east-1",
        "FASTMCP_LOG_LEVEL": "ERROR"
      }
    }
  }
}
```
EOF

install_skill "aws-sam" << 'EOF'
---
name: aws-sam-serverless
description: Build serverless applications with AWS SAM - init, build, deploy, local invoke, and logs. Use when mentioning SAM, serverless, Lambda deployment, or AWS serverless application model.
---

# AWS SAM

## MCP Tools
- sam_init - Create new SAM app
- sam_build - Build SAM app
- sam_deploy - Deploy SAM app
- sam_logs - Fetch deployed app logs
- sam_local_invoke - Locally invoke Lambda function

## Project Structure
```
├── infrastructure/
│   ├── cloudformation/
│   └── lambda/
│       └── api/
│           ├── app.py
│           └── requirements.txt
└── template.yaml
```

## Key Rules
- ALWAYS use SAM resource types (AWS::Serverless::Function, etc.)
- ALWAYS use Lambda Powertools via Layers, NEVER add to dependencies
- ALWAYS use version locking for dependencies
- ALWAYS create separate Lambda functions for each API
- Do NOT add boto3/botocore to dependencies (included in runtime)
- Use SAM policy templates for IAM permissions
- Add `.aws-sam` to `.gitignore`

## Create New App Workflow
1. sam_init with chosen runtime
2. Restructure: move functions to `infrastructure/lambda/`
3. Update CodeUri paths in template.yaml
4. sam_build to verify

## MCP Server Config
```json
{
  "mcpServers": {
    "aws-sam": {
      "command": "uvx",
      "args": ["awslabs.aws-serverless-mcp-server@latest"],
      "env": {
        "AWS_PROFILE": "default",
        "AWS_REGION": "us-east-1"
      }
    }
  }
}
```

Prerequisites: SAM CLI installed, optionally Docker/Finch.
EOF

install_skill "aws-security" << 'EOF'
---
name: aws-security
description: AWS security audit and account information without MCP. Use when the user asks about account info, session details, credential verification, or security posture.
---

# AWS Security & Account Info / AWS 보안 및 계정 정보
# MCP 없이 boto3/CLI로 직접 보안을 관리합니다.

## When to Use / 사용 시점
- "현재 AWS 계정 정보" / "Current AWS account info"
- "자격 증명 확인" / "Verify credentials"
- "보안 감사" / "Security audit"
- "리소스 태깅 확인" / "Check resource tagging"

## Account & Session Info / 계정 및 세션 정보

```bash
# Who am I? / 현재 자격 증명 확인
aws sts get-caller-identity

# Account aliases / 계정 별칭
aws iam list-account-aliases

# Current region / 현재 리전
aws configure get region
```
```python
import boto3
sts = boto3.client('sts')
identity = sts.get_caller_identity()
print(f"Account: {identity['Account']}")
print(f"ARN: {identity['Arn']}")
print(f"UserId: {identity['UserId']}")
```

## Security Audit / 보안 감사

### IAM Credential Report / IAM 자격 증명 보고서
```bash
aws iam generate-credential-report
aws iam get-credential-report --query 'Content' --output text | base64 -d
```

### Access Key Age Check / 액세스 키 경과 확인
```python
iam = boto3.client('iam')
users = iam.list_users()['Users']
for user in users:
    keys = iam.list_access_keys(UserName=user['UserName'])['AccessKeyMetadata']
    for key in keys:
        age = (datetime.now(key['CreateDate'].tzinfo) - key['CreateDate']).days
        print(f"  {user['UserName']}: {key['AccessKeyId']} ({age} days, {key['Status']})")
```

### MFA Status Check / MFA 상태 확인
```python
for user in iam.list_users()['Users']:
    mfa = iam.list_mfa_devices(UserName=user['UserName'])['MFADevices']
    status = 'MFA enabled' if mfa else 'NO MFA'
    print(f"  {user['UserName']}: {status}")
```

### Policy Simulation / 정책 시뮬레이션
```python
# Test what actions a user can perform / 사용자가 수행할 수 있는 작업 테스트
iam.simulate_principal_policy(
    PolicySourceArn='arn:aws:iam::123456789012:user/testuser',
    ActionNames=['s3:GetObject', 's3:PutObject', 'ec2:DescribeInstances'],
    ResourceArns=['*']
)
```

## Resource Discovery / 리소스 탐색

### Cloud Control API - Any Resource / 모든 리소스 조회
```python
cc = boto3.client('cloudcontrol')

# Common resource types to audit / 감사할 일반적인 리소스 타입
resource_types = [
    'AWS::EC2::Instance',
    'AWS::EC2::SecurityGroup',
    'AWS::S3::Bucket',
    'AWS::RDS::DBInstance',
    'AWS::Lambda::Function',
    'AWS::IAM::Role',
]

for rt in resource_types:
    try:
        result = cc.list_resources(TypeName=rt)
        count = len(result.get('ResourceDescriptions', []))
        print(f"  {rt}: {count} resources")
    except Exception:
        pass
```

### Tag Compliance Check / 태그 준수 확인
```bash
# Find untagged resources / 태그 없는 리소스 찾기
aws resourcegroupstaggingapi get-resources \
  --query 'ResourceTagMappingList[?Tags==`[]`].ResourceARN'
```

## Network Security / 네트워크 보안
```bash
# List security groups with open access / 개방된 보안 그룹 목록
aws ec2 describe-security-groups \
  --query 'SecurityGroups[?IpPermissions[?IpRanges[?CidrIp==`0.0.0.0/0`]]].{ID:GroupId,Name:GroupName}'

# List public subnets / 퍼블릭 서브넷 목록
aws ec2 describe-subnets \
  --query 'Subnets[?MapPublicIpOnLaunch==`true`].{ID:SubnetId,VPC:VpcId,CIDR:CidrBlock}'
```

## Quick Security Checklist / 빠른 보안 체크리스트

```python
# Run all checks / 모든 검사 실행
import boto3

def security_audit():
    iam = boto3.client('iam')

    # 1. Root account MFA / 루트 계정 MFA
    summary = iam.get_account_summary()['SummaryMap']
    print(f"Root MFA: {'YES' if summary['AccountMFAEnabled'] else 'NO'}")

    # 2. Users without MFA / MFA 없는 사용자
    for u in iam.list_users()['Users']:
        mfa = iam.list_mfa_devices(UserName=u['UserName'])['MFADevices']
        if not mfa:
            print(f"  No MFA: {u['UserName']}")

    # 3. Old access keys (>90 days) / 오래된 액세스 키 (>90일)
    from datetime import datetime, timezone
    for u in iam.list_users()['Users']:
        for k in iam.list_access_keys(UserName=u['UserName'])['AccessKeyMetadata']:
            age = (datetime.now(timezone.utc) - k['CreateDate']).days
            if age > 90:
                print(f"  Old key ({age}d): {u['UserName']} - {k['AccessKeyId']}")

    # 4. Unused roles / 미사용 역할
    for r in iam.list_roles()['Roles']:
        last_used = r.get('RoleLastUsed', {}).get('LastUsedDate')
        if not last_used:
            print(f"  Never used role: {r['RoleName']}")

security_audit()
```
EOF

install_skill "checkout" << 'EOF'
---
name: checkout-payments
description: Access Checkout.com payment processing APIs - payments, customers, disputes, issuing, workflows, and identity verification. Use when mentioning Checkout.com, payment processing, or Checkout API.
---

# Checkout.com Global Payments

## Key Tools
- docssearch — Search API operations by keyword
- openapilistOperations — List/filter operations by tag
- openapigetOperation — Get detailed endpoint documentation
- openapigetSchema — Retrieve request/response schemas
- markdownsearch — Search implementation guides

## API Coverage
- Payments: process, refund, capture, void
- Customers: profiles and payment instruments
- Disputes: chargeback management
- Issuing: card issuing and management
- Platforms: multi-entity and marketplace
- Workflows: automated business logic
- Identity Verification: KYC services

## MCP Server Config
```json
{
  "mcpServers": {
    "checkout": {
      "command": "npx",
      "args": ["-y", "@checkout/mcp-server"],
      "env": {
        "CKO_SECRET_KEY": "$CKO_SECRET_KEY"
      }
    }
  }
}
```
EOF

install_skill "cloud-architect" << 'EOF'
---
name: cloud-architect
description: Build AWS infrastructure with CDK in Python following AWS Well-Architected framework best practices. Use when mentioning AWS architecture, CDK Python, Well-Architected, or cloud infrastructure design.
---

# Cloud Architect

## Overview
AWS infrastructure with CDK in Python, following Well-Architected framework. Combines AWS APIs, pricing, knowledge base, and documentation access.

## MCP Servers
- awspricing: Real-time AWS pricing (uvx awslabs.aws-pricing-mcp-server)
- awsknowledge: AWS best practices (https://knowledge-mcp.global.api.aws)
- awsapi: AWS CLI commands (uvx awslabs.aws-api-mcp-server)
- context7: boto3 and CDK docs (npx @upstash/context7-mcp)
- fetch: Web content retrieval (uvx mcp-server-fetch)

## Key Principles
- CDK with Python, Well-Architected framework adherence
- snake_case for functions, PascalCase for classes
- Service-based project structure, single CDK app per service
- Lambda: Layered architecture (handler, service, model)
- Single stack per app for deployment atomicity
- L2 constructs default, L3 for patterns, L1 only when necessary

## Testing Strategy
- Unit Tests: Pure business logic with mocks (<1s)
- Integration Tests: Lambda locally with real AWS services (1-5s)
- CDK Testing: Fine-grained assertions and snapshot testing

## Best Practices
- Start with clear service boundaries
- Prefer L2 constructs
- Follow layered architecture for Lambda
- Write integration tests against real AWS services
- Use keyword arguments for clarity
- Apply CDK aspects for cross-cutting concerns (tagging)
EOF

install_skill "cloudwatch-appsignals" << 'EOF'
---
name: cloudwatch-application-signals
description: Monitor service health, analyze SLO compliance, and perform root cause analysis with CloudWatch Application Signals. Use when mentioning Application Signals, SLO monitoring, APM on AWS, or CloudWatch traces.
---

# CloudWatch Application Signals

## Key Tools
- audit_services - Primary service health auditing (use `auditors="all"` for root cause)
- audit_slos - SLO compliance monitoring
- audit_service_operations - Operation-specific analysis
- list_monitored_services / get_service_detail - Service discovery
- search_transaction_spans - 100% sampled OpenTelemetry spans
- query_sampled_traces - X-Ray traces (5% sampled)
- analyze_canary_failures - Synthetics canary analysis
- get_enablement_guide - Setup guidance

## Best Practices
- Start with audit tools for overview, then drill down
- Use wildcard patterns for discovery: `*payment*`
- Use Transaction Search for 100% trace visibility (not X-Ray's 5%)
- Use `auditors="all"` for root cause analysis
- Always specify time ranges

## Workflow: Service Health Investigation
1. audit_services with `*` to find issues
2. Deep dive into problematic service with `auditors="all"`

## MCP Server Config
```json
{
  "mcpServers": {
    "cloudwatch-appsignals": {
      "command": "uvx",
      "args": ["awslabs.cloudwatch-applicationsignals-mcp-server@latest"],
      "env": {
        "AWS_PROFILE": "default",
        "AWS_REGION": "us-east-1",
        "FASTMCP_LOG_LEVEL": "ERROR"
      }
    }
  }
}
```

Requires AWS credentials and Application Signals enabled in your account.
EOF

install_skill "code-review" << 'EOF'
---
name: code-review
description: Review changed code and provide feedback on quality, bugs, security, performance, and naming conventions. Use when mentioning code review, PR review, or code quality check.
---

# Code Review Skill / 코드 리뷰 스킬

Review changed code and provide feedback.

변경된 코드를 검토하고 피드백을 제공합니다.

## Checklist / 체크리스트
- [ ] Code quality and readability / 코드 품질 및 가독성
- [ ] Potential bugs and edge cases / 잠재적 버그 및 엣지 케이스
- [ ] Security vulnerabilities (OWASP Top 10) / 보안 취약점 (OWASP Top 10)
- [ ] Performance issues / 성능 문제
- [ ] Test coverage / 테스트 커버리지
- [ ] Naming convention compliance / 네이밍 규칙 준수

## Usage / 사용법
Run with `/code-review` command

`/code-review` 명령으로 실행
EOF

install_skill "datadog" << 'EOF'
---
name: datadog-observability
description: Query logs, metrics, traces, RUM events, incidents, and monitors from Datadog for production debugging and performance analysis. Use when mentioning Datadog, APM traces, RUM, or Datadog monitoring.
---

# Datadog Observability

## Key Tools
- search_datadog_logs - Search logs with filtering
- get_datadog_metric - Query time-series metrics
- search_datadog_spans / get_datadog_trace - APM traces
- search_datadog_rum_events - Real User Monitoring
- search_datadog_incidents / get_datadog_incident - Incident management
- search_datadog_monitors - Alerting monitors
- search_datadog_docs - Documentation search

## Query Syntax

### Logs: Tags (no @) vs Attributes (@ prefix)
- `service:api status:error` (tags)
- `@http.status_code:500 @user.id:abc` (attributes)

### Metrics: `aggregator:metric{filters} by {grouping}`
- `avg:system.cpu.user{env:prod} by {host}`

### APM: Reserved fields (no @) vs Span attributes (@)
- `service:api status:error` (reserved)
- `@duration:>100000000` (nanoseconds!)

### Duration Units
- Spans: nanoseconds (1ms = 1,000,000ns)
- Logs/RUM: milliseconds

## Best Practices
- Start with narrow time ranges (15m-1h)
- Use unified service tags (service, env, version)
- Use @ prefix correctly for attributes
- Check incidents first when investigating issues

## MCP Server Config
```json
{
  "mcpServers": {
    "datadog": {
      "command": "npx",
      "args": ["mcp-remote", "https://mcp.datadoghq.com/api/unstable/mcp-server/mcp"],
      "env": {
        "DD_API_KEY": "$DD_API_KEY",
        "DD_APP_KEY": "$DD_APP_KEY",
        "DD_SITE": "datadoghq.com"
      }
    }
  }
}
```
EOF

install_skill "dynatrace" << 'EOF'
---
name: dynatrace-observability
description: Query logs, metrics, traces, problems, and Kubernetes events from Dynatrace using DQL. Use when mentioning Dynatrace, DQL, Davis AI, or Dynatrace monitoring.
---

# Dynatrace Observability

## Key Tools
- execute_dql - Execute DQL queries against GRAIL data lake
- generate_dql_from_natural_language - Convert questions to DQL
- explain_dql / verify_dql - Understand and validate DQL
- find_entity_by_name - Find services, hosts, processes
- list_problems - Track active/closed problems
- chat_with_davis_copilot - Get Davis AI insights
- list_vulnerabilities - Security vulnerabilities
- get_kubernetes_events - K8s cluster events

## DQL Syntax
```dql
fetch <table> | filter <condition> | fields <columns> | summarize <agg> | sort | limit
```

### Critical Rules
- Strings use double quotes: `"ERROR"` ✅ `'ERROR'` ❌
- Summarize needs aggregation: `summarize count(), by:{x}`
- Multiple values use OR: `id == "A" or id == "B"`
- Always filter by time: `timestamp > now() - 1h`

### Common Patterns
```dql
-- Error analysis
fetch logs | filter loglevel == "ERROR" and timestamp > now() - 1h
| summarize cnt = count(), by:{k8s.deployment.name} | sort cnt desc

-- Service metrics
timeseries avg(dt.service.request.response_time),
from: now() - 6h, filter: dt.entity.service == "SERVICE-123"
```

## Best Practices
- Start with narrow time ranges (1h)
- Use find_entity_by_name before hardcoding IDs
- Ask Davis AI first before writing complex queries
- Use verify_dql before executing

## MCP Server Config
```json
{
  "mcpServers": {
    "dynatrace": {
      "command": "npx",
      "args": ["-y", "@dynatrace-oss/dynatrace-mcp-server@latest"],
      "env": {
        "DT_ENVIRONMENT": "https://your-tenant.apps.dynatrace.com",
        "DT_API_TOKEN": "$DT_API_TOKEN"
      }
    }
  }
}
```
EOF

install_skill "figma" << 'EOF'
---
name: figma-design-to-code
description: Connect Figma designs to code components - generate design system rules, map UI components to Figma designs, maintain design-code consistency. Use when mentioning Figma, design to code, UI mockup, or design system.
---

# Figma Design to Code

## Workflow
1. Call `create_design_system_rules` from Figma MCP server to generate workspace-specific design-system.md
2. Use get_code_connect_map to check if code is mapped to Figma component
3. Use add_code_connect_map to connect code to Figma component

## Integration Guidelines
- Treat Figma MCP output (React + Tailwind) as design/behavior representation, not final code
- Replace Tailwind utility classes with project's preferred design-system tokens
- Reuse existing components instead of duplicating
- Use project's color system, typography scale, and spacing tokens
- Respect existing routing, state management, and data-fetch patterns
- Strive for 1:1 visual parity with Figma design
- Validate final UI against Figma screenshot

## MCP Server Config
```json
{
  "mcpServers": {
    "figma": {
      "command": "npx",
      "args": ["-y", "figma-developer-mcp", "--stdio"],
      "env": {
        "FIGMA_API_KEY": "$FIGMA_API_KEY"
      }
    }
  }
}
```
EOF

install_skill "gcp-aws-migrate" << 'EOF'
---
name: gcp-aws-migrate
description: Guided 5-phase migration from Google Cloud Platform to AWS - Terraform discovery, requirements clarification, architecture design, cost estimation, and execution planning. Use when mentioning GCP to AWS migration, cloud migration, or re-platform.
---

# GCP to AWS Migration Advisor

## 5-Phase Process
1. Discover — Scan Terraform, app code, billing data for GCP resources
2. Clarify — Gather user requirements and preferences
3. Design — Map GCP services to AWS equivalents (re-platform by default)
4. Estimate — Cost comparison (cached pricing + AWS Pricing API)
5. Generate — Terraform configs, migration scripts, documentation

## Inputs (at least one required)
- Terraform .tf files
- Application source code with GCP SDK imports
- GCP billing/cost export (CSV or JSON)

## Defaults
- Re-platform approach (Cloud Run → Fargate, Cloud SQL → RDS)
- Dev sizing unless specified
- Region: us-east-1
- Timeline: 8-12 weeks

## MCP Server Config
```json
{
  "mcpServers": {
    "awspricing": {
      "command": "uvx",
      "args": ["awslabs.aws-pricing-mcp-server@latest"],
      "env": {
        "AWS_PROFILE": "default",
        "AWS_REGION": "us-east-1"
      }
    }
  }
}
```
EOF

install_skill "neon" << 'EOF'
---
name: neon-database
description: Serverless Postgres with database branching, autoscaling, and scale-to-zero via Neon. Use when mentioning Neon, Postgres database branching, serverless database, or PostgreSQL with branching.
---

# Neon Database

## Key Capabilities
- Database Branching: Isolated copies for dev/test/schema changes
- Project Management: Create and manage Neon projects
- Schema Management: Execute SQL, create tables, manage schema
- Connection Strings: Get connection strings for any project/branch
- Autoscaling and scale-to-zero for cost efficiency

## MCP Tools
- list_organizations, list_projects, create_project
- get_connection_string, list_branches, create_branch
- execute_sql

## Best Practices
- Use database branching for development and testing before production
- Create separate branches for each feature or migration
- Test schema changes on branches before applying to main
- Store connection strings in .env (never commit to version control)
- Name branches descriptively (e.g., "feature-auth", "migration-v2")
- Delete old branches after merging

## Common Workflows

### Safe Schema Migration
1. Create migration branch from main
2. Test schema changes on branch
3. Verify with test queries
4. Apply to main if tests pass

### Multi-Environment Setup
1. Get main project connection (prod)
2. Create development branch
3. Create staging branch
4. Get connection strings for each environment

## MCP Server Config
```json
{
  "mcpServers": {
    "neon": {
      "command": "npx",
      "args": ["-y", "mcp-remote", "https://mcp.neon.tech/mcp"]
    }
  }
}
```

No API keys required - authentication via Neon CLI or browser login.
EOF

install_skill "postman" << 'EOF'
---
name: postman-api-testing
description: Automate API testing and collection management with Postman - create workspaces, collections, environments, and run tests. Use when mentioning Postman, API testing, API collections, or API automation.
---

# Postman API Testing

## Key Tools (Minimal Mode - 40 tools)
- Workspace: createWorkspace, getWorkspace, getWorkspaces
- Collection: createCollection, getCollection, putCollection, createCollectionRequest, runCollection
- Environment: createEnvironment, getEnvironment, getEnvironments
- Mock: createMock, getMock, publishMock
- Spec: createSpec, getSpec, generateCollection, syncCollectionWithSpec
- Testing: runCollection

## Common Workflows

### Project Setup
1. Create workspace
2. Create collection with schema
3. Create environment (local/staging/prod)
4. Save IDs to .postman.json

### Generate from OpenAPI
1. Create spec with OpenAPI definition
2. Generate collection from spec
3. Sync collection with spec on changes

### Automated Testing
1. Get workspaces and collections
2. Run collection with environment
3. Review results and fix errors

## Best Practices
- Store workspace/collection/environment IDs in `.postman.json`
- Use environment variables for different contexts
- Add post-request test scripts for validation
- Run collections before deployment
- Ensure API server is running before tests

## MCP Server Config
```json
{
  "mcpServers": {
    "postman": {
      "url": "https://mcp.postman.com/minimal",
      "headers": {
        "Authorization": "Bearer $POSTMAN_API_KEY"
      }
    }
  }
}
```

Change URL to `https://mcp.postman.com/full` for 112 tools.
EOF

install_skill "power-builder" << 'EOF'
---
name: power-builder
description: Complete guide for building and testing new Kiro Powers with templates, best practices, and validation. Use when mentioning power builder, create power, build power, or Kiro power development.
---

# Power Builder

## Overview
Guide for building Kiro Powers. Two types:
- **Guided MCP Power** — MCP server config + documentation (has mcp.json)
- **Knowledge Base Power** — Pure documentation (no mcp.json)

## Power Structure
```
my-power/
├── POWER.md       # Required: metadata + documentation
├── mcp.json       # Required for Guided MCP Powers only
└── steering/      # Optional: workflow guides
```

## POWER.md Frontmatter (5 fields only)
```yaml
---
name: "power-name"
displayName: "Human Readable Name"
description: "Clear description (max 3 sentences)"
keywords: ["keyword1", "keyword2"]
author: "Your Name"
---
```

## Best Practices
- Default to single power (only split with strong conviction)
- Use kebab-case for power names
- Include 5-7 keywords
- Document exact MCP tool names
- Create steering/ only when POWER.md >500 lines
- No MCP server needed for Knowledge Base Powers
EOF

install_skill "refactor" << 'EOF'
---
name: refactor
description: Refactor existing code to improve quality using SRP, DRY, and incremental steps. Use when mentioning refactoring, code cleanup, or code improvement.
---

# Refactor Skill / 리팩토링 스킬

Refactor existing code to improve quality.

기존 코드를 리팩토링하여 품질을 개선합니다.

## Principles / 원칙
- Improve structure without changing behavior / 동작 변경 없이 구조 개선
- Apply Single Responsibility Principle (SRP) / 단일 책임 원칙(SRP) 적용
- Remove duplicate code (DRY) / 중복 코드 제거 (DRY)
- Refactor in small, incremental steps / 작고 점진적인 단계로 리팩토링

## Usage / 사용법
Run with `/refactor` command

`/refactor` 명령으로 실행
EOF

install_skill "release" << 'EOF'
---
name: release
description: Automate the release process with semver, CHANGELOG, tags, and release notes. Use when mentioning release, versioning, changelog, or tagging.
---

# Release Skill / 릴리스 스킬

Automate the release process.

릴리스 프로세스를 자동화합니다.

## Procedure / 절차
1. Review changes (git log) / 변경사항 검토 (git log)
2. Determine version number (semver) / 버전 번호 결정 (semver)
3. Update CHANGELOG / CHANGELOG 업데이트
4. Create tag / 태그 생성
5. Write release notes / 릴리스 노트 작성

## Usage / 사용법
Run with `/release` command

`/release` 명령으로 실행
EOF

install_skill "saas-builder" << 'EOF'
---
name: saas-builder
description: Build production-ready multi-tenant SaaS applications with serverless architecture, integrated billing, and enterprise-grade security. Use when mentioning SaaS, multi-tenant, tenant isolation, or SaaS billing.
---

# SaaS Builder

## Core Architecture
- Multi-tenant with tenant isolation at data layer
- Serverless-first: Lambda, API Gateway, DynamoDB
- Integrated billing with Stripe and usage metering
- JWT auth with RBAC
- React + TypeScript frontend with Tailwind CSS

## Multi-Tenancy Pattern
- Tenant ID prefix in all DB keys: `${tenantId}#${entityType}#${id}`
- Lambda authorizer injects tenant context from JWT
- No cross-tenant data access
- Tenant-specific feature flags and quotas

## Project Structure
```
├── frontend/          # React + TypeScript + Tailwind
├── backend/
│   ├── functions/     # Lambda handlers (authorizer, api, billing)
│   ├── lib/           # Business logic
│   └── infrastructure/# IaC (CDK/SAM)
├── schema/            # OpenAPI contracts
└── .kiro/
```

## Lambda Function Pattern
1. Extract tenant context from authorizer
2. Extract user roles
3. Validate parameters
4. Check permissions (RBAC)
5. Prefix DB operations with tenant ID
6. Return proper status codes
7. Log with tenant context

## Billing Rules
- Integer cents only (never floats): `amount_cents: 1999`
- Currency code with every amount
- Stripe for payments, webhook verification, idempotency
- Subscription states: trial, active, past_due, canceled, expired

## MCP Servers
- fetch, stripe, aws-knowledge-mcp-server
- awslabs.dynamodb-mcp-server, awslabs.aws-serverless-mcp
- playwright (disabled by default)
EOF

install_skill "spark-troubleshooting" << 'EOF'
---
name: spark-troubleshooting
description: Troubleshoot Spark applications on AWS EMR, Glue, and SageMaker - analyze failures, identify bottlenecks, get code recommendations. Use when mentioning Spark, EMR, PySpark, Glue Spark, or Spark troubleshooting.
---

# Spark Troubleshooting Agent

## Key Capabilities
- Failure analysis for PySpark and Scala jobs
- Root cause identification via telemetry correlation
- Performance diagnostics and bottleneck detection
- Code recommendations and optimizations
- Supports EMR EC2, EMR Serverless, Glue, SageMaker

## MCP Servers
- sagemaker-unified-studio-mcp-troubleshooting — Failure analysis
- sagemaker-unified-studio-mcp-code-rec — Code recommendations

## Best Practices
- Provide specific identifiers (cluster ID, application ID, job ID)
- Describe symptoms clearly (observed vs expected)
- Include exact error messages
- Specify platform (EMR EC2, EMR Serverless, Glue, SageMaker)

## Setup
Requires CloudFormation stack deployment for IAM role. See AWS docs for setup.
EOF

install_skill "stackgen" << 'EOF'
---
name: stackgen-iac
description: Design, manage, and deploy cloud infrastructure with StackGen - create appstacks, manage resources, configure environments, and push IaC to Git. Use when mentioning StackGen, appstack, or multi-cloud IaC.
---

# StackGen Infrastructure as Code

## Key Tools
- Appstack: get_appstacks, create_appstack, copy_topology, get_appstack_resources
- Resources: add_resource_to_appstack, update_resource, delete_resource, connect_resources
- Environments: get_env_profiles, create_env_profile, update_env_profile
- Git: list_git_configuration, add_git_configuration, push_appstack_to_git
- Policy: get_policies, get_current_violations

## Workflow
1. create_appstack (AWS, Azure, or GCP)
2. add_resource_to_appstack
3. connect_resources (dependencies)
4. create_env_profile (dev/staging/prod)
5. push_appstack_to_git

## MCP Server Config
```json
{
  "mcpServers": {
    "stackgen": {
      "command": "npx",
      "args": ["-y", "mcp-remote", "https://mcp.stackgen.com/mcp"]
    }
  }
}
```
EOF

install_skill "strands" << 'EOF'
---
name: strands-agents-sdk
description: Build AI agents with Strands SDK using Bedrock, Anthropic, OpenAI, Gemini, or Llama models. Use when mentioning Strands SDK, AI agent building, or multi-provider LLM agents.
---

# Strands Agents SDK

## Overview
Build AI agents with tool calling, conversation context, and multiple LLM providers. Default provider is Amazon Bedrock.

## MCP Tools
- search_docs - Search Strands documentation
- fetch_doc - Fetch full documentation by URL

## Quick Setup (Bedrock)
```bash
export AWS_BEDROCK_API_KEY=your_key
pip install strands-agents strands-agents-tools
```

## Other Providers
- Anthropic: `pip install 'strands-agents[anthropic]'` + `ANTHROPIC_API_KEY`
- OpenAI: `pip install 'strands-agents[openai]'` + `OPENAI_API_KEY`
- Gemini: `pip install 'strands-agents[gemini]'` + `GOOGLE_API_KEY`
- Llama: `pip install 'strands-agents[llamaapi]'` + `LLAMA_API_KEY`

## Best Practices
- Use Bedrock as default provider
- Install only needed provider extensions
- Always install community tools: `pip install strands-agents-tools`
- Set API keys as environment variables
- Use clear docstrings for custom tools (models read them)
- Use @tool decorator for custom tools
- Lower temperature (0.1-0.3) for factual tasks

## MCP Server Config
```json
{
  "mcpServers": {
    "strands-agents": {
      "command": "uvx",
      "args": ["strands-agents-mcp-server"]
    }
  }
}
```
EOF

install_skill "stripe" << 'EOF'
---
name: stripe-payments
description: Build payment integrations with Stripe - Checkout Sessions, Payment Intents, subscriptions, billing, refunds. Use when mentioning payments, checkout, subscriptions, billing, invoices, or Stripe.
---

# Stripe Payments

## Key Capabilities
- Checkout Sessions: Hosted payment pages for one-time payments and subscriptions
- Payment Intents: Custom payment flows with full control
- Subscriptions: Recurring billing with flexible pricing
- Customers, Invoices, Refunds, Payment Methods

## Best Practices
- Always prefer Checkout Sessions for standard payment flows
- Use Payment Intents only for custom checkout UI or off-session payments
- Never use deprecated Charges API or Sources API
- Enable dynamic payment methods in Dashboard instead of hardcoding payment_method_types
- Use Setup Intents to save payment methods for future use
- Handle webhooks for all async events
- Implement idempotency keys for safe retries
- Never expose secret keys in client-side code
- Do not include API version in code snippets

## Common Workflows

### One-Time Payment
1. Create Checkout Session (mode: "payment")
2. Redirect customer to session.url
3. Handle webhook for payment_intent.succeeded

### Subscription
1. Create/retrieve customer
2. Create Checkout Session (mode: "subscription")
3. Handle webhook for customer.subscription.created

### Refund
1. Retrieve payment intent
2. Create refund (full or partial with amount in cents)
3. Handle webhook for charge.refunded

## MCP Server Config
```json
{
  "mcpServers": {
    "stripe": {
      "url": "https://mcp.stripe.com"
    }
  }
}
```

## Resources
- [Integration Options](https://docs.stripe.com/payments/payment-methods/integration-options)
- [Go Live Checklist](https://docs.stripe.com/get-started/checklist/go-live)
- [Subscription Use Cases](https://docs.stripe.com/billing/subscriptions/use-cases)
- [Testing](https://docs.stripe.com/testing)
EOF

install_skill "sync-docs" << 'EOF'
---
name: sync-docs
description: Synchronize project documentation with current code state. Use when mentioning doc sync, documentation update, or CLAUDE.md update.
---

# Sync Docs Skill / 문서 동기화 스킬

Synchronize project documentation with current code state.

프로젝트 문서를 현재 코드 상태와 동기화합니다.

## Actions / 작업

### 1. CLAUDE.md Sync / CLAUDE.md 동기화
- Update root CLAUDE.md to match current project state
- 루트 CLAUDE.md를 현재 프로젝트 상태에 맞게 업데이트

### 2. Architecture Doc Sync / 아키텍처 문서 동기화
- Update docs/architecture.md to reflect current system structure
- docs/architecture.md를 현재 시스템 구조에 맞게 업데이트

### 3. Module CLAUDE.md Audit / 모듈 CLAUDE.md 감사
- Scan all directories under src/
- Create CLAUDE.md for modules missing one
- src/ 하위 모든 디렉터리 스캔
- CLAUDE.md가 없는 모듈에 생성

### 4. ADR Audit / ADR 감사
- Check recent commits (git log --oneline -20)
- Suggest new ADRs for undocumented architectural decisions
- 최근 커밋 확인 (git log --oneline -20)
- 문서화되지 않은 아키텍처 결정에 대한 새 ADR 제안

## Usage / 사용법
Run with `/sync-docs` command

`/sync-docs` 명령으로 실행
EOF

install_skill "terraform" << 'EOF'
---
name: terraform-iac
description: Build and manage Infrastructure as Code with Terraform - search registry providers, modules, policies, and HCP Terraform workspace management. Use when mentioning Terraform, HCL, HCP, or Terraform registry.
---

# Terraform

## Key Tools
- search_providers / get_provider_details - Provider documentation
- search_modules / get_module_details - Module discovery
- search_policies / get_policy_details - Sentinel policies
- HCP Terraform: list_workspaces, create_workspace, list_runs, create_run, action_run
- Variable management: list_variable_sets, create_variable_set, list_workspace_variables

## Workflow: Research → Write Config
1. search_providers to find resource docs (get provider_doc_id)
2. get_provider_details for full documentation
3. get_latest_provider_version for version constraint
4. Write accurate Terraform config

## Best Practices
- Always search_* before get_*_details
- Pin provider and module versions
- Use modules for common patterns
- Review plans before applying
- Never hardcode credentials

## MCP Server Config (requires Docker)
```json
{
  "mcpServers": {
    "terraform": {
      "command": "docker",
      "args": ["run", "-i", "--rm", "-e", "TFE_TOKEN", "hashicorp/terraform-mcp-server"],
      "env": {
        "TFE_TOKEN": "$TFE_TOKEN"
      }
    }
  }
}
```

Set `ENABLE_TF_OPERATIONS=true` for destructive operations (apply/destroy).
After changing env vars, restart the Docker container.
EOF

# Create global agent
cat > "${AGENTS_DIR}/powers.json" << 'AGENT_EOF'
{
  "name": "powers",
  "description": "Agent with all powers and skills loaded on-demand globally",
  "resources": [
    "skill://~/.kiro/skills/**/SKILL.md"
  ]
}
AGENT_EOF

TOTAL=$(find "${SKILLS_DIR}" -name "SKILL.md" | wc -l | tr -d ' ')
echo ""
echo "🎉 Done! ${TOTAL} skills installed globally."
echo ""
echo "Usage:"
echo "  /agent powers          Switch to powers agent"
echo "  /context show           See loaded skills"
echo ""
echo "To make it default:"
echo "  kiro-cli settings chat.defaultAgent powers"
