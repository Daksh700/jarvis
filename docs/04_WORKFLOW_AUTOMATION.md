# JARVIS — Automating *Your* Actual Workflow

This is the document Gemini couldn't write, because it didn't read what you do all day. Everything here is specific to Vionaut and TekPOS.

---

## 1. Your current loop, written out honestly

### TekPOS / Vionaut (workflow A — Notion-driven)
1. Claude Desktop sprint chat → generate Notion day plan
2. Ask sprint chat → plan-mode prompt for Day N, Part A
3. **Copy → paste into Claude Code**
4. Claude Code returns an implementation plan
5. **Copy plan → paste into Claude Desktop sprint chat**
6. Sprint chat runs your architectural-review prompt → returns critical issues
7. **Copy findings → paste into Claude Code** → implements
8. Repeat 2–7 for every part of the day
9. EOD: sprint chat → progress check + summary + commit message

### Vionaut (workflow B — MD-file-driven)
1. Take your prompt template
2. Paste into ChatGPT + attach `docs/11_EXECUTION_PLAN.md` and relevant docs from the 19-doc set
3. Ask it to rewrite the prompt for the next task (e.g. D10, D11)
4. **Copy → paste into Claude Code** → implements

### TekPOS (workflow C — multi-doc-driven, no ChatGPT step)
1. Manually look up next task in `IMPLEMENTATION_PLAN.md`
2. Compose plan-mode prompt with context from `MASTER_CONTEXT.md` + `PROJECT_RULES.md` + `CLIENT_DECISIONS.md`
3. **Copy → paste into Claude Code** (plan mode)
4. Copy plan → paste into Claude Desktop sprint chat → architectural review
5. Copy findings → paste back into Claude Code → implements
6. Run `prisma validate`, `tsc`, tests manually
7. SSH into Hostinger → `pm2 restart tekpos-api` (production deploy — manual)

### The diagnosis
Count the copy-paste operations: **6–8 per task, 20–30 per day.** Each one requires you to be physically present, at your desk, holding context in your head about which window has what.

You are the message bus between three AI systems. That's the entire job. And a message bus is the most automatable thing in software.

**Rough time cost:** 20–30 context switches/day × ~2 min each ≈ **40–60 min/day of pure mechanical overhead.** At 5 hrs/week of JARVIS budget, automating this pays for the entire Phase 1 investment in about 3 weeks of use.

Two more problems worth naming:
- **State lives in your head.** Which task is next, what got skipped, what's blocked — none of it is queryable.
- **The Notion plan and the code drift.** Nothing reconciles them automatically.

---

## 2. Target loop

```
You (Telegram):  "Vionaut D5 shuru karo"
                          ↓
JARVIS:  reads execution_plan.md + all MD context + git state
         → composes the Claude Code plan-mode prompt (your template)
         → runs: claude -p "<prompt>" --output-format json
                          ↓
         Claude Code returns implementation plan
                          ↓
         → sends plan to REVIEWER (separate Claude call, your architectural
           review prompt, fresh context, no anchoring)
                          ↓
         Reviewer returns: 2 critical, 3 nits
                          ↓
Telegram:  📋 "D5 plan ready. 2 critical issues:
             1. Swap controller has no optimistic-update rollback
             2. Polyline recolour will re-render all 7 days
            [ Approve ] [ Approve w/ fixes ] [ Show full plan ] [ Reject ]"
                          ↓
You tap:  Approve w/ fixes
                          ↓
JARVIS:  → claude -p "<plan + critical fixes>" --allowedTools "Read,Edit,Bash"
         → runs typecheck + tests
         → reports diff summary
                          ↓
Telegram:  ✅ "D5 done. 7 files, +284/-31. Typecheck clean.
             Commit message ready. [ Commit ] [ Show diff ] [ Also draft posts ]"
```

**Your involvement drops from 25 copy-pastes to about 4 taps.** And you can do those 4 taps from a bus.

---

## 3. Tool specification — build these in Phase 1

Write them as an MCP server (`jarvis-mcp`) so Claude Desktop and Claude Code can also use them.

