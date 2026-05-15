---
name: thesis-build-guard
description: 守住 thesis 專案的 LaTeX 編譯、章節掛載、citation/reference 解析、資產路徑與 build artifact 一致性。當使用者要求檢查論文能否可靠編譯、修 LaTeX build error、確認章節是否真的掛進 entry file，或在修改 `.tex`、`.bib`、圖表後做最終驗證時使用。
---

# Thesis Build Guard

把 thesis 專案當成一個 LaTeX 系統來檢查，不只看能不能出 PDF，也看 entry file、chapter wiring、bibliography、assets 與 log 是否一致。這個 skill 的重點是避免「看起來有 PDF，但實際上內容已經脫軌」。

## 讀取順序

1. 若存在，讀 `../thesis-shared-references/thesis_base_conventions.md`；若缺少，使用本 skill 的通用 thesis build 規則並在回覆中標記 shared references 未安裝
2. 若使用者的論文明確屬於 statistics、methodology 或 math-heavy empirical thesis，讀 `../thesis-shared-references/statistics_thesis_conventions.md`
3. 讀 `references/latex_build_triage.md`
4. 若 workspace 存在 `.agent/references/thesis_project_conventions.md`，讀它並覆寫前述慣例
5. 讀 `thesis/README.md`、entry file、`latexmkrc`、preamble、最近修改檔與現有 build log

## 標準流程

### 1. 先做靜態檢查

至少檢查：

- entry file 掛了哪些章節；常見名稱包含 `main.tex`、`thesis.tex` 或專案自訂入口
- 目標章節是否真的被掛載
- `\input`、`\includegraphics`、bibliography 路徑是否存在
- preamble 中定義的 theorem/citation 宏是否與正文用法一致
- `.bib` 中的 key 是否與正文引用一致

### 2. 再判斷是否需要 build

以下情況通常應實際編譯：

- 正式 `.tex`、`.bib`、圖表路徑或 preamble 剛被修改
- 使用者明確要求驗證
- 靜態檢查已看見 unresolved citation/ref 風險
- 專案有多個可能的 build artifact，需確認哪份 PDF 才是最新結果
- 圖片、表格、caption、字級、間距或浮動位置剛被調整，需檢查排版是否仍可讀

### 3. 執行 build 與讀 log

若需要 build，優先遵守專案現有 `latexmkrc`。執行後檢查：

- error
- warning
- undefined citation
- undefined reference
- missing file
- multiply-defined labels

若 PDF 仍產出，不代表沒有問題；需回到 log 與結構面確認。

### 3.1 視覺排版檢查

- 編譯成功不是完成條件；必須同時檢查圖片、表格、文字與 caption 的比例是否易讀
- 檢查是否有過度留白、突兀跳頁、浮動體卡在不合理位置、單頁只有少量內容、caption 擠壓正文等版面問題
- 若圖表過大、過小或與正文節奏失衡，應調整尺寸、浮動選項、分頁策略或段落位置後再重新輸出
- 需要時重複 build 與檢查，直到版面達到「正常閱讀不會被排版干擾」的標準

### 4. 分級回報

輸出時區分：

- `blocking`: build fail、檔案缺失、環境不匹配、核心 chapter 沒有掛載
- `high-risk`: PDF 可產出但 citation/ref/bibliography/章節內容不可信
- `warning`: 可編譯，但有 stale artifact、placeholder wiring、重複 label、維護性風險

## 建議輸出

優先回報：

- findings-first 的問題清單
- 哪些檔案影響了 build 結果
- 若有執行編譯，摘要關鍵 log 訊息
- 建議的最小修法
- 若版面已調校，應說明哪些圖表或頁面曾有可讀性問題，以及本輪如何修正

## 何時改用其他 skill

- 若問題在於章節論證本身，改用 `thesis-argument-planner`
- 若問題在於段落內容與正式稿落地，改用 `thesis-draft-to-latex`
- 若問題在於 citation 是否真的支撐 claim，改用 `thesis-citation-logic-auditor`

## 禁止事項

- 不要只因為 PDF 存在就宣告沒問題
- 不要忽略 `latexmkrc` 與實際 build output 位置
- 不要在未經確認時直接清除所有 build artifact
- 不要在排版明顯難讀、留白異常或圖表比例失衡時，就以「可編譯」作為交付結論
