---
name: subagent-prompt-debug
description: 為 Codex 產生 subagent 除錯 prompt。用於已有錯誤、失敗測試、build failure、回歸或不穩定流程時，先重建現況與 repo 脈絡，再依使用者語言輸出一份以 root cause、最小修復、回歸測試與實測證據為核心的 prompt。
---

# 除錯型 Subagent Prompt

先重現問題，再輸出一份用來除錯的 prompt。核心是 root cause、最小修復與回歸驗證，不是順手做大清理。

## 典型使用者說法

- 「幫我寫一份 subagent debug prompt，先找 root cause 再修。」
- 「這個 repo build 爆了，先看整個專案後幫我產一份除錯 prompt。」
- 「我要讓 Codex 用 subagents 修 bug，但不要亂 patch，請先幫我寫 prompt。」

## 工作流程

1. 先重建問題脈絡。
   - 讀錯誤訊息、失敗測試、stack trace、CI/log、相關 entrypoints、manifests 與可疑模組。
   - 確認問題是 build、runtime、integration、UI flow、e2e 還是回歸。
   - 只根據已確認存在的錯誤證據、命令與檔案路徑寫 prompt，不要腦補不存在的測試或框架。
2. 再挑最小必要 skills。
   - 優先考慮 `systematic-debugging`、`build-error-resolver`、`code-reviewer`。
   - 若問題在 UI flow，再考慮 `e2e-tester` 或 `playwright`。
   - 若 package manager 或 scripts 不明，再考慮 `package-manager-detector`。
3. 再撰寫 prompt。
   - 要求先重現，再提 root-cause hypothesis，再做最小修復。
   - 若使用 subagents，切成重現、可疑模組調查、驗證三類 bounded jobs。
4. 只輸出 prompt。

## Prompt 必備內容

- 明確要求先用實際指令重現問題，不准跳過重現直接 patch。
- 明確要求收集 raw artifacts：錯誤訊息、失敗測試、network/request log、browser trace、build output。
- 明確要求每個 subagent 回傳：
  - `ownership`
  - `changed files`
  - `commands run`
  - `tests run`
  - `open risks / blockers`
- 明確要求主 agent 在每輪調查或修復後 `wait for all`，再整合判斷。
- 明確要求修復策略偏向 minimal diff，不做順手重構或風格清潔。
- 明確要求修復後至少補一個會失敗再轉綠的回歸驗證。
- 明確要求最終回報實際執行命令、修復證據、剩餘風險與未覆蓋情況。

## 技能挑選規則

- 若只是單純編譯錯誤，優先 `build-error-resolver`，不要預設動用一堆廣域技能。
- 若是行為錯誤或難重現 bug，優先 `systematic-debugging`。
- 若是交付前驗證而不是 bug 修復，改用 `subagent-prompt-handoff`。

## 輸出品質標準

- 使用使用者要求的語言輸出一份可直接貼上的 debug prompt；若使用者沒有指定語言，跟隨目前對話語言。
- 讓 prompt 能迫使 agent 先建立事實，再修。
- 讓 prompt 明確區分「已證實 root cause」與「仍是 hypothesis」。
- 只引用已確認存在的失敗命令、檔案與工具；沒有證據就要求先調查，不要假設。

## 不要做的事

- 不要允許 prompt 鼓勵無根據亂 patch。
- 不要允許 prompt 把大量不相關的清理、升版或重構一起塞進修復。
- 不要忽略回歸測試與實測指令。
