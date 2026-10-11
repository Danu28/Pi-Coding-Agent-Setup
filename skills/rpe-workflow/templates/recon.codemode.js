// RECON template — copy into codemode tool
// @options: {"max_output_tokens": 8000}
const results = await Promise.allSettled([
  tools.ls({path: "."}),
  tools.find({path: ".", pattern: "**/*"}),
  tools.read({path: "package.json"}).then(s=>s.slice(0,1000)).catch(e=>"no pkg: "+e.message),
  tools.bash({command: "git status --porcelain 2>&1 | head -n 50"}),
]);
let summary = results.map((r,i)=> `[${i}] ${r.status}: ${r.status==='fulfilled'? String(r.value).slice(0,800): r.reason.message?.slice(0,400)}`).join("\n---\n");
store("recon", summary);
text(summary);