### 3.1 State tools
```python
get_project_state(project: Literal["vionaut","tekpos"]) -> ProjectState
```
**Vionaut** reads: `docs/11_EXECUTION_PLAN.md` (active sprint tasks D1–D14), `docs/04_MASTER_CONTEXT.md`, git log since last tag, open PRs, Notion sprint DB, Railway `/health` (staging + prod), EAS build queue status.
**TekPOS** reads: `IMPLEMENTATION_PLAN.md` (phase tracker), `MASTER_CONTEXT.md`, `CLIENT_DECISIONS.md`, `PROJECT_RULES.md`, git log, Hostinger PM2 process status (`pm2 status`), Prisma migration status (`prisma migrate status`).
Returns: current phase, completed tasks, next task, blockers, uncommitted changes, last deploy.
**This one tool alone answers "Vionaut ka status kya hai?" properly** — from ground truth, not from a chat that might have drifted.

```python
get_next_task(project) -> Task            # id, title, deps, acceptance criteria, related files
mark_task_complete(project, task_id, commit_sha)
get_blockers(project) -> list[Blocker]
```

### 3.2 Prompt composition tools
```python
compose_plan_prompt(project, task_id) -> str
```
This replaces your ChatGPT step entirely. Loads your prompt template + `execution_plan.md` + `MASTER_CONTEXT.md` + relevant MD files + the specific task, fills the template. Deterministic where possible — **a template with slots beats an LLM rewrite for reliability**, and it's free. Use an LLM only for the genuinely generative parts (e.g. summarising which existing files are relevant).

```python
compose_review_prompt(plan_text, project) -> str
```

### 3.3 Execution tools
```python
run_claude_code_plan(prompt, cwd) -> Plan
# claude -p "<prompt>" --output-format json --permission-mode plan

run_claude_code_implement(prompt, cwd, allowed_tools) -> Result
# claude -p "<prompt>" --output-format stream-json \
#   --allowedTools Read,Edit,Bash --permission-mode acceptEdits

architectural_review(plan, project) -> Review
# separate Anthropic API call, fresh context, your review prompt
# returns structured: [{severity, issue, why, fix}]

# Vionaut-specific deployment tools (all GATED):
eas_build(platform, profile) -> BuildResult          # APPROVE — triggers EAS cloud build
eas_submit(platform, build_id) -> SubmitResult        # APPROVE — submits to Play Store / App Store
eas_update(branch, message) -> OTAResult              # NOTIFY — OTA JS-only update (no store review)
railway_deploy(service, tag) -> DeployResult          # NOTIFY (staging) / APPROVE (production)

# TekPOS-specific deployment tools (all GATED):
prisma_migrate_status(cwd) -> MigrationStatus         # None — read-only
prisma_migrate_deploy(cwd) -> MigrationResult         # APPROVE — runs pending migrations on production
prisma_generate(cwd) -> None                          # None — generates client
pm2_restart(service) -> PM2Status                     # NOTIFY (staging) / APPROVE (production)
```

**Critical design note:** the reviewer must be a *fresh context* API call, not a continuation of the planning conversation. Reviewing your own plan in the same context is anchored and produces sycophantic reviews. This is why your current manual flow (Claude Code plans, Claude Desktop reviews) actually works well — preserve that separation deliberately.

### 3.4 Verification tools
```python
# Vionaut checks: tsc (all workspaces), eslint, jest, expo doctor
# TekPOS checks: tsc (all workspaces), eslint, jest/vitest, prisma validate, prisma migrate status
run_checks(project) -> CheckResult
git_diff_summary(repo) -> str
generate_commit_message(diff) -> str
git_commit(repo, message)            # GATED
git_push(repo, branch)               # GATED — never to main without approval
# Note: for Vionaut, pushing a tag to main triggers Railway auto-deploy
# Note: for TekPOS, pushing to main does NOT deploy — pm2_restart is a separate step
```

### 3.5 Reporting tools
```python
sprint_progress(project) -> Report
daily_summary(project, date) -> Summary
update_notion(page_id, content)      # GATED
```

---

## 4. The marketing agent — properly scoped

You said Gemini got this wrong. Here's it done right.

### 4.1 The non-negotiable rule
**Ground truth or nothing.** Every post is generated *from the actual git diff of what shipped today*. If nothing shipped, JARVIS says "aaj post karne layak kuch nahi hai" — it does not invent a milestone.

This is the same rule you already enforce on Vionaut ("never fabricate AI-generated text — omit the element and leave a TODO"). Apply it here. A build-in-public account that posts fabricated progress is worse than one that posts nothing.

