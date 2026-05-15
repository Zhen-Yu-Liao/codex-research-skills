# Statistics Thesis Conventions

## 目的

提供統計學、方法論或高度數理 empirical thesis 常見的章節功能、論證順序與風險控管。這份文件是 optional domain reference，不是所有 thesis task 的預設規範；若專案層規範不同，以專案層為準。

## 章節角色

- Introduction：交代問題、研究缺口、方法定位、貢獻與章節安排。
- Background 或 Literature Review：整理理論母體、比較相關方法、界定本研究承接的位置。
- Methodology：定義模型、符號、演算法、假設、理論命題與複雜度。
- Simulation Study：交代 data-generating process、baseline、metrics、tuning、資源環境與結果。
- Real Data Application：交代資料來源、前處理、任務設定、實證觀察與限制。
- Conclusion：總結貢獻、限制與未來工作，不新增核心結果。

## Methodology 規則

- 先定義符號，再使用符號。
- 先交代統計目標，再介紹計算重構；不要只講 implementation 而遺失要估計的對象。
- 若聲稱 consistency、rate、variance bound、oracle property 等理論結果，必須同時交代 assumptions 與保證邊界。
- 區分「矩陣近似誤差」「每點預測誤差」「函數估計誤差」「推論有效性」，不要混寫成同一層保證。
- 寫收斂階數或上界時，要說清楚這個式子是在講哪個對象：exact 方法還是近似方法、centered 還是未中心化 smoother、單一 smoother 還是整個 backfitting 收斂後的線性轉換、整個矩陣還是某一列/某一個樣本點。
- 若某個階數依賴相同 bandwidth 階數、interior region、no-concurvity 或 contraction 條件、每一列不被放大的假設，或其他分量造成的 bias 項不支配，需在附近交代；若前文已交代，可直接引用前文或文獻，不必重複完整假設。
- 對 bias 結果要分清楚常數/一次函數可被重現或 moment 條件能推出的保守階數，以及 exact smoother 因高階 cancellation 得到的更高階 bias；不要把兩者寫成同一種保證。
- 涉及 backfitting 收斂後的估計量時，不要把單一 smoother 的 operator norm、shrinking property 或單一列大小自動升格為套用完整 backfitting 解之後的逐列控制；需要額外假設或明確推導。

## Literature Review 規則

- 不是把 paper 摘要串起來，而是比較研究目標、假設、估計對象、計算規模與保證類型。
- 說明研究缺口時，指出缺在哪一層：統計目標、計算可行性、理論保證、實證覆蓋範圍。
- 貢獻敘述要與 literature gap 一一對應。

## Empirical Chapter 規則

- 明確寫出資料生成機制或資料來源。
- 明確列出 baseline、evaluation metric、tuning 方式與 stopping criterion。
- 明確交代硬體、軟體環境與資源限制，尤其當論文主張 scalable 或 computationally feasible 時。
- 不只報最漂亮的結果，也要報失敗情境、近似代價或方法邊界。

## 貢獻分層

將 contribution 至少拆成下列層次，避免混淆：

- 方法層：估計器、演算法或建模結構的新意。
- 理論層：命題、上界、收斂階數、可證性條件。
- 計算層：複雜度、記憶體路徑、近似與硬體友善設計。
- 實證層：simulation 與 real data 的證據。

## 常見風險

- 把整個矩陣的上界直接寫成對最終估計量的保證。
- 把 engineering feasibility 說成 statistical superiority。
- Introduction 與 Background 重複說同一批文獻，卻沒有更細的定位差異。
- 結論章重新引入未在正文證成的 claim。
