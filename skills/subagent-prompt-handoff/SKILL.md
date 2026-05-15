---
name: subagent-prompt-handoff
description: 為 Codex 產生交付前 subagent 審查與驗證 prompt。用於功能已大致完成，需要先掃 repo、tests、docs、env 與 release 路徑，再依使用者語言輸出一份聚焦 correctness、安全、行為回歸、README / `.env.example` 同步與 e2e 驗證的 prompt。
---

# 交付審查 Subagent Prompt

先盤點交付狀態，再輸出一份 release-readiness prompt。核心是 correctness、安全、回歸驗證、文件同步與 blocker 清單，不是再開新功能。

## 典型使用者說法

- 「功能差不多了，幫我寫一份交付前 subagent review prompt。」
- 「先看 repo 跟測試，再幫我產一份 release readiness prompt。」
- 「我要在交付前做最後驗證、README 補齊與 e2e，幫我寫 prompt。」

## 工作流程

1. 先盤點交付面向。
   - 讀 `Spec.md`、`AGENTS.md`、README、`.env.example`、tests、build scripts、entrypoints、release 相關設定。
   - 確認哪些功能已完成、哪些驗收點還缺證據。
   - 只把已確認存在的交付檔案、命令、測試與 release 路徑寫進 prompt；不要憑慣例補齊。
2. 再挑最小必要 skills。
   - 優先考慮 `code-reviewer`、`e2e-tester`、`doc-maintainer`。
   - 若涉及安全或暴露面，再考慮 `security-specialist`。
   - 若涉及可用性或 Web 品質，再視情況加入 `a11y-auditor`、`performance-profiler`。
3. 再撰寫 prompt。
   - 要求主 agent 把 subagents 切成 review、verification、docs sync 等 bounded jobs。
   - 要求主 agent 只修 blocking 問題與缺失文件，不重新擴張 scope。
4. 只輸出 prompt。

## Prompt 必備內容

- 明確要求先建立交付證據清單，再決定檢查順序。
- 明確要求 review 聚焦 correctness、安全、behavior regression、missing tests。
- 明確要求驗證 build、關鍵 tests 與至少一條 e2e 主流程。
- 明確要求 README、`.env.example`、demo 步驟與實際系統狀態保持一致。
- 明確要求若使用 subagents，每個 subagent 回傳：
  - `ownership`
  - `changed files`
  - `commands run`
  - `tests run`
  - `open risks / blockers`
- 明確要求主 agent 在每輪 review / verification 後 `wait for all` 並整合。
- 明確要求最終回報：
  - 完成的驗收項
  - 實際跑過的命令與結果
  - 阻斷交付的 blocker
  - 可接受但尚未消除的風險

## 技能挑選規則

- 若主要問題仍是功能未完成，改用 `subagent-prompt-longrun`。
- 若主要問題是單一錯誤修復，改用 `subagent-prompt-debug`。
- 只在 repo 真有相應風險時才加入 `security-specialist`、`a11y-auditor` 或 `performance-profiler`。

## 輸出品質標準

- 使用使用者要求的語言輸出一份可直接貼上的 handoff prompt；若使用者沒有指定語言，跟隨目前對話語言。
- 讓 prompt 能直接驅動最後一輪審查與驗證，不再需要額外整理。
- 讓 prompt 明確限制 scope，避免交付前又引入新功能或大重構。
- 只引用已確認存在的交付材料與驗證工具；若缺某項，讓 prompt 先標記缺口而不是假設它已存在。

## 不要做的事

- 不要把 handoff prompt 變成新功能開發 prompt。
- 不要只要求「幫我 review」而不指定 review focus 與驗證命令。
- 不要略過 README / `.env.example` / demo 步驟的同步。
