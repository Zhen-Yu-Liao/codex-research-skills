---
name: thesis-citation-logic-auditor
description: 審查論文章節中的 claim、證據與 citation 是否對齊，找出過度延伸、引用錯配、保證層級混淆與 contribution 未落地等問題。當使用者要求 review thesis 章節、檢查文獻是否真的支撐某段話、確認研究缺口與貢獻是否站得住，或在送出正式稿前做 citation/logic audit 時使用。
---

# Thesis Citation Logic Auditor

用 reviewer mindset 檢查論文是否「說得比證據更多」。這個 skill 的重點不是潤稿，而是抓出 claim、citation、theory level、empirical evidence 之間的錯配。

## 讀取順序

1. 若存在，讀 `../thesis-shared-references/thesis_base_conventions.md`；若缺少，使用本 skill 的通用 citation/logic audit 規則並在回覆中標記 shared references 未安裝
2. 若使用者的論文明確屬於 statistics、methodology 或 math-heavy empirical thesis，讀 `../thesis-shared-references/statistics_thesis_conventions.md`
3. 讀 `references/audit_checklist.md`
4. 若 workspace 存在 `.agent/references/thesis_project_conventions.md`，讀它並覆寫前述慣例
5. 讀目標章節、相關 bibliography entries、必要時讀相鄰章節

## 審查目標

- 檢查每個核心 claim 是否有相稱的 support
- 檢查 citation 是否真的支撐該句，而不是只沾到同一主題
- 檢查 guarantee level 是否被寫錯
- 檢查 research gap、contribution、method claim 是否彼此對齊
- 把 citation accuracy 視為不可妥協條件；無法確認精確支撐時，寧可縮限句子也不要保留模糊強說法

## 標準流程

### 1. 抽出 claim map

將目標段落拆成以下類型的 claim：

- background
- literature positioning
- method
- theory
- empirical
- contribution

若一個句子同時包含多類 claim，拆開審查，不要整句籠統判斷。

### 2. 對照 support

對每個 claim，列出：

- 目前引用的 citation key
- 若無 citation，是否能由本論文前文、定理、實驗或明確定義支撐
- 目前 support 是否只支撐背景，卻被拿來支撐更強的結論
- 若屬核心理論、保證層級或高風險敘述，優先核對 primary source，而不是只依二手摘要或主題相近文獻判斷

### 3. 檢查保證層級

在 methodology、theory 或 empirical thesis 中，特別檢查以下混淆；若論文屬於特定領域，改用該領域的保證層級與證據標準：

- matrix approximation bound 被寫成 estimator guarantee
- algorithm convergence 被寫成 statistical optimality
- empirical scalability 被寫成 theoretical complexity guarantee
- heuristic intuition 被寫成 proved statement

### 4. 產出 findings

以 findings-first 方式輸出。每個 finding 至少包含：

- 問題位置
- 問題句或 claim 摘要
- 問題類型
- 為何不成立或風險在哪裡
- 建議修法

## 輸出格式

優先輸出嚴重度排序的 findings：

- `critical`: citation 或 claim 明顯錯誤，會誤導讀者
- `high`: claim 超出證據、保證層級混淆、contribution 對不上正文
- `medium`: citation 可用但不夠精準，或 positioning 邏輯仍鬆散

若沒有明顯問題，也要說明 residual risk，例如：

- 還沒核對原文文獻全文
- 目前只依 bibliography metadata 與章節上下文判斷
- empirical claim 尚未對照最終結果表
- 若 citation 邊界仍有疑義，應明確指出哪一句應縮限、刪除或改寫，而不是僅說「建議再查」

## 何時改用其他 skill

- 若需要重構章節論證順序，改用 `thesis-argument-planner`
- 若需要把修正後內容寫回正式 `.tex`，改用 `thesis-draft-to-latex`
- 若需要編譯驗證 citation/ref 是否在 LaTeX 中解析，改用 `thesis-build-guard`

## 禁止事項

- 不要因為 citation key 看起來像對的，就假設 claim 被支撐
- 不要在沒核實的情況下建議新增不存在的 key
- 不要把語氣問題當成唯一問題，忽略實質邏輯錯誤
- 不要因為文獻主題相近，就默許其支撐超出原文範圍的 claim
