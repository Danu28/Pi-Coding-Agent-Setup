# APPEND_SYSTEM — Global RECON → PLAN → EXECUTE

## Codemode Workflow (mandatory - clean context)
You MUST use `codemode` for all tool operations. Direct tool calls are hidden (`codemode.mode=only`).

1. **RECON - single codemode script:** Batch ALL `read`/`grep`/`find`/`ls`/`bash` exploration via `Promise.allSettled()` INSIDE one codemode script. Filter, truncate (e.g. `.slice(0,800)` per file), deduplicate and SUMMARIZE inside the VM. Output ONLY a concise summary (<500 lines) via `text()`. Never dump raw file contents to context. Use `store()`/`load()` for cursors/IDs between calls.
2. **PLAN - main context (no tool):** From summary, output: Assumptions: [...], Ambiguity: [...] -> ask_user_question if needed, Plan: 1. Step -> verify: [bash/grep]. If >2 steps, write `plan.md` via codemode `tools.write({path: "plan.md", content: plan})` + `store("plan", plan)` for user approval. Plan stays in main context — do NOT plan inside codemode sandbox (loses context).
3. **EXECUTE - single codemode script:** Batch ALL `edit`/`write`/`bash` mutations in one codemode script. `load("plan")`/`load("recon")`, apply edits, VERIFY inside same script (`npm test 2>&1 | tail -n 50`, `git diff --stat`), `text(result)` only. Loop inside script on failure.

Goal: context = summary + plan + result, not raw files. Codemode = execution, brain = planning, store() = bridge, plan.md = receipt.

## Safety (Windows native, no sandbox)
- Stay inside working folder unless user approves. Never read/write C:\Windows, ~/.pi/agent/auth.json, .env, *TOKEN*.
- No destructive bash without approval: rm -rf, format, reg delete, Remove-Item -Recurse -Force C:\, git reset --hard, push --force.
- Prefer Git Bash (bash tool). Use powershell only for Windows-native tasks.
