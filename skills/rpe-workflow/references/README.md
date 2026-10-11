# testmode — RECON → PLAN → EXECUTE Convention

> 0 lines of new tool. Discipline + store().

Codemode does execution, brain does planning, store() is the bridge, plan.md is the receipt.

## Workflow

```
RECON (codemode) --store("recon")--> PLAN (main context) --store("plan")--> EXECUTE (codemode + verify)
```

### 1. RECON — codemode only
One script, parallel, summarize inside VM. Never dump raw files to context.

```js
// codemode RECON
const [pkg, files] = await Promise.allSettled([
  tools.read({path: "package.json"}).then(s=>s.slice(0,800)),
  tools.find({pattern: "src/**/*"})
]);
const summary = `pkg: ${pkg.value}\nfiles: ${files.value}`;
store("recon", summary);
text(summary); // <500 lines to model
```

### 2. PLAN — main context (no tool)
Model reasons with recon + history. MUST output:

- Assumptions: [...]
- Ambiguity: [...] -> ask_user_question if needed
- Plan: 1. [...] -> verify: [...]

If task >2 steps, write to `plan.md` for user approval:

```js
await tools.write({path: "plan.md", content: planText});
store("plan", planText);
```

See `plan.md` template.

### 3. EXECUTE — codemode only
One script for all edits + verification:

```js
const plan = load("plan");
await tools.edit({path: "src/a.ts", edits: [...]});
const test = await tools.bash({command: "npm test 2>&1 | tail -n 50"});
const diff = await tools.bash({command: "git diff --stat"});
text(`tests: ${test.output}\ndiff: ${diff.output}`);
```

## Why not planmode/testmode tools?
- PLAN needs max context, not isolation
- Fresh context hurts planning (re-hydrate cost)
- Deterministic tests already unbiased (`npm test`)
- Skill/prompt solves discipline, not runtime. See `WORKFLOW.md`.
