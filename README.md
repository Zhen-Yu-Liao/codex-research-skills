# Codex Research Skills

這個 repo 打包一組給 Codex 使用的 research workflow skills，重點是兩件事：

- 用 subagents 做長任務、規劃、除錯與交付前驗證。
- 用 LaTeX 寫 thesis 時，協助論證規劃、citation/claim 審查、草稿落成、編譯檢查與文獻管理。

目前 repo 先以 private review 狀態交付。公開前請先完成 `docs/release-checklist.md`。

## Skill Packs

### `subagent-workflow`

適合需要先掃 repo，再產生可直接貼給 Codex 的 subagent prompt。

包含：

- `subagent-prompt-longrun`
- `subagent-prompt-planning`
- `subagent-prompt-debug`
- `subagent-prompt-handoff`

安裝：

```powershell
python "$env:USERPROFILE\.codex\skills\.system\skill-installer\scripts\install-skill-from-github.py" --repo <owner>/codex-research-skills --path skills/subagent-prompt-longrun skills/subagent-prompt-planning skills/subagent-prompt-debug skills/subagent-prompt-handoff
```

### `thesis-core`

適合正在寫 thesis 本體，需要處理章節論證、citation 支撐、草稿轉 LaTeX 或 build 驗證。

包含：

- `thesis-shared-references`
- `thesis-argument-planner`
- `thesis-build-guard`
- `thesis-citation-logic-auditor`
- `thesis-draft-to-latex`

安裝：

```powershell
python "$env:USERPROFILE\.codex\skills\.system\skill-installer\scripts\install-skill-from-github.py" --repo <owner>/codex-research-skills --path skills/thesis-shared-references skills/thesis-argument-planner skills/thesis-build-guard skills/thesis-citation-logic-auditor skills/thesis-draft-to-latex
```

`thesis-shared-references` 是共享依賴資料夾，不是 triggerable skill；安裝 thesis pack 時仍必須一起安裝。

### `latex-thesis-support`

適合使用 LaTeX 寫 thesis 時的排版與 bibliography 工作流。

包含：

- `latex-academic-writer`
- `zotero-reference-manager`

安裝：

```powershell
python "$env:USERPROFILE\.codex\skills\.system\skill-installer\scripts\install-skill-from-github.py" --repo <owner>/codex-research-skills --path skills/latex-academic-writer skills/zotero-reference-manager
```

安裝後請重新啟動 Codex，讓新的 skills 被載入。

## 使用範例

```text
Use $subagent-prompt-longrun to scan this repo and draft a long-run subagent development prompt.
```

```text
請用 thesis-argument-planner 先做 structure-only 的章節論證規劃，不要直接改正式稿。
```

```text
請用 thesis-citation-logic-auditor 檢查這一節的 claim 是否真的被 citation 支撐。
```

## 驗證

本機驗證：

```powershell
.\scripts\validate-all.ps1
.\scripts\check-public-safety.ps1
python .\scripts\validate_skill_tree.py
```

`validate-all.ps1` 會呼叫本機 Codex 的官方 `quick_validate.py`。CI 使用 `scripts/validate_skill_tree.py`，避免依賴某台機器上的 Codex 安裝路徑。

## 授權

MIT License。詳見 `LICENSE`。
