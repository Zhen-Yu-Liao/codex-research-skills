---
name: subagent-prompt-planning
description: 為 Codex 產生 subagent 規劃 prompt。用於需要先掃描 repo 與可用 skills，再依使用者語言輸出一份只做架構規劃、ownership 切分、風險盤點、驗收映射與 decision-complete plan 的 prompt；不適用於直接實作。
---

# 規劃型 Subagent Prompt

先盤點專案，再輸出一份只做規劃的 prompt。這個 skill 的產物是 decision-complete plan prompt，不是實作 prompt。

## 典型使用者說法

- 「先幫我寫一份用 subagents 做規劃拆工的 prompt。」
- 「先看 repo 跟 spec，幫我產一份 architecture planning prompt。」
- 「我想先把 ownership、風險、驗收映射想清楚，不要直接開發。」

## 工作流程

1. 先掃描 repo 與規格。
   - 讀 `Spec.md`、`AGENTS.md`、需求文件、manifest、entrypoints、既有模組、tests、build scripts。
   - 找出目前架構、依賴、主要模組與空缺區。
   - 只把已確認存在的模組、檔案與工具寫進規劃 prompt；不要用常見模板腦補。
2. 再選規劃階段真正需要的 skills。
   - 優先考慮 `planner`、`architect`、`package-manager-detector`、`ai-engineer`、`clean-architecture-guide`、`openapi-spec-writer`。
   - 只有在 repo 真有對應需求時才加入。
3. 再補齊高影響未知。
   - 只有當範圍、成功標準或限制無法從 repo 推得時才發問。
4. 再輸出 prompt。
   - 開頭插入 skill links。
   - 明確禁止直接實作、編輯檔案、寫功能碼、做破壞性 mutation。
   - 要求先探索，再產出可交付給實作者的完整計畫。

## Prompt 必備內容

- 明確宣告本次任務只做規劃，不做實作。
- 明確要求先閱讀 repo 與規格，再做 ownership 切分與風險盤點。
- 明確要求若使用 subagents，只能拿來做 exploration、方案比較與模組盤點。
- 明確要求每輪探索後 `wait for all`，由主 agent 整合出單一方案。
- 明確要求最終輸出包含：
  - 目標摘要
  - 模組邊界與資料流
  - public APIs / interfaces / types 的新增或修改
  - ownership map
  - 測試策略與驗收映射
  - 風險、假設、未決事項
- 明確要求如果執行環境支援 Plan Mode，使用 `<proposed_plan>`；否則輸出等價的結構化 Markdown 計畫。

## 技能挑選規則

- 規劃 prompt 只挑規劃期會真正影響決策的 skills。
- 不要把 `build-error-resolver`、`e2e-tester` 這類實作或驗證型 skill 當預設塞進 prompt，除非目前規劃明確卡在這些事實上。
- 不要讓 prompt 重複 `Spec.md` 的需求條列；引用即可。

## 輸出品質標準

- 使用使用者要求的語言輸出一份可直接貼上的 planning prompt；若使用者沒有指定語言，跟隨目前對話語言。
- 讓 prompt 足夠具體到實作者不必再做高層決策。
- 讓 prompt 依目前 repo 事實改寫，不要套 generic architecture 模板。
- 只引用已確認存在的路徑、模組、測試與腳本；缺席的東西要明說缺席，而不是假設它已存在。

## 不要做的事

- 不要把規劃 prompt 寫成實作 prompt。
- 不要要求主 agent 在同一回合直接完成功能。
- 不要輸出空泛的「先分析、再實作」；要明講計畫交付內容。
