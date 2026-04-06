# Skills Module

## Role
36개 AWS/클라우드 스킬의 표준 플러그인 디렉토리. 업스트림(Powers, MCP Tool Forge)에서 가져온 SKILL.md 파일 + 4개 프로젝트 커스텀 스킬.

## Key Files
- `{skill-name}/SKILL.md` — 각 스킬의 정의 파일 (YAML frontmatter + Markdown)

## Rules
- 업스트림 원본 최대한 유지 (수정 최소화)
- `name` 필드가 디렉토리명과 불일치 시 행 제거 (내용 변경 아님)
- 새 스킬 추가 시 반드시 YAML frontmatter에 `description` 포함

## Adding a New Skill

1. `mkdir skills/<skill-name>/`
2. Create `SKILL.md` with YAML frontmatter: `---\ndescription: ...\n---`
3. Run `bash install-claude-code.sh` to deploy
4. Update skill count in `README.md` (EN/KR) and `CHANGELOG.md`

## Validation

```bash
# Check all skills have SKILL.md with description
for d in */; do
    head -3 "$d/SKILL.md" 2>/dev/null | grep -q 'description:' || echo "MISSING: $d"
done
```
