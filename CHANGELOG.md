# Changelog

[![English](https://img.shields.io/badge/lang-English-blue.svg)](#english) [![한국어](https://img.shields.io/badge/lang-한국어-red.svg)](#한국어)

---

# English

All notable changes to this project will be documented in this file.
The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- **Independent marketplace** -- `.claude-plugin/marketplace.json` for `/plugin marketplace add` installation
- Marketplace install instructions in README (EN/KR)

## [1.3.0] - 2026-04-06

### Added

- **Claude Code plugin support** -- `.claude-plugin/plugin.json` manifest with zero-duplication architecture
- Plugin agents: `agents/code-reviewer.md`, `agents/security-auditor.md` (Markdown format)
- Plugin hooks: `hooks/hooks.json` (SessionStart, Notification) with `$CLAUDE_PLUGIN_ROOT` paths
- TAP-format test suite: 99 assertions across hooks, secret patterns, project structure, and plugin structure
- Dangerous command deny list in `.claude/settings.json` (rm -rf, git push --force, git reset --hard, etc.)
- YAML frontmatter `description` to 4 project skills for plugin auto-discovery
- Module CLAUDE.md files for `tests/` and `scripts/` directories
- ADR-003: Plugin architecture with zero-duplication design
- Claude Code hooks: secret scanning (PreCommit), session context loading (SessionStart), webhook notifications (Notification)
- Slash commands: `/review`, `/test-all`, `/deploy`
- Agent definitions: `code-reviewer`, `security-auditor`
- Developer onboarding guide (`docs/onboarding.md`)
- Architecture Decision Records: ADR-001 (heredoc skill embedding), ADR-002 (two-stage install pipeline)
- Upstream sync runbook (`docs/runbooks/upstream-sync.md`)
- MIT LICENSE file with upstream license references
- Project setup script (`scripts/setup.sh`) and Git hooks installer (`scripts/install-hooks.sh`)
- Configuration files: `.editorconfig`, `.env.example`, `.mcp.json`

### Changed

- Upgrade from skill distribution project to Claude Code plugin (40 skills, 3 commands, 2 agents, 2 hooks)
- `plugin.json` references `.kiro/skills/` and `.claude/skills/` via custom paths (no file duplication)
- Rewrite README.md with plugin installation instructions (bilingual)
- Rewrite `docs/architecture.md` with Plugin Layer and updated system overview (bilingual)
- Update CLAUDE.md with plugin architecture, 40 skills, and expanded key files
- Update `.claude/settings.json` with all 4 hook events and deny list

## [1.2.0] - 2026-04-04

### Added

- `CLAUDE.md` project configuration for Claude Code development workflows
- Documentation sync hook (`check-doc-sync.sh`) triggered by PostToolUse events

### Changed

- Remove `name` field from 13 Powers-sourced skills for Agent Skills spec compliance (directory name used as fallback)
- Update skill source URL from `whchoi98/mcp-tool-forge` to `whchoi98/kiro-cli-power`

## [1.1.0] - 2026-04-04

### Added

- 9 new skills from [kirodotdev/powers](https://github.com/kirodotdev/powers), bringing total from 27 to 36
- `arm-soc-migration` -- Arm SoC migration with architecture-aware analysis
- `aws-graviton-migration` -- Graviton (Arm64) compatibility analysis and porting
- `aws-mcp` -- Multi-step AWS tasks with 15,000+ APIs and Agent SOPs
- `aws-observability` -- Comprehensive CloudWatch observability (Logs, Metrics, Alarms, APM, CloudTrail)
- `checkout` -- Checkout.com payment processing APIs
- `gcp-aws-migrate` -- 5-phase GCP to AWS migration advisor
- `power-builder` -- Guide for building and testing new skills
- `spark-troubleshooting` -- Spark troubleshooting on EMR, Glue, and SageMaker
- `stackgen` -- StackGen multi-cloud IaC management
- `install-claude-code.sh` installer for Claude Code on-demand skill loading

### Changed

- Reorganize skills list into 4 categories: AWS Services (16), Migration and Specialized (5), External Services (9), Development Workflows (6)

## [1.0.0] - 2026-04-04

### Added

- 27 on-demand skills for Kiro CLI with YAML frontmatter for keyword-triggered activation
- `install-skills.sh` global installer for macOS and Linux with no external dependencies
- `powers.json` agent configuration with `skill://` on-demand resource loading
- Bilingual README and CHANGELOG (English / Korean)
- 16 skills from [kirodotdev/powers](https://github.com/kirodotdev/powers): aws-agentcore, aws-amplify, aws-healthomics, aws-iac, aws-sam, cloud-architect, cloudwatch-appsignals, saas-builder, strands, datadog, dynatrace, figma, neon, postman, stripe, terraform
- 11 skills from [whchoi98/kiro-cli-power](https://github.com/whchoi98/kiro-cli-power): aws-cloudwatch, aws-cost, aws-data, aws-iam, aws-infra, aws-messaging, aws-security, code-review, refactor, release, sync-docs

[Unreleased]: https://github.com/whchoi98/aws-skills-for-claude-code/compare/v1.3.0...HEAD
[1.3.0]: https://github.com/whchoi98/aws-skills-for-claude-code/compare/v1.2.0...v1.3.0
[1.2.0]: https://github.com/whchoi98/aws-skills-for-claude-code/compare/v1.1.0...v1.2.0
[1.1.0]: https://github.com/whchoi98/aws-skills-for-claude-code/compare/v1.0.0...v1.1.0
[1.0.0]: https://github.com/whchoi98/aws-skills-for-claude-code/releases/tag/v1.0.0

---

# 한국어

이 프로젝트의 모든 주요 변경 사항은 이 파일에 기록됩니다.
이 문서는 [Keep a Changelog](https://keepachangelog.com/en/1.1.0/)를 기반으로 하며,
[Semantic Versioning](https://semver.org/spec/v2.0.0.html)을 따릅니다.

## [Unreleased]

### Added

- **독립 마켓플레이스** -- `.claude-plugin/marketplace.json`으로 `/plugin marketplace add` 설치 지원
- README에 마켓플레이스 설치 안내 추가 (EN/KR)

## [1.3.0] - 2026-04-06

### Added

- **Claude Code 플러그인 지원** -- `.claude-plugin/plugin.json` 매니페스트 (제로 중복 아키텍처)
- 플러그인 에이전트: `agents/code-reviewer.md`, `agents/security-auditor.md` (Markdown 형식)
- 플러그인 훅: `hooks/hooks.json` (SessionStart, Notification) `$CLAUDE_PLUGIN_ROOT` 경로 사용
- TAP 형식 테스트 스위트: 99개 어설션 (훅, 시크릿 패턴, 프로젝트 구조, 플러그인 구조)
- 위험 명령어 차단 목록 추가 (rm -rf, git push --force, git reset --hard 등)
- 4개 프로젝트 스킬에 YAML frontmatter `description` 추가 (플러그인 자동 발견용)
- `tests/` 및 `scripts/` 디렉토리 모듈 CLAUDE.md 추가
- ADR-003: 제로 중복 플러그인 아키텍처
- Claude Code 훅 추가: 시크릿 스캔(PreCommit), 세션 컨텍스트 로딩(SessionStart), 웹훅 알림(Notification)
- 슬래시 커맨드 추가: `/review`, `/test-all`, `/deploy`
- 에이전트 정의 추가: `code-reviewer`, `security-auditor`
- 개발자 온보딩 가이드 추가 (`docs/onboarding.md`)
- 아키텍처 결정 기록: ADR-001 (heredoc 스킬 내장), ADR-002 (2단계 설치 파이프라인)
- 업스트림 동기화 런북 추가 (`docs/runbooks/upstream-sync.md`)
- MIT LICENSE 파일 추가 (업스트림 라이선스 참조 포함)
- 프로젝트 셋업 스크립트(`scripts/setup.sh`) 및 Git 훅 설치 스크립트(`scripts/install-hooks.sh`) 추가
- 설정 파일 추가: `.editorconfig`, `.env.example`, `.mcp.json`

### Changed

- 스킬 배포 프로젝트에서 Claude Code 플러그인으로 전환 (40개 스킬, 3개 커맨드, 2개 에이전트, 2개 훅)
- `plugin.json`이 `.kiro/skills/`와 `.claude/skills/`를 커스텀 경로로 참조 (파일 중복 없음)
- README.md에 플러그인 설치 방법 추가 (이중 언어)
- `docs/architecture.md`에 Plugin Layer 추가 및 시스템 개요 업데이트 (이중 언어)
- CLAUDE.md에 플러그인 아키텍처, 40개 스킬, 확장된 Key Files 반영
- `.claude/settings.json`에 4개 훅 이벤트 및 위험 명령어 차단 목록 추가

## [1.2.0] - 2026-04-04

### Added

- Claude Code 개발 워크플로우를 위한 `CLAUDE.md` 프로젝트 설정 추가
- PostToolUse 이벤트로 트리거되는 문서 동기화 훅(`check-doc-sync.sh`) 추가

### Changed

- Agent Skills 스펙 준수를 위해 Powers 출처 13개 스킬에서 `name` 필드 제거 (디렉토리명 자동 사용)
- 스킬 소스 URL을 `whchoi98/mcp-tool-forge`에서 `whchoi98/kiro-cli-power`로 변경

## [1.1.0] - 2026-04-04

### Added

- [kirodotdev/powers](https://github.com/kirodotdev/powers) 기반 9개 신규 스킬 추가 (총 27개 → 36개)
- `arm-soc-migration` -- Arm SoC 마이그레이션 (아키텍처 인식 분석)
- `aws-graviton-migration` -- Graviton (Arm64) 호환성 분석 및 포팅
- `aws-mcp` -- 15,000+ AWS API 및 Agent SOP 기반 멀티스텝 작업
- `aws-observability` -- CloudWatch 종합 옵저버빌리티 (로그, 메트릭, 알람, APM, CloudTrail)
- `checkout` -- Checkout.com 결제 처리 API
- `gcp-aws-migrate` -- 5단계 GCP→AWS 마이그레이션 어드바이저
- `power-builder` -- 스킬 제작 및 테스트 가이드
- `spark-troubleshooting` -- EMR, Glue, SageMaker 기반 Spark 트러블슈팅
- `stackgen` -- StackGen 멀티클라우드 IaC 관리
- Claude Code 온디맨드 스킬 로딩용 `install-claude-code.sh` 설치 스크립트 추가

### Changed

- 스킬 목록을 4개 카테고리로 재구성: AWS 서비스 (16), 마이그레이션 및 특수 (5), 외부 서비스 (9), 개발 워크플로우 (6)

## [1.0.0] - 2026-04-04

### Added

- YAML frontmatter 기반 키워드 활성화를 지원하는 Kiro CLI용 27개 온디맨드 스킬
- macOS와 Linux를 지원하는 `install-skills.sh` 글로벌 설치 스크립트 (외부 의존성 없음)
- `skill://` 온디맨드 리소스 로딩을 포함한 `powers.json` 에이전트 설정
- 이중 언어 README 및 CHANGELOG (영어 / 한국어)
- [kirodotdev/powers](https://github.com/kirodotdev/powers) 기반 16개 스킬: aws-agentcore, aws-amplify, aws-healthomics, aws-iac, aws-sam, cloud-architect, cloudwatch-appsignals, saas-builder, strands, datadog, dynatrace, figma, neon, postman, stripe, terraform
- [whchoi98/kiro-cli-power](https://github.com/whchoi98/kiro-cli-power) 기반 11개 스킬: aws-cloudwatch, aws-cost, aws-data, aws-iam, aws-infra, aws-messaging, aws-security, code-review, refactor, release, sync-docs

[Unreleased]: https://github.com/whchoi98/aws-skills-for-claude-code/compare/v1.3.0...HEAD
[1.3.0]: https://github.com/whchoi98/aws-skills-for-claude-code/compare/v1.2.0...v1.3.0
[1.2.0]: https://github.com/whchoi98/aws-skills-for-claude-code/compare/v1.1.0...v1.2.0
[1.1.0]: https://github.com/whchoi98/aws-skills-for-claude-code/compare/v1.0.0...v1.1.0
[1.0.0]: https://github.com/whchoi98/aws-skills-for-claude-code/releases/tag/v1.0.0
