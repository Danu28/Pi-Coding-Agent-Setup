// EXECUTE template — copy into codemode tool
// Assumes load("plan") and load("recon") available
const plan = load("plan") || "(no plan)";
const recon = load("recon") || "(no recon)";
// 1. edits/writes
// await tools.edit({path: "src/a.ts", edits: [{oldText: "old", newText: "new"}]});
// await tools.write({path: "src/b.ts", content: "..."});
// 2. verify inside same script
const test = await tools.bash({command: "npm test 2>&1 | tail -n 80"}).catch(e=>({output: e.message, exit_code: 1}));
const diff = await tools.bash({command: "git diff --stat 2>&1 | head -n 50"});
text(`plan:\n${plan.slice(0,500)}\n---\ntests (exit ${test.exit_code}):\n${test.output.slice(0,1000)}\n---\ndiff:\n${diff.output.slice(0,500)}`);
