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