### 4.2 Pipeline
```
Daily 8pm trigger
  → git log --since=midnight + diff stat (from Vionaut repo — primary build-in-public account)
  → read docs/11_EXECUTION_PLAN.md → what phase/task just moved to [x]?
  → screenshots from Expo dev/preview build (manual capture for now; EAS preview build URL if available)
  → classify: is this postworthy? (visible feature / phase milestone / lesson learned / nothing)
     — Phase transitions (A→B→C etc.) are always postworthy
     — Individual D-tasks (D1 Arcjet, D2 Sentry, etc.) are postworthy if user-facing or architecturally interesting
     — Nothing shipped today → no post (never fabricate)
  → if postworthy:
       LinkedIn draft   — 150–250 words, narrative, "what I learned / why this matters" angle
       X thread draft   — 3–5 posts, hook-first, technical detail
       Instagram draft  — carousel copy (5 slides) + image brief per slide
  → Telegram: all three + [Approve][Edit][Skip]
  → on approve: copy-ready, or push to Buffer/Typefully
```

**Content series to track:** "Building JARVIS" is a separate parallel series — JARVIS work also generates build-in-public content. The marketing agent should handle both Vionaut posts and JARVIS dev-log posts without conflating them.

### 4.3 Beyond posting — the rest of the funnel
| Capability | Phase | Notes |
|---|---|---|
| Engagement digest | 2 | Comments + DMs summarised each morning, replies drafted |
| Performance analytics | 2 | What performed; what content type wins for you |
| Weekly growth report | 2 | Followers, reach, waitlist signups, trend |
| Email campaigns (Resend) | 2 | Waitlist sequences, launch emails, drafted + gated |
| Competitor watch | 2 | You already do this manually for Rhyme. Weekly: their App Store release notes, new screens, pricing changes, social activity. |
| ASO / App Store copy | 3 | Keyword research, description variants |
| Landing page copy variants | 3 | |
| Content calendar | 3 | Plans ahead instead of reacting daily |
| Screenshot/recording automation | 3 | Expo build → automated capture on device |

### 4.4 Voice consistency
Create `BRAND_VOICE.md` per project — tone, vocabulary, what you never say, example posts you liked. Feed it into every generation. Without this the drafts will read like generic LinkedIn slop and you'll stop using the feature by week 3. This file is the difference between the marketing agent surviving or dying.

---

## 5. The other agents

### Ops agent (Phase 2)
Monitors on a schedule — alerts, not dashboards. A dashboard you have to open is a dashboard you won't open.

**Vionaut monitors:**
- Railway staging + prod `/health` — service down alert
- MongoDB Atlas M0 free-tier storage usage — hitting the cap silently breaks the app with no error
- EAS build queue — stuck/failed builds
- Resend email quota (waitlist campaigns)
- Sentry error rate spike (frontend + backend, via `sentryScrub.ts` pattern)
- PostHog funnel drops (via API)
- Arcjet trial plan expiry — if it lapses, enforcement disappears silently (only `decision:"error"` in logs)
- GitHub Actions CI failures

**TekPOS monitors:**
- Hostinger PM2 process status — `pm2 status tekpos-api` down alert
- PostgreSQL Docker container status (local dev — if Docker dies, all dev work stops)
- SSL certificate expiry on Hostinger box
- Razorpay webhook delivery failures
- GitHub Actions CI failures
- Disk space on Hostinger server

### Research agent (Phase 2)
Answers "kya X library Expo SDK 56 support karti hai?" with a real web search + doc read, rather than a plausible guess. Also: competitor watch, library evaluation, "how do others solve multi-tenant X".

### Knowledge agent (Phase 2)
RAG over your own material: `MASTER_CONTEXT.md`, `execution_plan.md`, past Claude transcripts, Notion, TekPOS schema decisions. Query: *"TekPOS mein invoice number race condition kaise handle kiya tha?"* → returns *your* BranchCounter decision, not a generic StackOverflow answer.

This is quietly one of the highest-value features. You have months of decisions locked in chat logs and MD files that are effectively write-only right now.

---

## 6. Approval gate design

Getting this right determines whether you actually use JARVIS or fight it.

