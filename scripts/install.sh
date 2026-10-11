#!/usr/bin/env bash
set -e
REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
TARGET="$HOME/.pi/agent"
echo "Installing Pi setup to $TARGET ..."
mkdir -p "$TARGET/skills" "$TARGET/extensions" "$TARGET/prompts"
cp -f "$REPO_ROOT/AGENTS.md" "$TARGET/AGENTS.md" 2>/dev/null || echo "no AGENTS.md"
cp -f "$REPO_ROOT/APPEND_SYSTEM.md" "$TARGET/APPEND_SYSTEM.md" 2>/dev/null || echo "no APPEND"
cp -f "$REPO_ROOT/settings.json" "$TARGET/settings.json"
if [ -f "$REPO_ROOT/trust.json.example" ]; then
  if [ ! -f "$TARGET/trust.json" ]; then cp -f "$REPO_ROOT/trust.json.example" "$TARGET/trust.json"; echo "Created trust.json"; else echo "trust.json exists - skipping"; fi
fi
[ -d "$REPO_ROOT/extensions" ] && cp -Rf "$REPO_ROOT/extensions/." "$TARGET/extensions/." 2>/dev/null || true
[ -d "$REPO_ROOT/skills" ] && cp -Rf "$REPO_ROOT/skills/." "$TARGET/skills/." 2>/dev/null || true
echo "Done! Restart pi and run: pi --version"
