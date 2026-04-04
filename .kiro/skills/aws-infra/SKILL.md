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
