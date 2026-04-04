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
