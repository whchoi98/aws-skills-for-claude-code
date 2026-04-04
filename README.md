# Kiro CLI Power Skills

🇺🇸 [English](#english) | 🇰🇷 [한국어](#한국어)

---

<a id="english"></a>
## 🇺🇸 English

A collection of 27 on-demand Skills for [Kiro CLI](https://kiro.dev/cli/).  
Converts [kirodotdev/powers](https://github.com/kirodotdev/powers) Powers into Kiro CLI `skill://` format and adds AWS operational Skills.

### Installation

```bash
bash install-skills.sh
```

Supports both macOS and Linux. No external dependencies.

### Installation Result

```
~/.kiro/
├── agents/
│   └── powers.json           # Switch with /agent powers
└── skills/
    ├── aws-agentcore/SKILL.md
    ├── stripe/SKILL.md
    ├── ... (27 skills)
    └── terraform/SKILL.md
```

### Usage

```
# Switch to powers agent in Kiro CLI
/agent powers

# Check loaded skills
/context show

# Set as default agent (optional)
kiro-cli settings chat.defaultAgent powers
```

Mention relevant keywords in conversation and the corresponding Skill loads automatically.

### Skills List

#### AWS Services (16)

| Skill | Description | Source |
|---|---|---|
| `aws-agentcore` | Bedrock AgentCore agent build/deploy | Powers |
| `aws-amplify` | Amplify Gen 2 full-stack app development | Powers |
| `aws-cloudwatch` | CloudWatch logs, metrics, alarms, CloudTrail | MCP Tool Forge |
| `aws-cost` | Cost analysis, forecasting, pricing lookup | MCP Tool Forge |
| `aws-data` | DynamoDB, Aurora, Redshift, ElastiCache, Neptune | MCP Tool Forge |
| `aws-healthomics` | HealthOmics bioinformatics workflows | Powers |
| `aws-iac` | CDK + CloudFormation IaC | Powers |
| `aws-iam` | IAM users, roles, policy management | MCP Tool Forge |
| `aws-infra` | CloudFormation, ECS, EKS, Serverless | MCP Tool Forge |
| `aws-messaging` | SNS, SQS, MQ, Step Functions | MCP Tool Forge |
| `aws-sam` | SAM serverless app development | Powers |
| `aws-security` | Security audit, account info | MCP Tool Forge |
| `cloud-architect` | AWS Well-Architected CDK Python | Powers |
| `cloudwatch-appsignals` | CloudWatch Application Signals APM | Powers |
| `saas-builder` | Multi-tenant SaaS app building | Powers |
| `strands` | Strands SDK AI agent building | Powers |

#### External Services (7)

| Skill | Description | Source |
|---|---|---|
| `datadog` | Datadog observability | Powers |
| `dynatrace` | Dynatrace DQL/Davis AI | Powers |
| `figma` | Figma design-to-code | Powers |
| `neon` | Neon serverless Postgres | Powers |
| `postman` | Postman API testing | Powers |
| `stripe` | Stripe payment integration | Powers |
| `terraform` | Terraform IaC | Powers |

#### Development Workflows (4)

| Skill | Description | Source |
|---|---|---|
| `code-review` | Code review (quality, security, performance) | MCP Tool Forge |
| `refactor` | Refactoring (SRP, DRY) | MCP Tool Forge |
| `release` | Release automation (semver, CHANGELOG) | MCP Tool Forge |
| `sync-docs` | Documentation sync | MCP Tool Forge |

### How It Works

All SKILL.md files include YAML frontmatter for on-demand loading via `skill://` URI:

```markdown
---
name: stripe-payments
description: Build payment integrations with Stripe. Use when mentioning payments, checkout, or Stripe.
---
```

Kiro CLI loads only metadata (name, description) first, then loads full content when relevant keywords appear in conversation.

### MCP Server Integration

Each Skill includes MCP server configuration. To use actual MCP tools, add the configuration to `~/.kiro/settings/mcp.json`:

```json
{
  "mcpServers": {
    "stripe": {
      "url": "https://mcp.stripe.com"
    }
  }
}
```

### Customization

- Global Skills: Edit `~/.kiro/skills/`
- Project override: Create same name in `.kiro/skills/` (local takes precedence)
- Agent config: Edit `~/.kiro/agents/powers.json`

### Sources

- [kirodotdev/powers](https://github.com/kirodotdev/powers) — Kiro Powers official repository (16 Skills)
- [mcp-tool-forge](https://github.com/whchoi98/mcp-tool-forge) — AWS MCP server-based Skills (11 Skills)

### License

Follows each Skill's original license. For Powers-based Skills, refer to the original Power's license.

---

<a id="한국어"></a>
## 🇰🇷 한국어

[Kiro CLI](https://kiro.dev/cli/)에서 사용할 수 있는 27개 온디맨드 Skills 모음.  
[kirodotdev/powers](https://github.com/kirodotdev/powers)의 Powers를 Kiro CLI `skill://` 형식으로 변환하고, AWS 운영 Skills를 추가했습니다.

### 설치

```bash
bash install-skills.sh
```

macOS와 Linux 모두 지원. 외부 의존성 없음.

### 설치 결과

```
~/.kiro/
├── agents/
│   └── powers.json           # /agent powers 로 전환
└── skills/
    ├── aws-agentcore/SKILL.md
    ├── stripe/SKILL.md
    ├── ... (27개)
    └── terraform/SKILL.md
```

### 사용법

```
# Kiro CLI에서 에이전트 전환
/agent powers

# 로드된 Skills 확인
/context show

# 기본 에이전트로 설정 (선택)
kiro-cli settings chat.defaultAgent powers
```

대화 중 관련 키워드를 언급하면 해당 Skill이 자동으로 로드됩니다.

### Skills 목록

#### AWS 서비스 (16개)

| Skill | 설명 | 출처 |
|---|---|---|
| `aws-agentcore` | Bedrock AgentCore 에이전트 빌드/배포 | Powers |
| `aws-amplify` | Amplify Gen 2 풀스택 앱 개발 | Powers |
| `aws-cloudwatch` | CloudWatch 로그, 메트릭, 알람, CloudTrail | MCP Tool Forge |
| `aws-cost` | 비용 분석, 예측, 요금 조회 | MCP Tool Forge |
| `aws-data` | DynamoDB, Aurora, Redshift, ElastiCache, Neptune | MCP Tool Forge |
| `aws-healthomics` | HealthOmics 생물정보학 워크플로우 | Powers |
| `aws-iac` | CDK + CloudFormation IaC | Powers |
| `aws-iam` | IAM 사용자, 역할, 정책 관리 | MCP Tool Forge |
| `aws-infra` | CloudFormation, ECS, EKS, Serverless | MCP Tool Forge |
| `aws-messaging` | SNS, SQS, MQ, Step Functions | MCP Tool Forge |
| `aws-sam` | SAM 서버리스 앱 개발 | Powers |
| `aws-security` | 보안 감사, 계정 정보 | MCP Tool Forge |
| `cloud-architect` | AWS Well-Architected CDK Python | Powers |
| `cloudwatch-appsignals` | CloudWatch Application Signals APM | Powers |
| `saas-builder` | 멀티테넌트 SaaS 앱 구축 | Powers |
| `strands` | Strands SDK AI 에이전트 빌드 | Powers |

#### 외부 서비스 (7개)

| Skill | 설명 | 출처 |
|---|---|---|
| `datadog` | Datadog 옵저버빌리티 | Powers |
| `dynatrace` | Dynatrace DQL/Davis AI | Powers |
| `figma` | Figma 디자인→코드 | Powers |
| `neon` | Neon 서버리스 Postgres | Powers |
| `postman` | Postman API 테스트 | Powers |
| `stripe` | Stripe 결제 연동 | Powers |
| `terraform` | Terraform IaC | Powers |

#### 개발 워크플로우 (4개)

| Skill | 설명 | 출처 |
|---|---|---|
| `code-review` | 코드 리뷰 (품질, 보안, 성능) | MCP Tool Forge |
| `refactor` | 리팩토링 (SRP, DRY) | MCP Tool Forge |
| `release` | 릴리스 자동화 (semver, CHANGELOG) | MCP Tool Forge |
| `sync-docs` | 문서 동기화 | MCP Tool Forge |

### 동작 원리

모든 SKILL.md에 YAML frontmatter가 포함되어 있어 `skill://` URI로 온디맨드 로딩됩니다:

```markdown
---
name: stripe-payments
description: Build payment integrations with Stripe. Use when mentioning payments, checkout, or Stripe.
---
```

Kiro CLI는 메타데이터(name, description)만 먼저 로드하고, 대화 중 관련 키워드가 나올 때 전체 내용을 로드합니다.

### MCP 서버 연동

각 Skill에 MCP 서버 설정이 포함되어 있습니다. 실제 MCP 도구를 사용하려면 `~/.kiro/settings/mcp.json`에 해당 설정을 추가하세요:

```json
{
  "mcpServers": {
    "stripe": {
      "url": "https://mcp.stripe.com"
    }
  }
}
```

### 커스터마이즈

- 글로벌 Skills: `~/.kiro/skills/` 수정
- 프로젝트별 오버라이드: `.kiro/skills/`에 같은 이름으로 생성 (로컬 우선)
- 에이전트 설정: `~/.kiro/agents/powers.json` 수정

### 출처

- [kirodotdev/powers](https://github.com/kirodotdev/powers) — Kiro Powers 공식 리포지토리 (16개 Skills)
- [mcp-tool-forge](https://github.com/whchoi98/mcp-tool-forge) — AWS MCP 서버 기반 Skills (11개 Skills)

### 라이선스

각 Skill의 원본 라이선스를 따릅니다. Powers 기반 Skills는 원본 Power의 라이선스를 참조하세요.
