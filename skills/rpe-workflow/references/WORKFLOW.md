# WORKFLOW — 0 Lines of New Tool

## Principle
`codemode` = execution isolation (QuickJS sandbox)
`brain` = planning (needs max context)
`store()/load()` = bridge without context bloat
`plan.md` = receipt + approval gate

## Detailed Steps

### RECON (codemode)
Batch all reads in ONE script. Filter/truncate inside VM.

```js
const res = await Promise.allSettled([
  tools.ls({path: "."}),
  tools.read({path: "package.json"}).then(s=>s.slice(0,1000)),
  tools.grep({pattern: "TODO", path: "."}),
  tools.bash({command: "git status --porcelain"})
]);
const summary = res.map((r,i)=> `[${i}]: ${r.status==='fulfilled'? String(r.value).slice(0,800): r.reason}`).join("\n");
store("recon", summary);
text(summary);
```

Output: <500 lines. Never return raw 50KB files.

### PLAN (main context, no tool)
Use `load("recon")` mentally (already in context). Output:

1. Assumptions — state explicitly
2. Ambiguity — if any, call ask_user_question (native, not via codemode)
3. Plan — numbered steps each with `-> verify: <bash/grep>`

Keep plan to 3-7 steps. Each step maps to one EXECUTE verification.

Optional: write plan.md via codemode for persistence:
```js
await tools.write({path: "plan.md", content: plan});
store("plan", plan);
```

### EXECUTE (codemode)
One script: all edits/writes + bash verifies.

```js
const plan = load("plan");
await tools.edit({path: "README.md", edits: [{oldText: "old", newText: "new"}]});
await tools.write({path: "src/x.ts", content: "..."});
const v1 = await tools.bash({command: "npm test 2>&1 | tail -n 50"});
const v2 = await tools.bash({command: "git diff --stat"});
if(v1.exit_code!==0) throw new Error("tests failed: "+v1.output);
text("OK: "+v1.output.slice(0,500)+"\n"+v2.output);
```

Verify inside same script — no second round-trip.

## When to deviate
- One-off debug read: allowed via codemode read, still summarize
- Need fresh LLM review: use codemode bash tests (deterministic) ; only spawn fresh LLM for LLM-as-judge tasks
- No new tool needed: if you want `planmode`/`testmode`, use this convention first 10x; promote only if repeated pain.

## Codemode options
```js
// @options: {"max_output_tokens": 10000, "timeout_ms": 60000}
```
Use timeout for image gen; default no timeout.

## Anti-patterns
- Dumping raw file contents to context
- Planning inside codemode sandbox (loses context)
- Building new mode for prompt problem
