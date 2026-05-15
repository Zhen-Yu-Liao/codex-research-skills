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

## 怎麼選 Skill

使用時優先直接點名 skill，例如 `Use $subagent-prompt-longrun ...` 或 `請用 thesis-argument-planner ...`。如果任務跨多個階段，先用規劃或審查型 skill，確認方向後再進入成稿或驗證。

### Subagent Workflow Skills

| Skill | 角色 | 何時使用 | 典型輸入 | 產出 |
| --- | --- | --- | --- | --- |
| `subagent-prompt-longrun` | 長任務總控 prompt 產生器 | 想讓 Codex 用多個 subagents 完成一個完整開發任務 | repo、`Spec.md`、`AGENTS.md`、驗收標準、目前限制 | 一份可直接貼給 Codex 的 one-shot / long-run subagent prompt |
| `subagent-prompt-planning` | 純規劃 prompt 產生器 | 只想先拆架構、ownership、風險與驗收，不想立刻改檔 | repo、需求文件、已知限制、希望比較的方案 | 一份只做 planning 的 decision-complete prompt |
| `subagent-prompt-debug` | root-cause-first 除錯 prompt 產生器 | 已有錯誤、失敗測試、build failure 或不穩定行為 | 錯誤訊息、失敗命令、stack trace、相關檔案 | 一份要求先重現、找 root cause、最小修復與回歸驗證的 prompt |
| `subagent-prompt-handoff` | 交付前審查 prompt 產生器 | 功能大致完成，需要最後 review、測試、文件同步與風險掃描 | 已完成的 branch、README、tests、`.env.example`、release checklist | 一份 release-readiness review / verification prompt |

Subagent workflow 的核心模式是兩段式：先用本 repo 的 skill 產生高品質 prompt，再把該 prompt 貼回 Codex 執行。這些 skills 本身不直接替你開發功能，而是約束下一輪 Codex/subagents 如何工作。

### Thesis Core Skills

| Skill | 角色 | 何時使用 | 典型輸入 | 產出 |
| --- | --- | --- | --- | --- |
| `thesis-argument-planner` | 論證與章節結構規劃 | 章節還沒寫穩、段落順序混亂、研究缺口或 contribution 不清楚 | 章節草稿、outline、相鄰章節、指導教授意見 | structure-only 的章節骨架、段落功能表、claim-evidence gap list |
| `thesis-citation-logic-auditor` | claim / evidence / citation 審查 | 擔心某段話說得比 citation 支撐得更多，或要送出前做邏輯審查 | 目標段落、`.bib` 或 citation key、相關文獻摘要/原文 | findings-first 的 citation/logic 問題清單與修法 |
| `thesis-draft-to-latex` | 草稿到正式 `.tex` | 已有草稿或規劃，想落成正式 thesis prose 與 LaTeX 結構 | 草稿、目標 `.tex`、既有章節 style、citation key | 可放入正式章節的 LaTeX prose、公式、引用與缺口說明 |
| `thesis-build-guard` | LaTeX thesis build 與 wiring 驗證 | 修改 `.tex`、`.bib`、圖表、preamble 後，需要確認能編譯且掛載正確 | entry file、`latexmkrc`、build log、修改檔案 | blocking / high-risk / warning 分級 findings 與最小修法 |
| `thesis-shared-references` | 共享 thesis conventions | 安裝 `thesis-core` 時一起安裝，供其他 thesis skills 讀取 | 不直接觸發 | 通用 thesis 寫作規則；statistics convention 只在相關任務中選讀 |

`thesis-shared-references` 不是 triggerable skill。不要直接要求 Codex「使用 thesis-shared-references」完成任務；它的功能是提供其他 thesis skills 的共同規範。

### LaTeX Thesis Support Skills

| Skill | 角色 | 何時使用 | 典型輸入 | 產出 |
| --- | --- | --- | --- | --- |
| `latex-academic-writer` | LaTeX 學術排版與公式結構支援 | 問題集中在 LaTeX 語法、公式、表格、浮動體、bibliography style | `.tex` 片段、錯誤訊息、排版需求 | LaTeX 結構修法、範例片段、排版建議 |
| `zotero-reference-manager` | Zotero / Better BibTeX 文獻工作流 | 需要整理 citation key、`references.bib` auto-export、metadata 一致性 | Zotero/BBT 設定、`.bib`、citation key 規則 | 文獻同步策略、key pattern、metadata 清理建議 |

這兩個 skills 適合 LaTeX thesis 的支援任務；若問題是章節論證或 citation 是否支撐 claim，優先使用 `thesis-argument-planner` 或 `thesis-citation-logic-auditor`。

## 常見工作流

### 1. 讓 Codex 長時間完成一個專案任務

1. 在 repo 中準備 `Spec.md`、驗收標準、目前限制。
2. 啟動：
   ```text
   Use $subagent-prompt-longrun to scan this repo, Spec.md, tests, build scripts, and available skills, then draft a long-run subagent development prompt.
   ```
3. 把產出的 prompt 貼回 Codex 執行。
4. 完成後再用 `subagent-prompt-handoff` 產生交付前審查 prompt。

### 2. 只想先規劃，不要改檔

```text
Use $subagent-prompt-planning to scan this repo and draft a planning-only prompt. The output should be decision-complete and must not ask the next agent to implement.
```

適合需求還不穩、想先拆 ownership、API、測試策略或風險時使用。

### 3. 有錯誤要修，但不想讓 Codex 亂 patch

```text
Use $subagent-prompt-debug to inspect this failure command and error log, then draft a root-cause-first debug prompt with minimal-diff repair and regression verification.
```

提供的材料越具體越好：失敗命令、錯誤訊息、CI log、最近修改檔案、可重現步驟。

### 4. 從 thesis 章節構想到正式 LaTeX

1. 先規劃，不直接成稿：
   ```text
   請用 thesis-argument-planner 先做 structure-only 的章節論證規劃，不要直接改正式稿。
   ```
2. 再審 citation 與 claim：
   ```text
   請用 thesis-citation-logic-auditor 檢查這一節的 claim 是否真的被 citation 支撐，並指出需要縮限或補證據的地方。
   ```
3. 結構與 citation 方向確認後再成稿：
   ```text
   請用 thesis-draft-to-latex 把這份草稿落成正式 .tex 段落，沿用現有章節 style，不要新增未確認的 citation key。
   ```
4. 修改 `.tex`、`.bib` 或圖表後驗證：
   ```text
   請用 thesis-build-guard 檢查 thesis 是否能可靠編譯、章節是否掛載正確、citation/reference 是否解析。
   ```

### 5. LaTeX thesis 的文獻與排版支援

- citation key、Zotero metadata、Better BibTeX auto-export：用 `zotero-reference-manager`。
- 公式、浮動體、表格、bibliography style 或 LaTeX 錯誤：用 `latex-academic-writer`。
- citation 是否真的支撐某句話：用 `thesis-citation-logic-auditor`，不要只用 Zotero skill。
- 編譯後 PDF、log、章節掛載與圖表路徑：用 `thesis-build-guard`。

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