| Action | Gate |
|---|---|
| Read anything | None |
| Compose prompts | None |
| Run Claude Code in **plan** mode | None |
| Run Claude Code **implement** on a feature branch | None (it's a branch — cheap to throw away) |
| Run tests / typecheck / `prisma validate` / `expo doctor` | None |
| `prisma migrate status` | None |
| `git commit` | **Notify** (auto-commit on branch, tell you) |
| `git push` to feature branch | **Notify** |
| `git push` to main | **Approve** |
| Railway staging deploy (Vionaut) | **Notify** |
| Railway production deploy (Vionaut) | **Approve** |
| EAS Build trigger (Vionaut) | **Approve** (costs build minutes) |
| EAS Submit to Play Store (Vionaut) | **Approve** (irreversible if published) |
| OTA update publish — `eas update` (Vionaut) | **Notify** |
| PM2 restart staging (TekPOS) | **Notify** |
| PM2 restart production (TekPOS) | **Approve** |
| `prisma migrate deploy` (TekPOS production) | **Approve** — irreversible |
| Social post | **Approve** |
| Outbound email | **Approve** |
| Any `rm` / `DROP` / `docker prune` / `prisma migrate reset` | **Approve** |
| API spend > ₹200 in one task | **Approve** |

**Design principle: make approving one tap, and make rejecting free.** If approval requires reading 200 lines on a phone, you'll rubber-stamp everything and the gate becomes theatre. The Telegram message shows a 3-line summary + a "Show full" button. Summary quality is the whole feature.

---

## 7. Build order for Phase 1 (weeks 15–24, concrete)

| Wk | Ship |
|---|---|
| 15 | Telegram bot, your user ID whitelisted, echoes through the agent loop |
| 16 | Voice notes both directions (Whisper + Piper locally on Mac) |
| 17 | SQLite: conversations, actions, audit log |
| 18–19 | `jarvis-mcp` server; verify the same tools work in Claude Desktop |
| 20 | `get_project_state` — the status feature, from ground truth |
| 21–22 | `run_claude_code_plan` + `architectural_review` |
| 23 | Approval gates with inline keyboards |
| 24 | Full loop + cost meter + hard monthly cap |

**Week 24 acceptance test:** run one complete Vionaut day through JARVIS. Count your copy-pastes. If it's not under 5, the loop isn't done.

---

## 8. Things that will go wrong (so they don't surprise you)

1. **Claude Code headless output parsing breaks** on a version bump. Pin the npm version. Version-check on startup.
2. **The agent loops** — a tool errors, the model retries, forever. Hard-cap iterations at ~15 per task and bail loudly.
3. **Long-running Claude Code runs time out** in your Telegram handler. Make execution a background job with a status message that updates; don't block the bot.
4. **Reviewer gets sycophantic** if you accidentally pass the planning context. Keep it a separate, fresh call. Assert this in a test.
5. **Marketing drafts read generic.** `BRAND_VOICE.md` + 5 real examples of your own posts. Regenerate the file when your voice shifts.
6. **Cost spike** the first time you leave a monitor running overnight with Sonnet. Router on Haiku, cap in code, alert at 50% of budget.
7. **You'll want to add features before Phase 1 is used daily.** Don't. The graveyard of side projects is full of Phase 2 features on top of Phase 1 nobody used.
8. **Prompt injection via a GitHub issue** you asked it to triage. Reader agent ≠ actor agent.

---

## 8b. Prerequisites before Phase 1

Everything in this document assumes Phase -1 (foundations, weeks 1–8) and Phase 0 (Python + raw agent loop, weeks 9–14) are done. Specifically, section 3's tool specs require:

- **Git internals** (0.2) — `get_project_state` parses `git log`; you can't design that without understanding what a commit is
- **SQL** (0.4) — the memory layer is SQLite
- **HTTP/auth** (0.3) — every tool here is an API client
- **Shell & processes** (0.1, 0.6) — `run_claude_code_*` shells out and manages a subprocess
- **Debugging** (0.8) — these tools fail silently; print statements won't save you

If you're reading this doc in week 3, that's fine — read it for motivation, then go back to Track 0.

---

## 9. First commit — do this in week 9, when Python starts

```
jarvis/
├── README.md              # the vision, one page
├── PRD.md                 # doc 00
├── STACK.md               # doc 01
├── LEARNING_LOG.md        # what you learned each session (build-in-public fuel)
├── DECISIONS.md           # ADRs — why you chose X over Y
├── pyproject.toml         # uv init
├── src/jarvis/
│   ├── agent.py           # the loop
│   ├── tools/
│   ├── memory/
│   └── interfaces/
└── tests/
```

Make the repo public from day one — and start the `LEARNING_LOG.md` in **week 1**, during foundations, even before there's code. "Building JARVIS" is a better build-in-public series than most of what's on your timeline right now — and it means your learning hours and your marketing hours are the same hours. At <5 hrs/week, that kind of double-duty is exactly how this survives.
