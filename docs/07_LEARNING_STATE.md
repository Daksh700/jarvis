# JARVIS — Learning State
**Purpose:** the honest record of what Daksh actually knows right now. **Every chat in this project must read this before explaining anything.**

**Why this file exists:** the first version of the JARVIS plan assumed knowledge that wasn't there, and the whole plan had to be rewritten. This file makes that failure impossible to repeat.

---

## How to use

Update **every week**, at the end of the session. Be brutally honest — an inflated entry here produces explanations that go over your head, which is exactly the problem this solves.

**Levels:**
- 🔴 **Not started** — no exposure
- 🟠 **Copy-paste** — can make it work by following instructions, cannot explain why
- 🟡 **Shaky** — understand the idea, fumble the details, need to look things up constantly
- 🟢 **Solid** — can explain it to someone else and debug it without help
- 🔵 **Deep** — understand the layer below it too

**The honesty test for 🟢:** could you explain this to a junior dev without looking anything up? If no, it's 🟡.

---

## Instructions to any AI reading this file

1. **Never assume a skill above the level listed here**, even if the project stack implies it. Daksh uses Prisma daily and SQL is 🔴 — that combination is normal and expected.
2. When explaining, target one level above current: for 🟠, explain the mental model; for 🟡, explain the edge cases; for 🟢, skip to the point.
3. If a task needs a 🔴/🟠 skill, **say so before giving the solution.** "Ye karne se pehle ek cheez samajhni hogi..." is more useful than working code.
4. Never hand over code that requires an unlisted skill without flagging it.

---

## Current state — last updated: **Week 4 end (Oct 2026)**

### Foundations (Track 0)
| Skill | Level | Notes |
|---|---|---|
| Terminal / shell | 🟡 | Pipes, redirection (`1>`/`2>`/`2>&1`), exit codes, `chmod`, `PATH` clear. Still shaky on: `PATH` modification. |
| Bash scripting | 🟠 | Can read and write simple scripts. Knows `set -x`, `chmod +x`, `#!/bin/bash`. `status.sh` written and working. |
| Git — daily commands | 🟡 | add/commit/push/branch/merge comfortable. Relative refs (`HEAD^`, `HEAD~3`) clear. |
| Git — mental model | 🟡 | Commits as snapshots+pointers, branches as pointers clear. `reflog` vs `git log` understood. Rebase mental model solid. Still shaky: merge conflicts in complex scenarios. |
| HTTP / REST | 🟡 | Builds and calls APIs; status codes, headers, idempotency vague |
| Auth (JWT/OAuth/API keys) | 🟡 | Uses Clerk; doesn't know what it does underneath |
| Webhooks | 🟠 | Vionaut has one (Clerk→Svix); mechanism unclear |
| SQL | 🟡 | **Biggest gap.** Runs Prisma/Mongoose without knowing generated SQL |
| Database concepts (indexes, transactions, ACID) | 🟡 | Follows TekPOS `$transaction` rule without knowing why |
| Docker | 🟠 | Runs containers; images vs volumes vs layers undifferentiated (→ 228 GB `Docker.raw`) |
| Linux / servers / SSH | 🟠 | Deploys TekPOS via runbook; systemd, permissions, logs unclear |
| Networking (ports, TCP, DNS) | 🟠 | |
| How programs run (process/thread/memory) | 🔴 | |
| Concurrency vs parallelism | 🔴 | |
| Testing (unit/integration, pytest) | 🔴 | |
| Debugging with a debugger | 🔴 | Currently debugs by pasting errors into Claude |
| Reading stack traces | 🟠 | |
| Security / secrets management | 🟠 | Uses `.env`; no threat model |

### Languages
| Skill | Level | Notes |
|---|---|---|
| JavaScript / TypeScript | 🟡 | Ships React Native + Express; learned path-following with AI help |
| React / React Native | 🟡 | Vionaut is live on Play Store |
| Python | 🔴 | |
| Async Python | 🔴 | |
| Pydantic / type hints | 🔴 | |
| Bash | 🔴 | |
| C / C++ (Arduino, ESP32) | 🔴 | Phase 4 |

### AI / agents
| Skill | Level | Notes |
|---|---|---|
| Prompting (practical) | 🟡 | Runs a real multi-step Claude Desktop → Claude Code workflow daily |
| Claude Code (interactive) | 🟡 | Plan mode → review → execute flow is established |
| Claude Code (headless / `-p`) | 🔴 | |
| LLM APIs (Messages, streaming) | 🔴 | |
| Tool / function calling | 🔴 | |
| Agent loop | 🔴 | |
| MCP | 🔴 | |
| Embeddings / vector search | 🔴 | |
| RAG | 🔴 | |
| Evals | 🔴 | |
| Prompt injection / agent security | 🔴 | |
| How transformers work | 🔴 | |

### Hardware / voice (Phases 3–4)
| Skill | Level |
|---|---|
| Raspberry Pi / Linux SBC | 🔴 |
| Home Assistant | 🔴 |
| Audio fundamentals (sample rate, PCM, VAD) | 🔴 |
| Electronics basics (Ohm's law, GPIO, I2C) | 🔴 |
| Soldering | 🔴 |
| LiPo safety | 🔴 |

### Math
| Skill | Level |
|---|---|
| Linear algebra / vectors / dot product | 🔴 |
| Probability basics | 🟠 |

---

## Concepts currently confusing me
*Living list. Add the moment something doesn't land; remove when it clicks. The Tutor Chat should attack this list first.*



---

## Wins
*Things that moved 🔴/🟠 → 🟢. Read this when the project feels slow — at <5 hrs/week it will, and this list is the proof it isn't.*

| Date | Skill | From → To | What made it click |
|---|---|---|---|
| Week 1 | Terminal / shell | 🟠 → 🟡 | Tutor chat + 18/18 L1 exercises. Child/parent process model clicked — why `cd` is a built-in. |
| Week 1 | Bash scripting | 🔴 → 🟠 | xargs, awk, jq, pipelines, `set -x`, permissions — via exercises, not just reading. |
| Week 1 end | Bash scripting | 🟠 | status.sh shipped — git branch, uncommitted count, last 5 commits |
| Week 2 | Git — daily commands | 🟠 → 🟡 | Learn Git Branching complete, relative refs comfortable |
| Week 2 | Git — mental model | 🔴 → 🟡 | Commits/branches as pointers clicked. Recovered 3 disasters with reflog. |
| Week 2 | Security / secrets | 🟠 | .gitignore written, .env protected, git status verified — R17 enforced in code |
| Week 3 | HTTP / REST | 🟠 → 🟡 | curl se apne Vionaut endpoints hit kiye — har header ka matlab samjha live |
| Week 3 | Auth | 🟠 → 🟡 | Bearer token flow crystal clear — secret → user → session → JWT → header |
| Week 3 | Networking/DNS | 🔴 → 🟠 | DNS flow + TLS basics — howdns.works + Cloudflare |
| Week 4 | SQL | 🔴 → 🟡 | SQLBolt + Select Star SQL + TekPOS pe raw queries chalai — JOIN aur GROUP BY hands-on kiya |
| Week 4 | Database concepts | 🔴 → 🟡 | $transaction ka purpose samjha — BEGIN/COMMIT/ROLLBACK TekPOS wastage example se |