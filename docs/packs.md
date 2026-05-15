# Packs

這個 repo 採用「同 repo、多 pack」設計。使用者可以只安裝需要的 workflow，不必一次載入全部 skills。

## `subagent-workflow`

用途：替 Codex 產生更可靠的 subagent prompts。

適用情境：

- 需要一份 one-shot 長任務 prompt。
- 需要先做 planning，不進入實作。
- 已有錯誤、失敗測試或 build failure，需要 root-cause-first debug prompt。
- 功能大致完成，需要交付前 review、verification、docs sync prompt。

不適用情境：

- 使用者只需要單一簡單命令。
- 當前 Codex session 不支援 subagents。
- 任務尚未提供任何 repo、錯誤、規格或驗收背景。

## `thesis-core`

用途：支援 thesis 章節本體寫作與驗證。

適用情境：

- 規劃章節功能、argument flow、claim/evidence 順序。
- 審查 citation 是否真的支撐 claim。
- 將草稿、研究筆記或 Markdown 轉成正式 LaTeX。
- 檢查 LaTeX entry file、chapter wiring、bibliography、figure/table path 與 build log。

設計邊界：

- `thesis-shared-references` 是共享依賴資料夾，不是 triggerable skill。
- 預設讀 `thesis_base_conventions.md`。
- `statistics_thesis_conventions.md` 是 optional domain reference；只有處理 statistics、methodology 或 math-heavy empirical thesis 時才讀。

## `latex-thesis-support`

用途：支援 LaTeX thesis workflow 的周邊工作。

適用情境：

- 修 LaTeX 結構、公式、浮動體、表格、bibliography。
- 整理 Zotero / Better BibTeX citation key 與 `references.bib` 同步流程。

不適用情境：

- 寫一般 research report 或 Quarto report。
- 做 PDF/DOCX 轉換或泛用文件處理。
- 管理整個 Zotero library 的人工資料清理流程。
