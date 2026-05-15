# Thesis LaTeX Build Triage

## 讀取優先順序

1. `main.tex` 或其他 entry file
2. `styles/preamble.tex` 或等價 style 檔
3. `latexmkrc` 或 build 設定
4. 最近修改的章節檔、`.bib`、圖表檔
5. build log、`.aux`、`.bbl`、`.blg`

## 常見問題類型

### 結構問題

- 章節檔存在但沒有掛進 `main.tex`
- `\input{...}` 路徑錯誤
- 重複章節或 placeholder 章節仍被掛載
- appendix、bibliography、acknowledgement 順序錯誤

### Citation 與 bibliography 問題

- undefined citation
- `.bib` key 不存在
- bibliography style 與 citation 宏衝突
- `.bbl` 過舊導致結果與 source 不一致

### Formula 與 environment 問題

- `\begin` / `\end` 不匹配
- math mode 未關閉
- label/ref 漏掉或重複
- theorem 環境未定義但已使用

### Asset 問題

- `\includegraphics` 路徑錯誤
- figure/table 檔不存在
- 大小寫不一致
- `\graphicspath` 與實際資料夾不一致

### Build 工具問題

- `latexmkrc` 指向 `build/`，但使用者查看的是舊的 root-level log/pdf
- 多輪編譯未完成，導致 toc/ref/citation 沒更新
- `nonstopmode` 掩蓋錯誤，使 PDF 仍產出但內容有缺陷

## 審查輸出建議

輸出時區分：

- `blocking`: 不修就無法可靠編譯或內容明顯錯
- `high-risk`: PDF 可能產出，但引用、章節或內容已不可信
- `warning`: 可編譯，但結構或維護性有風險

## 建議的 build 命令

在 thesis 專案目錄下：

```powershell
latexmk -pdf main.tex
```

若需要重新整理暫存檔，再視情況補：

```powershell
latexmk -C
latexmk -pdf main.tex
```

不要先清乾淨再重編，除非已確認需要排除 stale artifact。
