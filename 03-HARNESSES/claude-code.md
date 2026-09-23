---
name: Claude Code Harness Wiring
slug: harness-claude-code
version: 0.1.0
kind: harness-config
harness: claude-code
provider: any
modality: text
sovereign: true
tags: [harness, claude-code, wiring, settings, hooks, CLAUDE.md]
requires: [sysprompt-claude-code, frontmatter-spec]
---

# Claude Code — Wiring

Three surfaces: instruction files (`CLAUDE.md`), settings (`settings.json`), and hooks that
enforce rules mechanically. The instruction file states posture; the hook is what makes it
non-optional.

## Instruction file layering

```
~/.claude/CLAUDE.md            # user-global: posture + voice only
<repo>/CLAUDE.md               # project law: the block from 01-SYSTEM-PROMPTS/claude-code.md
<repo>/sub/CLAUDE.md           # subtree delta: conventions, generators, frozen paths
```

Rules:

- Keep the root file under one screen. It is injected as context every turn; length dilutes
  the rules that matter.
- Nested files carry deltas only. Repeating the root block costs tokens and creates two
  copies that drift.
- Never put a credential in any of these files. They are context, and context is logged.

## settings.json

Project-scoped at `<repo>/.claude/settings.json`; user-scoped at `~/.claude/settings.json`.

```json
{
  "permissions": {
    "allow": [
      "Bash(git status)",
      "Bash(git diff:*)",
      "Bash(rg:*)",
      "Bash(wc:*)",
      "Read(//home/dirt/**)",
      "Edit(//home/dirt/UNMUZZLED-AI/**)"
    ],
    "deny": [
      "Read(./.env)",
      "Read(./secrets/**)",
      "Bash(rm -rf /*)"
    ],
    "defaultMode": "acceptEdits"
  },
  "env": {
    "CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC": "0"
  }
}
```

Notes on the shape: `allow` entries are prefix rules and the `:*` form is what makes a
whole command family auto-approved. `deny` beats `allow` on overlap. `defaultMode` of
`acceptEdits` is the setting that removes the edit confirmation prompt.

## Hooks — mechanical enforcement

Hooks live in the same `settings.json` under `hooks`, keyed by event. Each entry has a
`matcher` (tool name, regex) and a `hooks` array of commands run on the event.

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Edit|Write",
        "hooks": [
          {
            "type": "command",
            "command": "test ! -e 99-ARCHIVE-SEEDS || { echo 'frozen tree' >&2; exit 2; }"
          }
        ]
      }
    ],
    "PostToolUse": [
      {
        "matcher": "Edit|Write",
        "hooks": [
          { "type": "command", "command": "python3 -c \"import sys,subprocess;sys.exit(0)\"" }
        ]
      }
    ],
    "Stop": [
      { "hooks": [ { "type": "command", "command": "bash 11-DETECTION-CANARIES/soul-lint/lint-soul.sh ." } ] }
    ]
  }
}
```

- Exit code `2` from a `PreToolUse` hook blocks the tool call and returns stderr to the
  model. That is the enforcement channel: a rule with a hook behind it cannot be
  rationalized away.
- `PostToolUse` is where a lint or type check runs so a bad edit is caught in the same turn.
- `Stop` fires when the agent finishes; use it for the banned-phrase lint so a session
  cannot end on a softened file.

Place the `PreToolUse` frozen-tree guard at project scope in the framework repo, and a
relaxed version at user scope for ordinary repos.

## Verify

```bash
claude --version
claude -p "run: wc -l 00-DOCTRINE/LAWS.md"
```

If the second command runs without a prompt, the permission block parsed. If the
frozen-tree hook fires, `PreToolUse` is wired.

## Pitfalls

- A hook that never exits non-zero is a comment. Confirm the guard by deliberately
  triggering it once and reading the block message.
- Hook commands run non-interactively with the repo root as cwd. Use relative paths
  matching that assumption, or absolute paths.
- `TBD-verify`: exact permission-rule string syntax and hook event names for the version on
  this box. Confirm with `claude --help` and the local settings reference before
  distributing a settings file to another node.
