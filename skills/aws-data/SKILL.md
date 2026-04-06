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
