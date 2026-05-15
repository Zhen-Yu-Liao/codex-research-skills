---
name: thesis-draft-to-latex
description: 用於 thesis 成稿。當使用者要求把草稿、研究筆記或 Markdown 規劃稿落成正式 `.tex` 章節，並對齊現有 style、公式、citation 與 chapter 邊界時使用。
---

# Thesis Draft To LaTeX

先理解稿件現有風格，再把草稿轉成正式章節文字。這個 skill 的任務不是單純翻譯，而是把筆記、草稿、公式與 citation 意圖整理成可編譯、可銜接、可維護的 LaTeX。

## 讀取順序

1. 若存在，讀 `../thesis-shared-references/thesis_base_conventions.md`；若缺少，使用本 skill 的通用 thesis drafting 規則並在回覆中標記 shared references 未安裝
2. 若使用者的論文明確屬於 statistics、methodology 或 math-heavy empirical thesis，讀 `../thesis-shared-references/statistics_thesis_conventions.md`
3. 若 workspace 存在 `.agent/references/thesis_project_conventions.md`，讀它並覆寫前述慣例
4. 讀 entry file、preamble/style、目標章節、相鄰章節、相關草稿、相關 bibliography entries
5. 視需要再讀：
   - `references/latex_style_anchors.md`
   - `references/draft_extraction_checklist.md`
   - `references/common_failure_modes.md`

## 標準流程

### 1. 先確認 target

- 確認要寫入哪個正式檔案
- 確認該檔案在 entry file 中是否真的被掛載
- 確認本次任務是新增段落、重寫段落、補公式、補 citation，還是把整份草稿落成正式稿

### 2. 抽取草稿意圖

從草稿中抽出以下元素；需要時直接套用 `references/draft_extraction_checklist.md`：

- 核心 claim
- 需要保留的 notation
- 已有 citation key
- 尚未補齊的證據或限制
- 應保留為 future work 或 limitation 的內容
- 哪些部分是 intentional placeholder，暫時不能自動刪除

### 3. 對齊專案風格

- 沿用既有 section/subsection 層級
- 沿用既有 citation 宏與引用節奏
- 沿用既有公式環境與符號記法
- 沿用當前章節語氣，不要把 introduction 寫成 methodology，也不要把 methodology 寫成 literature review
- 對齊 `references/latex_style_anchors.md` 中的 style anchor，不要靠個人偏好重排章節

### 3.1 正式論文寫作基準

- 預設把輸出視為正式版論文內容，而不是草稿、備忘錄或過渡文字
- 預設作者視角為研究生；術語密度、論證深度與敘事節奏需符合 thesis 層級與目標領域
- 語氣要自然、像人，但保持正式學術風格；避免模板化、機械化或過度生硬的 AI prose
- 用詞必須嚴謹、不誇張，並盡量直白易懂；若文獻或結果不足以支撐強語氣，主動降階改寫
- 正文中不得保留自我揭露、編輯註記、工作備忘、提示語或任何描述寫作過程的句子

### 4. 產出正式 LaTeX

預設做法如下：

- 短公式用 inline math，核心公式用 `equation` 或現有專案慣用環境
- citation 只使用已存在或已核實的新 key
- 以正式學術 prose 寫段落，不保留草稿口語或註解式語氣
- 若草稿是中文而正式稿是英文，轉換時以既有英文章節為 style anchor，不做逐句直譯
- 寫作時優先說清楚研究對象、方法步驟、條件與結論，不用堆疊模糊抽象語句
- 若草稿中夾有 TODO、提醒、補充說明或與正文無關的 meta-writing，除非使用者明確要求忠實保留，否則應轉為外部說明而不是留在正式稿中
- 若草稿只適合先做重組，不要硬落成正式稿；先退回 `thesis-argument-planner`

### 5. 交付前自查

至少檢查 `references/common_failure_modes.md` 中的風險，並覆蓋以下項目：

- 新段落是否與相鄰段落重複
- 新符號是否已定義
- citation key 是否存在
- claim 是否超出目前文獻或結果所能支持的範圍
- 是否需要建議使用者執行 build 驗證
- 文字是否仍殘留自我揭露、編輯註記、工作筆記或任何不屬於正式論文的句子
- 語氣是否符合正式論文，但仍保持自然、可讀，不落入生硬模板句
- 用詞是否精確且易懂；若有可更白話但不失學術性的寫法，優先採用
- 是否違反 `thesis_base_conventions.md` 的具體寫作修法；特別檢查連接詞重複、英文硬翻、術語過度抽象、句子過長，以及圖說中不自然的用語

## 缺資料時的處理

- 缺 citation key：不要捏造 key；在回覆中指出缺口，除非使用者明確要求 provisional placeholder
- 缺實驗數值：不要自行補數字
- 缺 theorem assumption：降低語氣或改寫成 heuristic statement
- 缺章節結構：先退回 outline 層，交給 `thesis-argument-planner`
- 缺讀者導向的 signposting：可補 bridge text，但不要藉機擴張整章重寫

## 建議輸出

當直接編修專案檔案時，優先：

- 更新正式 `.tex` 檔
- 保留章節既有註解與結構
- 在回覆中簡短說明哪些內容來自草稿、哪些缺口仍未補齊

## 禁止事項

- 不要把不存在於 `.bib` 的 citation key 直接寫進稿件
- 不要因為草稿提到某篇文獻，就假設該文獻真的支撐段落中的所有 claim
- 不要為了文字順暢而擅自新增未經證成的 theorem-level 結論
- 不要未經確認就重排整個 chapter structure
- 不要把「這裡之後再補」、「這段先放草稿」、「這些條件正文再交代」之類的自我揭露留在正式論文內容中
