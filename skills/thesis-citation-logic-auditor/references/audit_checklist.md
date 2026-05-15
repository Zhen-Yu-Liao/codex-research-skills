# Thesis Citation Audit Checklist

## Claim 類型與最低證據要求

### Background claim

- 例：某方法在某領域是經典做法、某模型常用於某類問題。
- 最低要求：至少有代表性 foundational citation 或教材級來源。

### Literature positioning claim

- 例：文獻可分成三條主線、現有工作多半聚焦某層而忽略另一層。
- 最低要求：每條主線至少有代表性來源，且分類標準一致。

### Method claim

- 例：本研究 preserves the original estimation target、computational path is reformulated。
- 最低要求：正文有清楚定義 estimator/objective/operator，不能只有口號。

### Theory claim

- 例：consistency、rate、variance bound、oracle efficiency、convergence order。
- 最低要求：明確 assumptions、定理或推導位置、保證層級。

### Empirical claim

- 例：方法在 simulation 或 real data 表現較好、可擴展到 million-scale。
- 最低要求：結果表、figure、metric、baseline、資源條件。

### Contribution claim

- 例：本研究有方法層、理論層、計算層、實證層貢獻。
- 最低要求：各層在正文中都有對應內容，不能只在 introduction 宣稱。

## 常見失配模式

- citation 只支撐一般背景，卻被拿來支撐非常具體的方法 claim。
- matrix approximation 文獻被拿來直接支撐 estimator-level error claim。
- survey 或 secondary source 被寫成原始理論來源。
- 單一 citation 被拿來支撐一長串不同層級的 claim。
- 本文貢獻被寫成現有文獻已完成的內容。

## 審查輸出建議

對每個問題至少標記：

- `claim`
- `current_support`
- `problem_type`
- `risk`
- `recommended_fix`

## 建議的 problem_type

- unsupported
- overstated
- mismatched-citation
- missing-assumption
- wrong-guarantee-level
- duplicated-positioning
- contribution-gap
