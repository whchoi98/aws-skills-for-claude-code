# Kiro CLI Power Skills

[![License](https://img.shields.io/badge/license-See%20each%20skill-blue.svg)](LICENSE)
[![Version](https://img.shields.io/badge/version-1.0-green.svg)](CHANGELOG.md)
[![Platform](https://img.shields.io/badge/platform-macOS%20%7C%20Linux-lightgrey.svg)]()

36 on-demand skills for Kiro CLI — curated from Powers and MCP Tool Forge.

[![English](https://img.shields.io/badge/lang-English-blue.svg)](#english) [![한국어](https://img.shields.io/badge/lang-한국어-red.svg)](#한국어)

---

<a id="english"></a>

# English

## Overview

Kiro CLI Power Skills packages 27 specialized AI agent skills into a single installer for [Kiro CLI](https://kiro.dev/cli/). Each skill loads on-demand via `skill://` URI — only metadata is kept in memory until relevant keywords appear in conversation, keeping context usage minimal.

Skills are sourced from two repositories:
- [kirodotdev/powers](https://github.com/kirodotdev/powers) — official Kiro Powers (25 skills)
- [whchoi98/mcp-tool-forge](https://github.com/whchoi98/mcp-tool-forge) — AWS MCP server-based skills (11 skills)

## Features

- **On-demand loading** — YAML frontmatter enables keyword-triggered activation, not always-on context
- **36 skills** — AWS services, external services (Stripe, Datadog, Figma, etc.), and dev workflows
- **One-command install** — single shell script, no external dependencies
- **Cross-platform** — macOS and Linux support
- **Customizable** — global install with per-project override capability

## Prerequisites

- [Kiro CLI](https://kiro.dev/cli/) installed
- Bash shell (macOS or Linux)

## Installation

```bash
# Clone the repository
git clone https://github.com/whchoi98/kiro-cli-power.git
cd kiro-cli-power

# Run the installer
bash install-skills.sh
```

The script installs all skills to `~/.kiro/skills/` and creates the agent config at `~/.kiro/agents/powers.json`.

## Usage

```bash
# Switch to powers agent
/agent powers

# Check loaded skills
/context show

# Set as default agent (optional)
kiro-cli settings chat.defaultAgent powers
```

Mention relevant keywords in conversation and the corresponding skill loads automatically. For example, saying "Stripe payment" activates the `stripe` skill.

## Project Structure

```
kiro-cli-power/
├── README.md              # Documentation (bilingual)
├── CHANGELOG.md           # Version history
├── install-skills.sh      # Global installer (macOS/Linux)
└── .kiro/
    ├── agents/
    │   └── powers.json    # Agent config with skill:// resources
    └── skills/
        ├── aws-agentcore/ # Bedrock AgentCore
        ├── stripe/        # Stripe payments
        ├── ...            # (27 skill directories)
        └── terraform/     # Terraform IaC
```

## Skills List

### AWS Services (16)

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

### Migration & Specialized (5)

| Skill | Description | Source |
|---|---|---|
| `arm-soc-migration` | Arm SoC migration with architecture-aware analysis | Powers |
| `aws-graviton-migration` | Graviton (Arm64) compatibility analysis and porting | Powers |
| `aws-mcp` | Multi-step AWS tasks with docs, APIs, and Agent SOPs | Powers |
| `aws-observability` | CloudWatch Logs, Metrics, Alarms, APM, CloudTrail | Powers |
| `gcp-aws-migrate` | 5-phase GCP to AWS migration advisor | Powers |

### External Services (7)

| Skill | Description | Source |
|---|---|---|
| `datadog` | Datadog observability | Powers |
| `dynatrace` | Dynatrace DQL/Davis AI | Powers |
| `figma` | Figma design-to-code | Powers |
| `neon` | Neon serverless Postgres | Powers |
| `postman` | Postman API testing | Powers |
| `stripe` | Stripe payment integration | Powers |
| `terraform` | Terraform IaC | Powers |
| `checkout` | Checkout.com 결제 처리 API | Powers |
| `stackgen` | StackGen 멀티클라우드 IaC 관리 | Powers |
| `checkout` | Checkout.com payment processing APIs | Powers |
| `stackgen` | StackGen multi-cloud IaC management | Powers |

### Development Workflows (4)

| Skill | Description | Source |
|---|---|---|
| `code-review` | Code review (quality, security, performance) | MCP Tool Forge |
| `refactor` | Refactoring (SRP, DRY) | MCP Tool Forge |
| `release` | Release automation (semver, CHANGELOG) | MCP Tool Forge |
| `sync-docs` | Documentation sync | MCP Tool Forge |
| `spark-troubleshooting` | Spark on EMR, Glue, SageMaker troubleshooting | Powers |
| `power-builder` | Guide for building new Kiro Powers | Powers |

## Configuration

Each skill includes MCP server configuration. To use actual MCP tools, add the configuration to `~/.kiro/settings/mcp.json`:

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

| Scope | Path | Priority |
|---|---|---|
| Global | `~/.kiro/skills/` | Default |
| Project | `.kiro/skills/` | Overrides global |
| Agent | `~/.kiro/agents/powers.json` | Agent config |

Create a skill with the same name in `.kiro/skills/` to override the global version for a specific project.

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feat/new-skill`)
3. Commit changes (`git commit -m "feat: add new-skill"`)
4. Push to the branch (`git push origin feat/new-skill`)
5. Open a Pull Request

Use [Conventional Commits](https://www.conventionalcommits.org/) format: `feat:`, `fix:`, `docs:`, `chore:`.

## License

Each skill follows its original license. For Powers-based skills, refer to the [kirodotdev/powers](https://github.com/kirodotdev/powers) repository. For MCP Tool Forge skills, refer to [whchoi98/mcp-tool-forge](https://github.com/whchoi98/mcp-tool-forge).

## Contact

- GitHub: [whchoi98](https://github.com/whchoi98)
- Issues: [github.com/whchoi98/kiro-cli-power/issues](https://github.com/whchoi98/kiro-cli-power/issues)

## Acknowledgements

- [kirodotdev/powers](https://github.com/kirodotdev/powers) — Kiro Powers official repository (25 skills)
- [whchoi98/mcp-tool-forge](https://github.com/whchoi98/mcp-tool-forge) — AWS MCP server-based skills (11 skills)
- [Kiro](https://kiro.dev/) — AI-powered development environment

---

<a id="한국어"></a>

# 한국어

## 개요

Kiro CLI Power Skills는 [Kiro CLI](https://kiro.dev/cli/)를 위한 36개 전문 AI 에이전트 스킬을 하나의 설치 스크립트로 제공합니다. 각 스킬은 `skill://` URI를 통해 온디맨드로 로드됩니다. 대화에서 관련 키워드가 나타날 때까지 메타데이터만 메모리에 유지하여 컨텍스트 사용을 최소화합니다.

스킬은 두 리포지토리에서 수집했습니다:
- [kirodotdev/powers](https://github.com/kirodotdev/powers) — Kiro Powers 공식 리포지토리 (25개 스킬)
- [whchoi98/mcp-tool-forge](https://github.com/whchoi98/mcp-tool-forge) — AWS MCP 서버 기반 스킬 (11개 스킬)

## 주요 기능

- **온디맨드 로딩** — YAML frontmatter로 키워드 기반 활성화, 항상 로드되지 않음
- **36개 스킬** — AWS 서비스, 외부 서비스(Stripe, Datadog, Figma 등), 개발 워크플로우
- **원커맨드 설치** — 단일 셸 스크립트, 외부 의존성 없음
- **크로스 플랫폼** — macOS와 Linux 지원
- **커스터마이즈 가능** — 글로벌 설치 + 프로젝트별 오버라이드

## 사전 요구 사항

- [Kiro CLI](https://kiro.dev/cli/) 설치
- Bash 셸 (macOS 또는 Linux)

## 설치 방법

```bash
# 리포지토리 클론
git clone https://github.com/whchoi98/kiro-cli-power.git
cd kiro-cli-power

# 설치 스크립트 실행
bash install-skills.sh
```

스크립트는 모든 스킬을 `~/.kiro/skills/`에 설치하고, 에이전트 설정을 `~/.kiro/agents/powers.json`에 생성합니다.

## 사용법

```bash
# powers 에이전트로 전환
/agent powers

# 로드된 스킬 확인
/context show

# 기본 에이전트로 설정 (선택)
kiro-cli settings chat.defaultAgent powers
```

대화 중 관련 키워드를 언급하면 해당 스킬이 자동으로 로드됩니다. 예를 들어 "Stripe 결제"라고 말하면 `stripe` 스킬이 활성화됩니다.

## 프로젝트 구조

```
kiro-cli-power/
├── README.md              # 문서 (이중 언어)
├── CHANGELOG.md           # 버전 이력
├── install-skills.sh      # 글로벌 설치 스크립트 (macOS/Linux)
└── .kiro/
    ├── agents/
    │   └── powers.json    # skill:// 리소스를 포함한 에이전트 설정
    └── skills/
        ├── aws-agentcore/ # Bedrock AgentCore
        ├── stripe/        # Stripe 결제
        ├── ...            # (36개 스킬 디렉토리)
        └── terraform/     # Terraform IaC
```

## Skills 목록

### AWS 서비스 (16개)

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

### 마이그레이션 및 특수 (5개)

| Skill | 설명 | 출처 |
|---|---|---|
| `arm-soc-migration` | Arm SoC 마이그레이션 (아키텍처 인식 분석) | Powers |
| `aws-graviton-migration` | Graviton (Arm64) 호환성 분석 및 포팅 | Powers |
| `aws-mcp` | AWS 문서, API, Agent SOP 기반 멀티스텝 작업 | Powers |
| `aws-observability` | CloudWatch 로그, 메트릭, 알람, APM, CloudTrail | Powers |
| `gcp-aws-migrate` | 5단계 GCP→AWS 마이그레이션 어드바이저 | Powers |

### 외부 서비스 (7개)

| Skill | 설명 | 출처 |
|---|---|---|
| `datadog` | Datadog 옵저버빌리티 | Powers |
| `dynatrace` | Dynatrace DQL/Davis AI | Powers |
| `figma` | Figma 디자인→코드 | Powers |
| `neon` | Neon 서버리스 Postgres | Powers |
| `postman` | Postman API 테스트 | Powers |
| `stripe` | Stripe 결제 연동 | Powers |
| `terraform` | Terraform IaC | Powers |
| `checkout` | Checkout.com 결제 처리 API | Powers |
| `stackgen` | StackGen 멀티클라우드 IaC 관리 | Powers |
| `checkout` | Checkout.com payment processing APIs | Powers |
| `stackgen` | StackGen multi-cloud IaC management | Powers |

### 개발 워크플로우 (4개)

| Skill | 설명 | 출처 |
|---|---|---|
| `code-review` | 코드 리뷰 (품질, 보안, 성능) | MCP Tool Forge |
| `refactor` | 리팩토링 (SRP, DRY) | MCP Tool Forge |
| `release` | 릴리스 자동화 (semver, CHANGELOG) | MCP Tool Forge |
| `sync-docs` | 문서 동기화 | MCP Tool Forge |
| `spark-troubleshooting` | Spark on EMR, Glue, SageMaker 트러블슈팅 | Powers |
| `power-builder` | Kiro Power 제작 가이드 | Powers |

## 환경 설정

각 스킬에 MCP 서버 설정이 포함되어 있습니다. 실제 MCP 도구를 사용하려면 `~/.kiro/settings/mcp.json`에 해당 설정을 추가합니다:

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

| 범위 | 경로 | 우선순위 |
|---|---|---|
| 글로벌 | `~/.kiro/skills/` | 기본값 |
| 프로젝트 | `.kiro/skills/` | 글로벌 오버라이드 |
| 에이전트 | `~/.kiro/agents/powers.json` | 에이전트 설정 |

특정 프로젝트에서 글로벌 버전을 오버라이드하려면 `.kiro/skills/`에 같은 이름의 스킬을 생성합니다.

## 기여 방법

1. 리포지토리를 Fork합니다
2. 기능 브랜치를 생성합니다 (`git checkout -b feat/new-skill`)
3. 변경 사항을 커밋합니다 (`git commit -m "feat: add new-skill"`)
4. 브랜치에 Push합니다 (`git push origin feat/new-skill`)
5. Pull Request를 생성합니다

[Conventional Commits](https://www.conventionalcommits.org/) 형식을 사용합니다: `feat:`, `fix:`, `docs:`, `chore:`.

## 라이선스

각 스킬은 원본 라이선스를 따릅니다. Powers 기반 스킬은 [kirodotdev/powers](https://github.com/kirodotdev/powers) 리포지토리를, MCP Tool Forge 스킬은 [whchoi98/mcp-tool-forge](https://github.com/whchoi98/mcp-tool-forge)를 참조합니다.

## 연락처

- GitHub: [whchoi98](https://github.com/whchoi98)
- Issues: [github.com/whchoi98/kiro-cli-power/issues](https://github.com/whchoi98/kiro-cli-power/issues)

## 감사의 말

- [kirodotdev/powers](https://github.com/kirodotdev/powers) — Kiro Powers 공식 리포지토리 (25개 스킬)
- [whchoi98/mcp-tool-forge](https://github.com/whchoi98/mcp-tool-forge) — AWS MCP 서버 기반 스킬 (11개 스킬)
- [Kiro](https://kiro.dev/) — AI 기반 개발 환경
