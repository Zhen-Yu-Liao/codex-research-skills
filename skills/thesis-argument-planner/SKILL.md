---
name: thesis-argument-planner
description: 用於 thesis 論證規劃。當使用者要求整理 chapter outline、段落功能、argument flow、研究缺口與 contribution framing，並希望先做 structure-only 規劃而不是直接寫 prose 時使用。
---

# Thesis Argument Planner

先規劃論證，再決定是否進入正式成稿。這個 skill 的任務是把章節問題拆成可驗證的 argument structure，而不是直接產出一大段好看但失焦的 prose。

## 讀取順序

1. 若存在，讀 `../thesis-shared-references/thesis_base_conventions.md`；若缺少，使用本 skill 的通用 thesis 規則並在回覆中標記 shared references 未安裝
2. 若使用者的論文明確屬於 statistics、methodology 或 math-heavy empirical thesis，讀 `../thesis-shared-references/statistics_thesis_conventions.md`
3. 若 workspace 存在 `.agent/references/thesis_project_conventions.md`，讀它並覆寫前述慣例
4. 讀目標章節、相鄰章節、entry file、style/preamble、相關草稿與 bibliography
5. 視需要再讀：
   - `references/chapter_role_patterns.md`
   - `references/argument_ladder_template.md`
   - `references/common_logic_gaps.md`

## 工作目標

- 定義目標章節在整篇論文中的功能
- 拆出 section 與 subsection 的最小必要結構
- 將每個段落綁定到 claim、evidence、citation、notation、risk
- 找出重複、跳步、過度承諾與未證成的地方
- 保留 intentional placeholder；不要把刻意留白的小節自動當成 defect

## 標準流程

### 1. 先判斷章節角色

- 先回答這一章是 introduction、background、methodology、simulation、real data 還是 conclusion
- 若檔名與章節功能不一致，以 entry file 與實際內容為準，不要只看檔名
- 若使用者只要 chapter-level review，預設停在 structure-only 與 signposting，不直接改 prose

### 2. 建立 argument ladder

對每個 section 至少列出以下內容；必要時直接套用 `references/argument_ladder_template.md`：

- `section_goal`：本節要回答什麼問題
- `must_keep`：本節不可缺的理論、方法或實證元素
- `claim_order`：核心論點順序
- `required_evidence`：每個論點需要的 citation、公式、圖表或實驗
- `spillover_risk`：哪些內容應留給其他章節，不要提早寫進來

### 3. 檢查邏輯缺口

優先檢查 `references/common_logic_gaps.md` 中的缺口，特別是：

- 文獻脈絡是否真的導向研究缺口
- 研究缺口是否真的導向 contribution
- 方法 claim 是否超出目前可證或可驗證範圍
- empirical chapter 是否缺 baseline、metric、tuning 或資源設定
- 結論是否引入正文沒證成的新 claim
- 是否把不同層級的保證混成同一層 claim

### 4. 產出規劃稿

使用使用者要求的語言輸出；若使用者沒有指定語言，跟隨目前對話語言。規劃稿至少包含：

- 建議的章節標題與順序
- 每節 2 到 5 個段落功能說明
- 每節需要讀回哪些既有檔案
- 缺失清單
- 下一步應交給哪個 skill 或哪個正式檔案
- 若使用者已明示某些圖表、實證段落必須留在主文，不要建議搬 appendix；改做 reading guide、bridge text 或分組敘事

## 輸出格式

優先輸出以下格式之一：

- `章節骨架 + 段落功能表`
- `claim-evidence gap list`
- `草稿改寫前的邏輯修補清單`

若使用者要求落到專案檔案，優先更新 `thesis/chapters/drafts/*.md` 之類的 planning 檔，而不是直接大改正式 `.tex`。

## 何時切換到其他 skill

- 若任務變成把草稿寫成正式 LaTeX，改用 `thesis-draft-to-latex`
- 若任務變成檢查 citation 是否支撐 claim，交給 `thesis-citation-logic-auditor`
- 若任務變成編譯與 log 檢查，交給 `thesis-build-guard`

## 禁止事項

- 不要在未規劃章節角色時直接寫正式段落
- 不要把不同層級的保證、證據或主張混成同一種結論
- 不要為了讓 outline 完整而虛構 citation、實驗設計或定理條件
- 不要把論證規劃寫成花俏但空泛的段落模板
