# AWS Skills for Claude Code

[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE) [![Version](https://img.shields.io/badge/version-1.3.0-green.svg)](CHANGELOG.md) [![Platform](https://img.shields.io/badge/platform-macOS%20%7C%20Linux-lightgrey.svg)]() [![English](https://img.shields.io/badge/lang-English-blue.svg)](#english) [![한국어](https://img.shields.io/badge/lang-한국어-red.svg)](#한국어)

A Claude Code plugin with 40 on-demand AWS and cloud skills / 40개 온디맨드 AWS/클라우드 스킬을 제공하는 Claude Code 플러그인

---

# English

## Overview

AWS Skills for Claude Code is a Claude Code plugin that provides 40 on-demand skills for [Claude Code](https://docs.anthropic.com/en/docs/claude-code). Each skill loads automatically when relevant keywords appear in conversation, keeping context usage minimal.

The plugin includes 36 upstream skills from two repositories plus 4 development workflow skills, along with slash commands, agents, and security hooks.

## Features

- **Claude Code Plugin** — Install once, get 40 skills + 3 commands + 2 agents + security hooks
- **On-demand loading** — YAML frontmatter enables keyword-triggered activation instead of always-on context consumption
- **40 skills** — AWS services, external services (Stripe, Datadog, Figma, etc.), migration tools, and development workflows
- **Slash commands** — `/review`, `/test-all`, `/deploy` for common workflows
- **Security hooks** — Pre-commit secret scanning and webhook notifications
- **Cross-platform** — macOS and Linux support with POSIX-compatible Bash scripts

## Prerequisites

- [Claude Code](https://docs.anthropic.com/en/docs/claude-code) installed
- Bash 4+ (macOS: `brew install bash`, Linux: pre-installed)
- Git

## Installation

### As a Plugin (Recommended)

```bash
# Clone and install as Claude Code plugin
git clone https://github.com/whchoi98/aws-skills-for-claude-code.git
claude plugins add ./aws-skills-for-claude-code

# Verify: 40 skills, 3 commands, 2 agents available
```

### Legacy Install (Skills Only)

```bash
# Clone the repository
git clone https://github.com/whchoi98/aws-skills-for-claude-code.git
cd aws-skills-for-claude-code

# Install 36 upstream skills to ~/.claude/skills/
bash install-claude-code.sh

# Verify installation (should output 36)
ls -d ~/.claude/skills/*/ | wc -l
```

## Usage

```bash
# Invoke a skill directly by name
/aws-cloudwatch
/stripe
/terraform

# Or mention keywords in conversation
# Claude auto-detects and loads the relevant skill
# Example: "Set up a Stripe payment integration" -> activates the stripe skill
```

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

#### Migration and Specialized (5)

| Skill | Description | Source |
|---|---|---|
| `arm-soc-migration` | Arm SoC migration with architecture-aware analysis | Powers |
| `aws-graviton-migration` | Graviton (Arm64) compatibility analysis and porting | Powers |
| `aws-mcp` | Multi-step AWS tasks with docs, APIs, and Agent SOPs | Powers |
| `aws-observability` | CloudWatch Logs, Metrics, Alarms, APM, CloudTrail | Powers |
| `gcp-aws-migrate` | 5-phase GCP to AWS migration advisor | Powers |

#### External Services (9)

| Skill | Description | Source |
|---|---|---|
| `checkout` | Checkout.com payment processing APIs | Powers |
| `datadog` | Datadog observability | Powers |
| `dynatrace` | Dynatrace DQL/Davis AI | Powers |
| `figma` | Figma design-to-code | Powers |
| `neon` | Neon serverless Postgres | Powers |
| `postman` | Postman API testing | Powers |
| `stackgen` | StackGen multi-cloud IaC management | Powers |
| `stripe` | Stripe payment integration | Powers |
| `terraform` | Terraform IaC | Powers |

#### Development Workflows (6)

| Skill | Description | Source |
|---|---|---|
| `code-review` | Code review (quality, security, performance) | MCP Tool Forge |
| `power-builder` | Guide for building and testing new skills | Powers |
| `refactor` | Refactoring (SRP, DRY) | MCP Tool Forge |
| `release` | Release automation (semver, CHANGELOG) | MCP Tool Forge |
| `spark-troubleshooting` | Spark on EMR, Glue, SageMaker troubleshooting | Powers |
| `sync-docs` | Documentation sync | MCP Tool Forge |

## Configuration

Each skill references MCP server tools. To use actual MCP tools, add the configuration to `~/.claude/settings.json`:

```json
{
  "mcpServers": {
    "stripe": {
      "url": "https://mcp.stripe.com"
    }
  }
}
```

| Variable | Description | Default |
|---|---|---|
| `CLAUDE_NOTIFY_WEBHOOK` | Webhook URL for event notifications (Slack, etc.) | (none) |

### Skill Override

| Scope | Path | Priority |
|---|---|---|
| Global | `~/.claude/skills/` | Default |
| Project | `.claude/skills/` | Overrides global |

Create a skill with the same name in `.claude/skills/` to override the global version for a specific project.

## Project Structure

```
aws-skills-for-claude-code/
├── .claude-plugin/
│   └── plugin.json            # Plugin manifest (name, version, component paths)
├── CLAUDE.md                  # Claude Code project configuration
├── README.md                  # Documentation (bilingual)
├── CHANGELOG.md               # Version history
├── LICENSE                    # MIT license
├── install-claude-code.sh     # Legacy skill installer (macOS/Linux)
├── install-skills.sh          # Upstream skill downloader
├── .kiro/
│   ├── skills/                # 36 upstream skills (auto-discovered by plugin)
│   └── agents/                # Kiro agent configuration
├── .claude/
│   ├── hooks/                 # Hook scripts (secret-scan, doc-sync, etc.)
│   ├── skills/                # 4 project skills (auto-discovered by plugin)
│   ├── commands/              # Slash commands (auto-discovered by plugin)
│   └── agents/                # Agent definitions (YAML, for dev)
├── agents/                    # Plugin agents (Markdown, auto-discovered)
├── hooks/
│   └── hooks.json             # Plugin hook configuration
├── docs/
│   ├── architecture.md        # Bilingual architecture document
│   ├── onboarding.md          # Developer onboarding guide
│   ├── decisions/             # Architecture Decision Records (ADR)
│   └── runbooks/              # Operational runbooks
├── tests/
│   ├── run-all.sh             # TAP-format test runner (76 assertions)
│   ├── hooks/                 # Hook and secret pattern tests
│   ├── structure/             # Project structure validation
│   └── fixtures/              # Test data (secret samples)
└── scripts/
    ├── setup.sh               # One-command project setup
    └── install-hooks.sh       # Git hooks installer
```

### Installation Result

```
~/.claude/
└── skills/
    ├── aws-agentcore/SKILL.md
    ├── stripe/SKILL.md
    ├── ...                    # (36 skills total)
    └── terraform/SKILL.md
```

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feat/new-skill`)
3. Commit changes (`git commit -m "feat: add new-skill"`)
4. Push to the branch (`git push origin feat/new-skill`)
5. Open a Pull Request

Use [Conventional Commits](https://www.conventionalcommits.org/) format: `feat:`, `fix:`, `docs:`, `chore:`.

## License

This project is licensed under the [MIT License](LICENSE).

The MIT license applies to the project's own code (installation scripts, hooks, documentation, and configuration files). Individual skills in `.kiro/skills/` follow their respective upstream licenses:

- [kirodotdev/powers](https://github.com/kirodotdev/powers) — 25 skills
- [whchoi98/kiro-cli-power](https://github.com/whchoi98/kiro-cli-power) — 11 skills

## Contact

- GitHub: [whchoi98](https://github.com/whchoi98)
- Issues: [github.com/whchoi98/aws-skills-for-claude-code/issues](https://github.com/whchoi98/aws-skills-for-claude-code/issues)

---

# 한국어

## 개요

AWS Skills for Claude Code는 [Claude Code](https://docs.anthropic.com/en/docs/claude-code)를 위한 40개 온디맨드 스킬을 제공하는 Claude Code 플러그인입니다. 대화에서 관련 키워드가 나타나면 해당 스킬이 자동으로 로드되어 컨텍스트 사용을 최소화합니다.

36개 업스트림 스킬과 4개 개발 워크플로우 스킬, 슬래시 커맨드, 에이전트, 보안 훅을 포함합니다.

## 주요 기능

- **Claude Code 플러그인** — 한 번 설치로 40개 스킬 + 3개 커맨드 + 2개 에이전트 + 보안 훅 활성화
- **온디맨드 로딩** — YAML frontmatter를 통해 키워드 기반으로 활성화되며, 항상 로드되지 않아 컨텍스트를 절약합니다
- **40개 스킬** — AWS 서비스, 외부 서비스(Stripe, Datadog, Figma 등), 마이그레이션 도구, 개발 워크플로우를 포함합니다
- **슬래시 커맨드** — `/review`, `/test-all`, `/deploy`로 일반적인 워크플로우 실행
- **보안 훅** — 커밋 전 시크릿 스캔 및 웹훅 알림
- **크로스 플랫폼** — POSIX 호환 Bash 스크립트로 macOS와 Linux를 지원합니다

## 사전 요구 사항

- [Claude Code](https://docs.anthropic.com/en/docs/claude-code) 설치
- Bash 4+ (macOS: `brew install bash`, Linux: 기본 설치)
- Git

## 설치 방법

### 플러그인으로 설치 (권장)

```bash
# 클론 후 Claude Code 플러그인으로 설치
git clone https://github.com/whchoi98/aws-skills-for-claude-code.git
claude plugins add ./aws-skills-for-claude-code

# 확인: 40개 스킬, 3개 커맨드, 2개 에이전트 사용 가능
```

### 레거시 설치 (스킬만)

```bash
# 리포지토리 클론
git clone https://github.com/whchoi98/aws-skills-for-claude-code.git
cd aws-skills-for-claude-code

# 36개 업스트림 스킬을 ~/.claude/skills/에 설치
bash install-claude-code.sh

# 설치 확인 (36이 출력되어야 함)
ls -d ~/.claude/skills/*/ | wc -l
```

## 사용법

```bash
# 스킬을 이름으로 직접 호출
/aws-cloudwatch
/stripe
/terraform

# 또는 대화에서 키워드만 언급
# Claude가 자동으로 관련 스킬을 로드합니다
# 예시: "Stripe 결제 연동 설정해줘" -> stripe 스킬이 활성화됩니다
```

### 스킬 목록

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

#### 마이그레이션 및 특수 (5개)

| Skill | 설명 | 출처 |
|---|---|---|
| `arm-soc-migration` | Arm SoC 마이그레이션 (아키텍처 인식 분석) | Powers |
| `aws-graviton-migration` | Graviton (Arm64) 호환성 분석 및 포팅 | Powers |
| `aws-mcp` | AWS 문서, API, Agent SOP 기반 멀티스텝 작업 | Powers |
| `aws-observability` | CloudWatch 로그, 메트릭, 알람, APM, CloudTrail | Powers |
| `gcp-aws-migrate` | 5단계 GCP→AWS 마이그레이션 어드바이저 | Powers |

#### 외부 서비스 (9개)

| Skill | 설명 | 출처 |
|---|---|---|
| `checkout` | Checkout.com 결제 처리 API | Powers |
| `datadog` | Datadog 옵저버빌리티 | Powers |
| `dynatrace` | Dynatrace DQL/Davis AI | Powers |
| `figma` | Figma 디자인→코드 | Powers |
| `neon` | Neon 서버리스 Postgres | Powers |
| `postman` | Postman API 테스트 | Powers |
| `stackgen` | StackGen 멀티클라우드 IaC 관리 | Powers |
| `stripe` | Stripe 결제 연동 | Powers |
| `terraform` | Terraform IaC | Powers |

#### 개발 워크플로우 (6개)

| Skill | 설명 | 출처 |
|---|---|---|
| `code-review` | 코드 리뷰 (품질, 보안, 성능) | MCP Tool Forge |
| `power-builder` | 스킬 제작 및 테스트 가이드 | Powers |
| `refactor` | 리팩토링 (SRP, DRY) | MCP Tool Forge |
| `release` | 릴리스 자동화 (semver, CHANGELOG) | MCP Tool Forge |
| `spark-troubleshooting` | Spark on EMR, Glue, SageMaker 트러블슈팅 | Powers |
| `sync-docs` | 문서 동기화 | MCP Tool Forge |

## 환경 설정

각 스킬은 MCP 서버 도구를 참조합니다. 실제 MCP 도구를 사용하려면 `~/.claude/settings.json`에 해당 설정을 추가합니다:

```json
{
  "mcpServers": {
    "stripe": {
      "url": "https://mcp.stripe.com"
    }
  }
}
```

| 변수 | 설명 | 기본값 |
|---|---|---|
| `CLAUDE_NOTIFY_WEBHOOK` | 이벤트 알림용 웹훅 URL (Slack 등) | (없음) |

### 스킬 오버라이드

| 범위 | 경로 | 우선순위 |
|---|---|---|
| 글로벌 | `~/.claude/skills/` | 기본값 |
| 프로젝트 | `.claude/skills/` | 글로벌 오버라이드 |

특정 프로젝트에서 글로벌 버전을 오버라이드하려면 `.claude/skills/`에 같은 이름의 스킬을 생성합니다.

## 프로젝트 구조

```
aws-skills-for-claude-code/
├── .claude-plugin/
│   └── plugin.json            # 플러그인 매니페스트 (이름, 버전, 컴포넌트 경로)
├── CLAUDE.md                  # Claude Code 프로젝트 설정
├── README.md                  # 문서 (이중 언어)
├── CHANGELOG.md               # 버전 이력
├── LICENSE                    # MIT 라이선스
├── install-claude-code.sh     # 레거시 스킬 설치 스크립트 (macOS/Linux)
├── install-skills.sh          # 업스트림 스킬 다운로더
├── .kiro/
│   ├── skills/                # 36개 업스트림 스킬 (플러그인 자동 발견)
│   └── agents/                # Kiro 에이전트 설정
├── .claude/
│   ├── hooks/                 # 훅 스크립트 (secret-scan, doc-sync 등)
│   ├── skills/                # 4개 프로젝트 스킬 (플러그인 자동 발견)
│   ├── commands/              # 슬래시 커맨드 (플러그인 자동 발견)
│   └── agents/                # 에이전트 정의 (YAML, 개발용)
├── agents/                    # 플러그인 에이전트 (Markdown, 자동 발견)
├── hooks/
│   └── hooks.json             # 플러그인 훅 설정
├── docs/
│   ├── architecture.md        # 이중 언어 아키텍처 문서
│   ├── onboarding.md          # 개발자 온보딩 가이드
│   ├── decisions/             # 아키텍처 결정 기록 (ADR)
│   └── runbooks/              # 운영 런북
├── tests/
│   ├── run-all.sh             # TAP 형식 테스트 러너 (76개 어설션)
│   ├── hooks/                 # 훅 및 시크릿 패턴 테스트
│   ├── structure/             # 프로젝트 구조 검증
│   └── fixtures/              # 테스트 데이터 (시크릿 샘플)
└── scripts/
    ├── setup.sh               # 원커맨드 프로젝트 셋업
    └── install-hooks.sh       # Git 훅 설치
```

### 설치 결과

```
~/.claude/
└── skills/
    ├── aws-agentcore/SKILL.md
    ├── stripe/SKILL.md
    ├── ...                    # (총 36개 스킬)
    └── terraform/SKILL.md
```

## 기여 방법

1. 리포지토리를 Fork합니다
2. 기능 브랜치를 생성합니다 (`git checkout -b feat/new-skill`)
3. 변경 사항을 커밋합니다 (`git commit -m "feat: add new-skill"`)
4. 브랜치에 Push합니다 (`git push origin feat/new-skill`)
5. Pull Request를 생성합니다

[Conventional Commits](https://www.conventionalcommits.org/) 형식을 사용합니다: `feat:`, `fix:`, `docs:`, `chore:`.

## 라이선스

이 프로젝트는 [MIT 라이선스](LICENSE)를 따릅니다.

MIT 라이선스는 프로젝트 자체 코드(설치 스크립트, 훅, 문서, 설정 파일)에 적용됩니다. `.kiro/skills/`의 개별 스킬은 각각의 업스트림 라이선스를 따릅니다:

- [kirodotdev/powers](https://github.com/kirodotdev/powers) — 25개 스킬
- [whchoi98/kiro-cli-power](https://github.com/whchoi98/kiro-cli-power) — 11개 스킬

## 연락처

- GitHub: [whchoi98](https://github.com/whchoi98)
- Issues: [github.com/whchoi98/aws-skills-for-claude-code/issues](https://github.com/whchoi98/aws-skills-for-claude-code/issues)
