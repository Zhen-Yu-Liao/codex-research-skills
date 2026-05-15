---
name: zotero-reference-manager
description: 用於 Zotero 與 Better BibTeX 文獻工作流。當任務需要整理 citation key、同步 `references.bib`、檢查 bibliographic metadata、設計 auto-export 流程，或維持 LaTeX/Markdown/Quarto 引用來源一致性時使用；若問題是 claim 是否被文獻支撐，改用 thesis-citation-logic-auditor。
---

# Zotero Reference Manager

管理 citation source of truth，讓 Zotero、Better BibTeX、`.bib` 與論文稿件使用同一套可追蹤的引用資料。

## 標準流程

1. 先確認使用者的寫作目標：LaTeX、Markdown、Quarto、Word 或 Google Docs。
2. 檢查目前 source of truth 是 Zotero library、Better BibTeX auto-export，還是手動維護的 `.bib`。
3. 檢查 citation key 規則是否穩定，避免改名後破壞既有稿件引用。
4. 對 metadata 做最小必要修正建議：作者、年份、標題大小寫、期刊/會議名稱、DOI、URL、arXiv id。
5. 若使用 auto-export，確認輸出位置、格式、排序與檔名是否和 repo 中的引用設定一致。

## 原則

- Zotero/Better BibTeX 應是 bibliography metadata 的主要來源；避免直接手改 auto-export 產生的 `.bib`。
- 不要為了讓 LaTeX 先過而捏造 citation key。
- 若必須新增 key，先確認 metadata 與實際文獻主張，再同步到稿件。
- key pattern 應穩定、可讀、低衝突；不要在論文後期任意重命名大量 keys。

## 何時改用其他 skill

- 文獻是否真的支撐某句 claim：改用 `thesis-citation-logic-auditor`
- LaTeX citation command、bibliography style 或 build error：改用 `latex-academic-writer` 或 `thesis-build-guard`
- 草稿段落要落成正式 thesis prose：改用 `thesis-draft-to-latex`

## 範例 key pattern

常見 Better BibTeX pattern：

```text
[auth:lower][year][shorttitle:lower]
```

使用前先確認是否會和既有 keys 衝突；若 repo 已經有固定 key style，以既有 style 為準。
