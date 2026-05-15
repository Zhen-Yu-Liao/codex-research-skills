# Release Checklist

公開前或每次更新 release 前先完成這份 checklist，避免把個人專案脈絡帶到公開 repo。

## Sanitization

- [ ] 沒有 thesis 原稿、`.tex` 正式內容、`.bib` 私人文獻庫或研究資料。
- [ ] 沒有個人本機路徑、學校資料夾、專案代號或特定論文名稱。
- [ ] 沒有 API key、GitHub token、email、帳號或 credential。
- [ ] `subagent-prompt-*` 沒有硬性指定輸出語言。
- [ ] thesis skills 不強制套用 statistics convention；statistics reference 是 optional。
- [ ] `agents/openai.yaml` 沒有 `?` 亂碼。

## Validation

```powershell
.\scripts\validate-all.ps1
.\scripts\check-public-safety.ps1
python .\scripts\validate_skill_tree.py
```

## GitHub Review

- [ ] repo 已 push 到 GitHub，且 `origin/main` 與本地 `HEAD` 一致。
- [ ] GitHub Actions `Validate skills` 通過。
- [ ] README 的三組 install commands 都指向存在的 `skills/...` path。
- [ ] README 的 public install commands 使用實際 repo owner/name，不含 `<owner>` placeholder。
- [ ] 每個 README install command 都用暫存 `--dest` 實測成功，包含 `thesis-shared-references`。

## Public Switch

若 repo 仍在 private staging，review 通過後再切 public：

```powershell
gh repo edit codex-research-skills --visibility public
```

切 public 後重新測一次 install command，確認一般 public download path 可用。
