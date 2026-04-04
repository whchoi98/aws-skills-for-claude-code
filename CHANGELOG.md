# Changelog

[![English](https://img.shields.io/badge/lang-English-blue.svg)](#english) [![한국어](https://img.shields.io/badge/lang-한국어-red.svg)](#한국어)

---

<a id="english"></a>

# English

All notable changes to this project will be documented in this file.
The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [1.2.0] - 2026-04-04

### Added

- `CLAUDE.md` project configuration for Claude Code development workflows

### Changed

- Remove `name` field from 13 Powers-sourced skills for [Agent Skills spec](https://agentskills.io/specification) compliance (directory name used as fallback)
- Update skill source URL from `whchoi98/mcp-tool-forge` to `whchoi98/kiro-cli-power`
- Add `CLAUDE.md` to project structure in README

## [1.1.0] - 2026-04-04

### Added

- 9 new skills from [kirodotdev/powers](https://github.com/kirodotdev/powers), bringing total from 27 to 36
- `arm-soc-migration` — Arm SoC migration with architecture-aware analysis
- `aws-graviton-migration` — Graviton (Arm64) compatibility analysis and porting
- `aws-mcp` — Multi-step AWS tasks with 15,000+ APIs and Agent SOPs
- `aws-observability` — Comprehensive CloudWatch observability (Logs, Metrics, Alarms, APM, CloudTrail)
- `checkout` — Checkout.com payment processing APIs
- `gcp-aws-migrate` — 5-phase GCP to AWS migration advisor
- `power-builder` — Guide for building and testing new Kiro Powers
- `spark-troubleshooting` — Spark troubleshooting on EMR, Glue, and SageMaker
- `stackgen` — StackGen multi-cloud IaC management
- `install-claude-code.sh` installer for Claude Code on-demand skill loading

### Changed

- Reorganize skills list into 4 categories: AWS Services (16), Migration & Specialized (5), External Services (9), Development Workflows (6)
- Update README to reflect 36 skills with bilingual dual-platform documentation

## [1.0.0] - 2026-04-04

### Added

- 27 on-demand skills for Kiro CLI with YAML frontmatter for keyword-triggered activation
- `install-skills.sh` global installer for macOS and Linux with no external dependencies
- `powers.json` agent configuration with `skill://` on-demand resource loading
- Bilingual README and CHANGELOG (English / Korean)
- 16 skills from [kirodotdev/powers](https://github.com/kirodotdev/powers): aws-agentcore, aws-amplify, aws-healthomics, aws-iac, aws-sam, cloud-architect, cloudwatch-appsignals, saas-builder, strands, datadog, dynatrace, figma, neon, postman, stripe, terraform
- 11 skills from [whchoi98/kiro-cli-power](https://github.com/whchoi98/kiro-cli-power): aws-cloudwatch, aws-cost, aws-data, aws-iam, aws-infra, aws-messaging, aws-security, code-review, refactor, release, sync-docs

[Unreleased]: https://github.com/whchoi98/aws-skills-for-claude-code/compare/v1.2.0...HEAD
[1.2.0]: https://github.com/whchoi98/aws-skills-for-claude-code/compare/v1.1.0...v1.2.0
[1.1.0]: https://github.com/whchoi98/aws-skills-for-claude-code/compare/v1.0.0...v1.1.0
[1.0.0]: https://github.com/whchoi98/aws-skills-for-claude-code/releases/tag/v1.0.0

---

<a id="한국어"></a>

# 한국어

이 프로젝트의 모든 주요 변경 사항은 이 파일에 기록됩니다.
이 문서는 [Keep a Changelog](https://keepachangelog.com/en/1.1.0/)를 기반으로 하며,
[Semantic Versioning](https://semver.org/spec/v2.0.0.html)을 따릅니다.

## [Unreleased]

## [1.2.0] - 2026-04-04

### Added

- Claude Code 개발 워크플로우를 위한 `CLAUDE.md` 프로젝트 설정 추가

### Changed

- [Agent Skills 스펙](https://agentskills.io/specification) 준수를 위해 Powers 출처 13개 스킬에서 `name` 필드 제거 (디렉토리명을 자동 사용)
- 스킬 소스 URL을 `whchoi98/mcp-tool-forge`에서 `whchoi98/kiro-cli-power`로 변경
- README 프로젝트 구조에 `CLAUDE.md` 추가

## [1.1.0] - 2026-04-04

### Added

- [kirodotdev/powers](https://github.com/kirodotdev/powers) 기반 9개 신규 스킬 추가 (총 27개 → 36개)
- `arm-soc-migration` — Arm SoC 마이그레이션 (아키텍처 인식 분석)
- `aws-graviton-migration` — Graviton (Arm64) 호환성 분석 및 포팅
- `aws-mcp` — 15,000+ AWS API 및 Agent SOP 기반 멀티스텝 작업
- `aws-observability` — CloudWatch 종합 옵저버빌리티 (로그, 메트릭, 알람, APM, CloudTrail)
- `checkout` — Checkout.com 결제 처리 API
- `gcp-aws-migrate` — 5단계 GCP→AWS 마이그레이션 어드바이저
- `power-builder` — Kiro Power 제작 및 테스트 가이드
- `spark-troubleshooting` — EMR, Glue, SageMaker 기반 Spark 트러블슈팅
- `stackgen` — StackGen 멀티클라우드 IaC 관리
- Claude Code 온디맨드 스킬 로딩용 `install-claude-code.sh` 설치 스크립트 추가

### Changed

- 스킬 목록을 4개 카테고리로 재구성: AWS 서비스 (16), 마이그레이션 및 특수 (5), 외부 서비스 (9), 개발 워크플로우 (6)
- README를 36개 스킬 기준 이중 언어 이중 플랫폼 문서로 갱신

## [1.0.0] - 2026-04-04

### Added

- YAML frontmatter 기반 키워드 활성화를 지원하는 Kiro CLI용 27개 온디맨드 스킬
- macOS와 Linux를 지원하는 `install-skills.sh` 글로벌 설치 스크립트 (외부 의존성 없음)
- `skill://` 온디맨드 리소스 로딩을 포함한 `powers.json` 에이전트 설정
- 이중 언어 README 및 CHANGELOG (영어 / 한국어)
- [kirodotdev/powers](https://github.com/kirodotdev/powers) 기반 16개 스킬: aws-agentcore, aws-amplify, aws-healthomics, aws-iac, aws-sam, cloud-architect, cloudwatch-appsignals, saas-builder, strands, datadog, dynatrace, figma, neon, postman, stripe, terraform
- [whchoi98/kiro-cli-power](https://github.com/whchoi98/kiro-cli-power) 기반 11개 스킬: aws-cloudwatch, aws-cost, aws-data, aws-iam, aws-infra, aws-messaging, aws-security, code-review, refactor, release, sync-docs

[Unreleased]: https://github.com/whchoi98/aws-skills-for-claude-code/compare/v1.2.0...HEAD
[1.2.0]: https://github.com/whchoi98/aws-skills-for-claude-code/compare/v1.1.0...v1.2.0
[1.1.0]: https://github.com/whchoi98/aws-skills-for-claude-code/compare/v1.0.0...v1.1.0
[1.0.0]: https://github.com/whchoi98/aws-skills-for-claude-code/releases/tag/v1.0.0
