---
name: rpe-workflow
description: RECON → PLAN → EXECUTE workflow with codemode, store/load, and plan.md approval. Use for any multi-step coding task to keep context clean.
---

# RPE Workflow — RECON → PLAN → EXECUTE

> 0 lines of new tool. Codemode = execution, brain = planning, store() = bridge, plan.md = receipt.

This skill makes the workflow global — no need for project testmode folder.

## 1. RECON (codemode, ONE script)
Batch ALL exploration, summarize inside VM, never dump raw files.

```js
// See templates/recon.codemode.js
// @options: {"max_output_tokens": 8000}
const res = await Promise.allSettled([
  tools.ls({path: "."}),
  tools.find({path: ".", pattern: "**/*"}),
  tools.read({path: "package.json"}).then(s=>s.slice(0,1000)),
  tools.grep({pattern: "TODO", path: "."}),
  tools.bash({command: "git status --porcelain 2>&1 | head -n 50"})
]);
const summary = res.map((r,i)=> `[${i}] ${r.status==='fulfilled'? String(r.value).slice(0,800): r.reason}`).join("\n");
store("recon", summary);
text(summary); // <500 lines
```
Template: `templates/recon.codemode.js`
Reference: `references/WORKFLOW.md`

## 2. PLAN (main context, no tool)
Output:
- Assumptions: [...]
- Ambiguity: [...] -> ask_user_question if needed
- Plan: 1. Step -> verify: [bash/grep]

If >2 steps, persist for approval:
```js
await tools.write({path: "plan.md", content: plan}); // or use assets/plan-template.md
store("plan", plan);
```
Template: `assets/plan-template.md`

## 3. EXECUTE (codemode, ONE script)
```js
// See templates/execute.codemode.js
const plan = load("plan");
await tools.edit({path: "src/a.ts", edits: [{oldText: "old", newText: "new"}]});
const test = await tools.bash({command: "npm test 2>&1 | tail -n 50"});
const diff = await tools.bash({command: "git diff --stat 2>&1 | head -n 50"});
text(`tests: ${test.output.slice(0,600)}\ndiff: ${diff.output}`);
```
Verify inside same script.

## Files
- references/WORKFLOW.md — full guide
- references/README.md — overview
- assets/plan-template.md — plan.md starter
- templates/recon.codemode.js — RECON copy-paste
- templates/execute.codemode.js — EXECUTE copy-paste
- Global enforcement: <agent-dir>/APPEND_SYSTEM.md (codemode.mode=only)
