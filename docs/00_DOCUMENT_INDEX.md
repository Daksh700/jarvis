# JARVIS — Document Index
**Owner:** Daksh Goel · **Project type:** Personal R&D / learning (not public-facing)
**Read this first.** It tells you what exists, which doc wins on conflict, and which chat to use.

---

## 1. Current state pointer

> **Phase:** -1 (Foundations)
> **Week:** 5 of 8
> **Active doc:** `06_EXECUTION_PLAN.md` → Week 5 (Docker)
> **Next gate:** Week 8 — can read Claude-written code and mark understood vs not understood
> **Repo:** `/Users/dakshgoel/Desktop/jarvis` · public from day one

*Update the four lines above every week. This is the only part of this file that changes often.*

---

## 2. Document map

| # | File | What it is | Changes? | In Project Knowledge? |
|---|---|---|---|---|
| 00 | `00_DOCUMENT_INDEX.md` | This file. Index, conflict rules, chat routing. | Weekly (state pointer) | ✅ |
| 01 | `01_PRD.md` | Vision, full capability map, architecture, safety, success criteria | Rarely | ✅ |
| 02 | `02_STACK_AND_PHASES.md` | Tech stack with alternatives + phase plan + BOM + jargon decoder | Per phase | ✅ |
| 03 | `03_LEARNING_PATH.md` | Full curriculum, Track 0–8, per-phase gates | Rarely | ✅ |
| 04 | `04_WORKFLOW_AUTOMATION.md` | Tool specs that automate Daksh's real sprint loop | Phase 1 | ✅ |
| 05 | `05_MASTER_CONTEXT.md` | Cross-project workflow truth (Vionaut, TekPOS, JARVIS), approval gates, AI tool rules | Monthly | ✅ |
| 06 | `06_EXECUTION_PLAN.md` | Week-by-week `[ ]` checklist | **Weekly** | ✅ |
| 07 | `07_LEARNING_STATE.md` | What Daksh actually knows: solid / shaky / not started | **Weekly** | ✅ |
| 08 | `08_CLAUDE.md` | Working rules for Claude Code inside this repo | Rarely | ✅ (also lives at repo root) |
| 09 | `09_PROJECT_RULES.md` | Non-negotiable philosophy and guardrails | Rarely | ✅ |
| — | `LEARNING_LOG.md` | Append-only journal, one entry per session | Every session | ❌ local only (grows unbounded) |
| — | `DECISIONS.md` | ADRs — why X over Y | On decisions | ✅ once it has 3+ entries |
| — | `GLOSSARY.md` | Terms in Daksh's own words as he learns them | Weekly | ❌ local |
| — | `RESOURCES_TRACKER.md` | Books/courses: not started / in progress / done | Weekly | ❌ local |
| — | `COST_LOG.md` | API spend per month vs the ₹1,500 cap | Monthly | ❌ local |
| — | `BOM.md` | Hardware shopping list, prices found, what's bought | Phase 3–4 | ❌ local |
| — | `BRAND_VOICE_JARVIS.md` | Voice for the "Building JARVIS" build-in-public series | Phase 1+ | ❌ local until Phase 1 |
| — | `RUNBOOK.md` | How to restart/recover the Pi and services | Phase 3+ | ❌ local until Phase 3 |
| — | `EVAL_CASES.md` | 20 golden test cases for the agent | Phase 2+ | ❌ local until Phase 2 |

**Rule of thumb for Project Knowledge:** upload what Claude needs to give correct advice. Keep local anything that only grows (logs), only matters to one phase (runbook, BOM), or is a personal scratchpad.

---

## 3. Conflict hierarchy

If two documents disagree, higher wins:

1. **`09_PROJECT_RULES.md`** — non-negotiable guardrails. Nothing overrides these.
2. **`07_LEARNING_STATE.md`** — if it says a concept is "not started," no chat should assume it. Beats every other doc on what Daksh knows.
3. **`06_EXECUTION_PLAN.md`** — task ordering and current position.
4. **`05_MASTER_CONTEXT.md`** — cross-project workflow, approval gates, AI tool usage.
5. **`01_PRD.md`** — scope and architecture intent.
6. **`02_STACK_AND_PHASES.md`** / **`03_LEARNING_PATH.md`** — how and what to learn/build.
7. **`04_WORKFLOW_AUTOMATION.md`** — implementation detail for Phase 1.

**On approval gates and safety, `05_MASTER_CONTEXT.md` §5–6 is absolute** and beats anything in the PRD.

---

## 4. Chat routing — which conversation for what

| Need | Chat |
|---|---|
| "Ye concept samajh nahi aaya" / explain this code / quiz me | **Tutor Chat** |
| Weekly plan, what to do this week, session wrap-up | **Sprint Chat** |
| "Should memory be SQLite or Postgres?" / design decisions / ADRs | **Architecture Chat** |
| "JARVIS could also do X" — parking lot, scope control | **Ideas Chat** |
| Architectural review of a Claude Code plan | **Sprint Chat — NEW conversation, fresh context** |
| Build-in-public posts about JARVIS | Existing **Content Studio** project (not a JARVIS chat) |

**Hard rule (from `05_MASTER_CONTEXT.md` §2.3):** the architectural reviewer must never share a conversation with the planner. Always a new conversation.

---

## 5. What this project is not

- Not a product. No users, no launch date, no revenue.
- Not a race. <5 hrs/week. Missing a week is expected and budgeted for.
- **Primary output is Daksh's capability, not the software.** A working JARVIS that he can't debug is a failure. A half-built JARVIS that he fully understands is a success.
