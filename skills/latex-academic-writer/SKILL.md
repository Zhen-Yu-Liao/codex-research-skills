---
name: latex-academic-writer
description: 用於 LaTeX thesis 與 academic writing 的排版、公式、表格、浮動體、BibTeX/BibLaTeX 與 build error 修復。當使用者需要調整 `.tex` 結構、修 LaTeX 語法、整理公式環境、改善 figure/table/caption 或 bibliography 設定時使用；若問題是論證、citation 是否支撐 claim，改用 thesis 類 skills。
---

# LaTeX Academic Writer

把 LaTeX 問題拆成可編譯、可維護、符合學術寫作慣例的修法。這個 skill 處理排版與 LaTeX 結構，不負責判斷章節論證是否成立。

## 標準流程

1. 先確認專案使用的 engine 與 build 方式，例如 `latexmkrc`、XeLaTeX、LuaLaTeX、BibTeX 或 BibLaTeX。
2. 讀 entry file、preamble、目標 `.tex`、相關 `.bib`、錯誤 log 與最近修改。
3. 區分問題類型：
   - document structure：`\documentclass`、preamble、`\input`、`\include`
   - math typesetting：inline/display math、`equation`、`align`、矩陣、多行推導
   - floats：`figure`、`table`、`\caption`、`\label`、`\ref`
   - bibliography：BibTeX/BibLaTeX 設定、citation command、style file
   - build errors：missing package、undefined control sequence、missing file、encoding/font issue
4. 優先做最小修正，不為了美化而重寫整份 preamble。
5. 修改後建議用專案既有 build command 驗證，並回報仍需使用者確認的排版或引用風險。

## 修法原則

- 使用語義化 LaTeX 結構，例如 `\section`、`\subsection`、`\emph`、`equation`、`align`、`figure`、`table`。
- 避免手動硬調字級、空白或位置，除非是為了解決明確排版問題。
- 表格優先使用清楚欄位、`booktabs` 風格與可讀 caption。
- 圖表應先確保路徑、label、caption、引用順序與正文一致，再調整浮動位置。
- 不捏造 citation key；bibliography 問題需要和 `.bib` 或 Zotero/Better BibTeX 工作流對齊。

## 何時改用其他 skill

- citation 是否真的支撐某個 claim：改用 `thesis-citation-logic-auditor`
- 草稿要寫成正式 thesis prose：改用 `thesis-draft-to-latex`
- 整份 thesis build、entry wiring、log 與 PDF artifact 驗證：改用 `thesis-build-guard`
- Zotero、Better BibTeX、citation key 規則：改用 `zotero-reference-manager`

## 禁止事項

- 不要在沒讀 preamble 與 entry file 時直接建議大幅改 package。
- 不要把所有排版問題都用 `\vspace`、`\hspace`、`[H]` 或手動換頁壓過去。
- 不要把 LaTeX 排版修正擴張成論文論證重寫。
