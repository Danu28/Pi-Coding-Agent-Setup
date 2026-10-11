# Plan — RECON → PLAN → EXECUTE

> Fill this in main context after RECON. Keep <50 lines. User approves before EXECUTE.

## Assumptions
- [ ] e.g. Node 20, no new deps, Windows Git Bash
- [ ] e.g. src/ exists, tests run via `npm test`

## Ambiguity (ask_user_question if any)
- [ ] e.g. auth needed? -> ask: "Should X require auth?"

## Plan
| # | Step | Verify |
|---|------|--------|
| 1 | e.g. Add validation to `src/a.ts` | `grep TODO` empty, failing test passes |
| 2 | e.g. Update `README.md` | `read README.md` contains new section |
| 3 | e.g. Remove orphans | `git diff --stat` shows only intended files |

## Recon Reference
<!-- paste store("recon") summary here or load("recon") -->
```
(paste RECON summary)
```

## Approval
- [ ] Approved -> EXECUTE via codemode
- [ ] Changes requested: ...

---
Template for 0-tool convention. See WORKFLOW.md for full guide.
