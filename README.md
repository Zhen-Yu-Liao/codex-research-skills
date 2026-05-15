# Codex Research Skills

這個 repo 打包一組給 Codex 使用的 research workflow skills，重點是兩件事：

- 用 subagents 做長任務、規劃、除錯與交付前驗證。
- 用 LaTeX 寫 thesis 時，協助論證規劃、citation/claim 審查、草稿落成、編譯檢查與文獻管理。

這個 repo 可直接從 GitHub 安裝。公開或更新 release 前，請先跑完 `docs/release-checklist.md`。

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
python "$env:USERPROFILE\.codex\skills\.system\skill-installer\scripts\install-skill-from-github.py" --repo Zhen-Yu-Liao/codex-research-skills --path skills/subagent-prompt-longrun skills/subagent-prompt-planning skills/subagent-prompt-debug skills/subagent-prompt-handoff
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
python "$env:USERPROFILE\.codex\skills\.system\skill-installer\scripts\install-skill-from-github.py" --repo Zhen-Yu-Liao/codex-research-skills --path skills/thesis-shared-references skills/thesis-argument-planner skills/thesis-build-guard skills/thesis-citation-logic-auditor skills/thesis-draft-to-latex
```

`thesis-shared-references` 是共享依賴資料夾，不是 triggerable skill；安裝 thesis pack 時仍必須一起安裝。

### `latex-thesis-support`

適合使用 LaTeX 寫 thesis 時的排版與 bibliography 工作流。

包含：

- `latex-academic-writer`
- `zotero-reference-manager`

安裝：

```powershell
python "$env:USERPROFILE\.codex\skills\.system\skill-installer\scripts\install-skill-from-github.py" --repo Zhen-Yu-Liao/codex-research-skills --path skills/latex-academic-writer skills/zotero-reference-manager
```

安裝後請重新啟動 Codex，讓新的 skills 被載入。

macOS/Linux 使用者可將 installer path 換成：

```bash
python "$HOME/.codex/skills/.system/skill-installer/scripts/install-skill-from-github.py" --repo Zhen-Yu-Liao/codex-research-skills --path skills/subagent-prompt-longrun
```

## 怎麼選 Skill

使用時優先直接點名 skill，例如「請用 `subagent-prompt-longrun` ...」或「請用 `thesis-argument-planner` ...」。如果任務跨多個階段，先用規劃或審查型 skill，確認方向後再進入成稿或驗證。

### Subagent Workflow Skills

| Skill | 角色 | 何時使用 | 典型輸入 | 產出 |
| --- | --- | --- | --- | --- |
| `subagent-prompt-longrun` | 長任務總控 prompt 產生器 | 想讓 Codex 用多個 subagents 完成一個完整開發任務 | repo、`Spec.md`、`AGENTS.md`、驗收標準、目前限制 | 一份可直接貼給 Codex 的 one-shot / long-run subagent prompt |
| `subagent-prompt-planning` | 純規劃 prompt 產生器 | 只想先拆架構、ownership、風險與驗收，不想立刻改檔 | repo、需求文件、已知限制、希望比較的方案 | 一份只做 planning 的 decision-complete prompt |
| `subagent-prompt-debug` | root-cause-first 除錯 prompt 產生器 | 已有錯誤、失敗測試、build failure 或不穩定行為 | 錯誤訊息、失敗命令、stack trace、相關檔案 | 一份要求先重現、找 root cause、最小修復與回歸驗證的 prompt |
| `subagent-prompt-handoff` | 交付前審查 prompt 產生器 | 功能大致完成，需要最後 review、測試、文件同步與風險掃描 | 已完成的 branch、README、tests、`.env.example`、release checklist | 一份 release-readiness review / verification prompt |

Subagent workflow 的核心模式是兩段式：先用本 repo 的 skill 產生高品質 prompt，再把該 prompt 貼回 Codex 執行。這些 skills 本身不直接替你開發功能，而是約束下一輪 Codex/subagents 如何工作。

使用時可以這樣指定目的：

```text
請用 subagent-prompt-longrun 先掃描這個 repo、Spec.md、測試指令和可用 skills，產生一份可直接貼給 Codex 的長任務 subagent prompt。請把工作切成不重疊的 bounded jobs，並要求每個 subagent 回報 changed files、commands run、tests run 和 open risks。
```

```text
請用 subagent-prompt-debug 根據這個錯誤訊息和失敗指令產生除錯 prompt。重點是先重現問題、確認 root cause、做最小修復，最後要求回歸測試證據；不要讓下一輪 agent 順手做大重構。
```

### Thesis Core Skills

| Skill | 角色 | 何時使用 | 典型輸入 | 產出 |
| --- | --- | --- | --- | --- |
| `thesis-argument-planner` | 論證與章節結構規劃 | 章節還沒寫穩、段落順序混亂、研究缺口或 contribution 不清楚 | 章節草稿、outline、相鄰章節、指導教授意見 | structure-only 的章節骨架、段落功能表、claim-evidence gap list |
| `thesis-citation-logic-auditor` | claim / evidence / citation 審查 | 擔心某段話說得比 citation 支撐得更多，或要送出前做邏輯審查 | 目標段落、`.bib` 或 citation key、相關文獻摘要/原文 | findings-first 的 citation/logic 問題清單與修法 |
| `thesis-draft-to-latex` | 草稿到正式 `.tex` | 已有草稿或規劃，想落成正式 thesis prose 與 LaTeX 結構 | 草稿、目標 `.tex`、既有章節 style、citation key | 可放入正式章節的 LaTeX prose、公式、引用與缺口說明 |
| `thesis-build-guard` | LaTeX thesis build 與 wiring 驗證 | 修改 `.tex`、`.bib`、圖表、preamble 後，需要確認能編譯且掛載正確 | entry file、`latexmkrc`、build log、修改檔案 | blocking / high-risk / warning 分級 findings 與最小修法 |
| `thesis-shared-references` | 共享 thesis conventions | 安裝 `thesis-core` 時一起安裝，供其他 thesis skills 讀取 | 不直接觸發 | 通用 thesis 寫作規則；statistics convention 只在相關任務中選讀 |

`thesis-shared-references` 不是 triggerable skill。不要直接要求 Codex「使用 thesis-shared-references」完成任務；它的功能是提供其他 thesis skills 的共同規範。

### 寫作風格放在哪裡

論文寫作風格主要放在：

- `skills/thesis-shared-references/thesis_base_conventions.md`

這份檔案定義跨 thesis 共用的寫作與編修規則，例如：

- 先讀現有稿件，再補寫內容。
- 不捏造 citation key、文獻結論、數值結果或定理條件。
- 新符號第一次出現時要說明它在當前段落中的角色。
- 對讀者可能卡住的符號切換或估計對象切換，優先補短 prose bridge。
- 避免生硬直譯、過度抽象術語、模板化 AI prose 和沒有來源支撐的新名詞。

以下 thesis skills 會在「讀取順序」中讀取它：

- `thesis-argument-planner`
- `thesis-build-guard`
- `thesis-citation-logic-auditor`
- `thesis-draft-to-latex`

如果 `thesis-shared-references` 沒有安裝，這些 skills 仍可使用本身的通用規則執行，但會少掉共享寫作風格與一致性約束。因此安裝 `thesis-core` 時建議一定包含 `skills/thesis-shared-references`。

領域層規範放在：

- `skills/thesis-shared-references/statistics_thesis_conventions.md`

這份檔案不是所有 thesis 任務的預設規範；只有當論文明確涉及 statistics、methodology 或 math-heavy empirical thesis 時，相關 thesis skills 才會讀它。

### LaTeX Thesis Support Skills

| Skill | 角色 | 何時使用 | 典型輸入 | 產出 |
| --- | --- | --- | --- | --- |
| `latex-academic-writer` | LaTeX 學術排版與公式結構支援 | 問題集中在 LaTeX 語法、公式、表格、浮動體、bibliography style | `.tex` 片段、錯誤訊息、排版需求 | LaTeX 結構修法、範例片段、排版建議 |
| `zotero-reference-manager` | Zotero / Better BibTeX 文獻工作流 | 需要整理 citation key、`references.bib` auto-export、metadata 一致性 | Zotero/BBT 設定、`.bib`、citation key 規則 | 文獻同步策略、key pattern、metadata 清理建議 |

這兩個 skills 適合 LaTeX thesis 的支援任務；若問題是章節論證或 citation 是否支撐 claim，優先使用 `thesis-argument-planner` 或 `thesis-citation-logic-auditor`。

使用時可以這樣指定目的：

```text
請用 latex-academic-writer 檢查這段 LaTeX 表格與 caption 寫法，目標是讓它符合 thesis 排版慣例並能穩定編譯。請不要改動章節論證，只處理 LaTeX 結構。
```

```text
請用 zotero-reference-manager 幫我規劃 Zotero / Better BibTeX 到 references.bib 的同步方式，重點是 citation key 穩定、metadata 乾淨，且不要破壞既有稿件引用。
```

## 常見工作流

### 1. 讓 Codex 長時間完成一個專案任務

1. 在 repo 中準備 `Spec.md`、驗收標準、目前限制。
2. 啟動：
   ```text
   請用 subagent-prompt-longrun 掃描這個 repo、Spec.md、測試指令、build scripts 和可用 skills，產生一份可直接貼給 Codex 的長任務 subagent prompt。
   ```
3. 把產出的 prompt 貼回 Codex 執行。
4. 完成後再用 `subagent-prompt-handoff` 產生交付前審查 prompt。

### 2. 只想先規劃，不要改檔

```text
請用 subagent-prompt-planning 掃描這個 repo，產生一份只做規劃、不做實作的 prompt。輸出要 decision-complete，讓下一輪 agent 不需要再做高層決策。
```

適合需求還不穩、想先拆 ownership、API、測試策略或風險時使用。

### 3. 有錯誤要修，但不想讓 Codex 亂 patch

```text
請用 subagent-prompt-debug 根據這個失敗指令和錯誤 log 產生除錯 prompt。請要求下一輪 agent 先重現問題，再找 root cause，最後用最小修復與回歸驗證收斂。
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
請用 subagent-prompt-longrun 先掃描目前 repo 和可用 skills，產生一份長任務 subagent prompt，讓下一輪 Codex 可以完成開發、整合、測試與交付前檢查。
```

```text
請用 thesis-argument-planner 先做 structure-only 的章節論證規劃，不要直接改正式稿。
```

```text
請用 thesis-citation-logic-auditor 檢查這一節的 claim 是否真的被 citation 支撐。
```

```text
請用 thesis-draft-to-latex 把這份草稿轉成正式 thesis 段落，沿用現有 `.tex` 章節風格，不要新增未確認的 citation key。
```

```text
請用 thesis-build-guard 檢查這次修改後的 thesis 是否能可靠編譯，並確認章節掛載、citation、reference、圖表路徑和 build artifact 都一致。
```

```text
請用 zotero-reference-manager 檢查目前 citation key 規則和 `references.bib` 同步流程，避免 Zotero auto-export 破壞既有稿件引用。
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
