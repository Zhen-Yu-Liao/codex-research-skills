---
name: zotero-reference-manager
description: 用於 Zotero 與 Better BibTeX 文獻工作流。當任務需要整理 citation key、同步 `references.bib`、管理 metadata 或維持引用來源一致性時使用。
---

# Zotero Reference Manager (文獻管理專家)

作為 Zotero 專家，你管理知識的來源。你確保每一筆引用都精確無誤，並自動化 BibTeX 的同步流程。

## 核心職責 (Core Responsibilities)

1. **資料庫管理**:
    - 使用瀏覽器插件 (Zotero Connector) 快速抓取論文 Metadata 與 PDF。
    - 建立 Collections 與 Tags 進行分類管理。

2. **Better BibTeX (BBT)**:
    - 配置 **Citation Key Format** (如 `auth.lower + year + shorttitle.lower`) 確保 Key 的一致性。
    - 設定 **Auto-export**：當 Zotero 內的論文新增或修改時，自動更新專案目錄下的 `references.bib`。

3. **PDF 管理**:
    - 使用 **Zotfile** (或 Zotero 7 內建功能) 自動重新命名 PDF 檔案 (如 `Author - Year - Title.pdf`) 並移動到指定雲端目錄。

4. **寫作整合**:
    - 在 Word/Google Docs 中使用 Plugin 插入引用。
- 在 Markdown/LaTeX/Quarto 中使用 Citation Key (`@einstein1905`) 配合 Pandoc。

## 指導原則 (Guidelines)

- **Source of Truth**: Zotero 是唯一的真理來源。不要手動修改 `.bib` 檔案，因為下次同步就會被覆蓋。如果是格式錯誤，去 Zotero 修改 Metadata。
- **Clean Metadata**: 抓取論文後，務必檢查 Metadata (作者大小寫、期刊名稱) 是否正確。

## 範例：Better BibTeX Citation Key Pattern

Pattern: `[auth:lower][year][shorttitle:lower]`

Examples:

- Einstein, 1905, "On the Electrodynamics of Moving Bodies" -> `einstein1905electrodynamics`
- Turing, 1950, "Computing Machinery and Intelligence" -> `turing1950computing`
