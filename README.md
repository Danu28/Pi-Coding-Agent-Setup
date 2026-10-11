# Pi-Coding-Agent-Setup

> Shareable Windows-safe Pi coding agent setup — clone and run to reproduce the same global config.

Exported from `%USERPROFILE%\.pi\agent` so anyone can get the same Pi experience.

## What's Inside

| File | Purpose |
|------|---------|
| `AGENTS.md` | Safety rules + Windows notes + behavioral guidelines |
| `APPEND_SYSTEM.md` | Global RECON -> PLAN -> EXECUTE codemode workflow (`codemode.mode=only`) |
| `settings.json` | Global Pi settings template |
| `.pi/settings.json` | Project-level additive settings |
| `extensions/agent-status.ts` | Custom extension |
| `skills/analyze-sessions` | Skill: analyze past sessions |
| `skills/rpe-workflow` | Skill: RPE workflow |
| `trust.json.example` | Trusted folders template |
| `scripts/install.ps1` | Windows installer |
| `scripts/install.sh` | macOS/Linux installer |

## Quick Start (Windows - PowerShell)

```powershell
git clone https://github.com/YOU/Pi-Coding-Agent-Setup.git
cd Pi-Coding-Agent-Setup
powershell -ExecutionPolicy Bypass -File scripts/install.ps1
```

Manual:

```powershell
Copy-Item AGENTS.md $env:USERPROFILE/.pi/agent/AGENTS.md -Force
Copy-Item APPEND_SYSTEM.md $env:USERPROFILE/.pi/agent/APPEND_SYSTEM.md -Force
Copy-Item settings.json $env:USERPROFILE/.pi/agent/settings.json -Force
Copy-Item trust.json.example $env:USERPROFILE/.pi/agent/trust.json -Force  # edit paths!
Copy-Item -Recurse skills/* $env:USERPROFILE/.pi/agent/skills/ -Force
Copy-Item -Recurse extensions/* $env:USERPROFILE/.pi/agent/extensions/ -Force
pi --version
```

## macOS / Linux

```bash
git clone https://github.com/YOU/Pi-Coding-Agent-Setup.git
cd Pi-Coding-Agent-Setup
chmod +x scripts/install.sh
./scripts/install.sh
```

## Structure

```
Pi-Coding-Agent-Setup/
├── AGENTS.md
├── APPEND_SYSTEM.md
├── settings.json
├── .pi/settings.json
├── trust.json.example
├── extensions/
├── skills/
├── scripts/
│   ├── install.ps1
│   └── install.sh
└── README.md
```

## Safety Notes

- Never commit `auth.json`, `.env`, tokens/keys (see `.gitignore`)
- Stay inside working folder unless user approves
- No destructive commands without approval
- Prefer Git Bash on Windows

## Customize

1. Edit `settings.json` (defaultProvider/defaultModel/packages)
2. Edit `trust.json.example` -> `trust.json`
3. Add `skills/`/`extensions/`, re-run installer

## License

MIT

## Exported Global Settings (this machine)
```json
{
  "lastChangelogVersion": "1.1.0",
  "defaultProvider": "opencode-go",
  "defaultModel": "muse-spark-1.2-contributor",
  "defaultTools": [
    "+powershell",
    "+codemode",
    "+grep",
    "+find",
    "+ls"
  ],
  "codemode.mode": "only",
  "codemode.inlineBudget": 3000,
  "packages": [
    "npm:pi-web-access",
    "git:github.com/Danu28/pi-ask-user-question",
    "git:github.com/Danu28/pi-headed-browser"
  ],
  "hideThinkingBlock": true
}```
