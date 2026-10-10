# JARVIS — Execution Plan
**Format:** `[ ]` not started · `[~]` in progress · `[x]` done · `[!]` blocked · `[-]` skipped (with reason)
**Pace:** <5 hrs/week. Weeks are budget units, not deadlines. Slipping a week is fine; skipping a gate is not.

---

# PHASE -1 — FOUNDATIONS (Weeks 1–8, ~40 hrs)
*Full syllabus: `03_LEARNING_PATH.md` Track 0. Primary resource: MIT Missing Semester.*

## Week 1 — Terminal & shell
> **Note:** Plan was written for Missing Semester 2020. We are using the **2026 edition** (9 lectures, different ordering). Mapping confirmed by Sprint chat — see below.

- [x] Missing Semester 2026 L1: Course Overview + Shell (was "L1: The Shell")
- [x] Shell Tools content — covered via Tutor chat exercises (xargs, curl, jq, awk, pipelines) — 2026 has no dedicated Shell Tools lecture
- [x] Data Wrangling content — covered via Tutor chat exercises — 2026 has no dedicated Data Wrangling lecture
- [x] 18/18 L1 exercises complete
- [x] Bookmark explainshell.com, install `tldr`
- [x] Concepts solid: quote types (`''`/`""`/`$''`), stdin/stdout/stderr, pipes, redirection (`1>` `2>` `2>&1`), exit codes, `&&`/`||`, child/parent process model, file permissions (`rwx`), `chmod +x`, `set -x`, pipelines
- [x] **Deliverable:** `status.sh` — prints Vionaut branch, uncommitted file count, last 5 commits
- [x] Init jarvis repo, push public
- [x] `LEARNING_LOG.md` first entry write karo
- [x] Update `07_LEARNING_STATE.md`

**2026 lecture mapping (for rest of Phase -1):**
| Original plan | 2026 equivalent |
|---|---|
| L1: The Shell | ✅ L1: Course Overview + Shell |
| L2: Shell Tools & Scripting | ✅ Covered via Tutor chat exercises |
| L4: Data Wrangling | ✅ Covered via Tutor chat exercises |
| Week 2 — Git | → **L5: Version Control and Git** |
| Week 6 — Linux/servers | → **L2: Command-line Environment** + **L4: Debugging & Profiling** |
| Week 7 — How programs run | → **L4: Debugging & Profiling** (partial) |
| (new in 2026, no 2020 equivalent) | L3: Development Environment and Tools |
| (new in 2026, no 2020 equivalent) | L6: Packaging and Shipping Code |
| (new in 2026, bonus) | L7: Agentic Coding |

## Week 2 — Git properly ✅
- [x] Learn Git Branching — Main sequence + Push & Pull (Remote) complete
- [x] Missing Semester **2026 L5**: Version Control and Git
- [x] Read: Pro Git Ch. 1–3
- [x] Bookmark ohshitgit.com
- [x] **Deliverable:** scratch repo — `reset --hard`, detached HEAD, bad rebase — all 3 recovered with `reflog` ✅
- [x] Can explain: commits as pointers, branches as pointers, `reflog` vs `git log`, staging area
- [x] `.gitignore` written — `.env` + `.env.local` protected, verified with `git status`
- [x] Update `07_LEARNING_STATE.md`

## Week 3 — HTTP, APIs, auth
- [x] MDN HTTP guide: Overview, Messages, Methods, Status codes, Headers, CORS
- [x] howdns.works comic
- [x] Cloudflare Learning Center: DNS, TLS basics
- [x] **Deliverable:** curl every Vionaut staging endpoint, document request/response shapes by hand
- [x] Can explain: idempotency, Bearer vs API key vs JWT, what Clerk+Svix webhook actually does, what Arcjet rate limiting does
- [x] Update `07_LEARNING_STATE.md`

## Week 4 — SQL & databases
- [x] SQLBolt (all lessons)
- [x] Select Star SQL (at least half)
- [x] **Deliverable:** open local TekPOS Postgres, write raw SQL for 3 queries the app does via Prisma, compare output and shape
- [x] Can explain: JOIN types, indexes, transactions/ACID, N+1 problem, what `$transaction` protects against in TekPOS
- [x] Update `07_LEARNING_STATE.md`

## Week 5 — Docker for real
- [x] Docker "Get Started" official guide
- [-] Julia Evans — How Containers Work - skipped — deliverable complete without it, Next bucket
- [x] **Deliverable:** write `docker-compose.yml` from scratch for TekPOS Postgres, named volume, documented `pg_dumpall` backup command
- [x] Can explain: image vs container vs volume, layers & build cache (why `Docker.raw` hit 228 GB), which `prune` commands destroy data
- [x] Update `07_LEARNING_STATE.md`

## Week 6 — Linux, servers, deployment
- [ ] DigitalOcean tutorials: SSH keys, users & permissions, systemd, ufw
- [ ] Missing Semester **2026 L2**: Command-line Environment (processes, job control, dotfiles, remote machines)
- [ ] Missing Semester **2026 L6**: Packaging and Shipping Code (bonus — useful for JARVIS deploy)
- [ ] Missing Semester **2020 L9**: Security & Cryptography (2020 only — crypto basics, still worth watching)
- [ ] Read PM2 docs properly (currently used blind on TekPOS)
- [ ] **Deliverable:** SSH into Hostinger, find the TekPOS process, read its logs, check disk usage — no runbook
- [ ] Can explain: SSH key asymmetry, systemd units, cron, `journalctl`
- [ ] Update `07_LEARNING_STATE.md`

## Week 7 — How programs actually run
- [ ] Crash Course Computer Science ep. 1–20 (gym/commute)
- [ ] Rob Pike — "Concurrency is not Parallelism"
- [ ] Missing Semester **2026 L4**: Debugging and Profiling
- [ ] **Deliverable:** `LEARNING_LOG.md` entry explaining in own words — process vs thread, blocking vs non-blocking, concurrency vs parallelism, UTF-8
- [ ] Update `07_LEARNING_STATE.md`

## Week 8 — Testing & debugging + GATE
- [ ] Julia Evans debugging posts
- [ ] Missing Semester **2026 L4**: Debugging and Profiling (if not watched in Week 7 — covers debuggers, profiling)
- [ ] Learn a real debugger (VS Code breakpoints or `pdb`)
- [ ] **Deliverable:** debug one real Vionaut or TekPOS bug using a debugger, zero print statements
- [ ] Can do: read a stack trace to the right line, build a minimal reproduction, explain logging levels vs print
- [ ] 🚩 **PHASE GATE:** take 30 lines Claude wrote for Vionaut/TekPOS. Annotate every line: understood / not understood. If >30% is "not understood," repeat the weakest week before Phase 0.
- [ ] Update `07_LEARNING_STATE.md` — full pass over every skill

---

# PHASE 0 — PYTHON + THE AGENT LOOP (Weeks 9–14, ~30 hrs)

## Week 9 — Python basics + repo init
- [ ] Automate the Boring Stuff Part I, Ch. 1–3
- [ ] Install `uv`, understand venvs
- [ ] **Deliverable:** create `/Users/dakshgoel/Desktop/jarvis`, `uv init`, first commit, push public
- [ ] **Deliverable:** port `status.sh` (week 1) to Python
- [ ] Add `08_CLAUDE.md` + `09_PROJECT_RULES.md` to repo root

## Week 10 — Python data & files
- [ ] Automate the Boring Stuff Ch. 4–6 (lists, dicts, strings)
- [ ] Official Python Tutorial (skim end-to-end)
- [ ] **Deliverable:** script that parses Vionaut `docs/11_EXECUTION_PLAN.md` and prints task counts by status

## Week 11 — Types, Pydantic, HTTP client
- [ ] Pydantic docs — Concepts section
- [ ] mypy cheat sheet
- [ ] httpx basics
- [ ] **Deliverable:** typed script hitting GitHub API for open PRs on both repos

## Week 12 — asyncio
- [ ] Using Asyncio in Python (Hattingh) — or asyncio docs + Real Python guide
- [ ] **Deliverable:** async version of week 11 script, both repos fetched concurrently
- [ ] Can explain: why `async` in Python differs from JS, what the event loop is, what the GIL means

## Week 13 — Tier-0 AI reads + the raw agent loop
- [ ] Anthropic — "Building Effective Agents" (read twice)
- [ ] Lilian Weng — "LLM Powered Autonomous Agents"
- [ ] Anthropic docs — Tool Use (hands on keyboard)
- [ ] MCP spec + Python SDK quickstart
- [ ] **Deliverable:** `agent.py` — raw tool-calling loop, ~60 lines, **no framework**. Tools: `get_time`, `read_file`

## Week 14 — Real tools + GATE
- [ ] Add tools: `git_status(repo)`, `list_open_prs(repo)`, `read_notion_page(id)`
- [ ] Add token/cost logging per request
- [ ] pytest basics — write 3 tests for the dispatch function
- [ ] **Deliverable:** CLI that answers "Vionaut ka git status?"
- [ ] 🚩 **PHASE GATE:** explain the full cycle — request → `tool_use` stop → dispatch → `tool_result` → next request — without looking at code. If not, repeat week 13.

---

# PHASE 1 — BRAIN + TELEGRAM (Weeks 15–24, ~50 hrs)
*Detail: `04_WORKFLOW_AUTOMATION.md` §3 and §7.*

- [ ] W15 — Telegram bot, user ID whitelisted, text in → agent → text out
- [ ] W16 — Voice notes both directions (faster-whisper + Piper on Mac) 🎉 *voice JARVIS, month 4, zero hardware*
- [ ] W17 — SQLite persistence: conversations, actions, audit log
- [ ] W18–19 — Convert tools to a proper MCP server (`jarvis-mcp`); verify in Claude Desktop
- [ ] W20 — `get_project_state()` — ground-truth status from execution plan + git + Notion
- [ ] W21–22 — `run_claude_code_plan()` + `architectural_review()` (fresh context, separate call)
- [ ] W23 — Approval gates via Telegram inline keyboards
- [ ] W24 — Full loop end to end + cost meter + hard monthly cap
- [ ] 🚩 **PHASE GATE:** run one complete Vionaut workday through JARVIS. Copy-pastes must be <5.

---

# PHASE 2 — PROACTIVE + MARKETING (Weeks 25–34, ~50 hrs)

- [ ] W25–26 — Migrate to LangGraph or Pydantic AI (state machine, checkpoints, interrupts)
- [ ] W27 — Semantic memory: sqlite-vec over own MD files + transcripts
- [ ] W28 — Scheduler + monitors (GitHub Actions, Railway, Atlas, Sentry, Resend)
- [ ] W29 — Proactive alerts + 9am morning brief
- [ ] W30–31 — Sub-agent architecture with per-agent tool allowlists
- [ ] W32 — Marketing agent v1: git diff → LinkedIn / X / Instagram drafts (never fabricate)
- [ ] W33 — Engagement digest + posting integration decision
- [ ] W34 — Langfuse tracing + 20-case eval suite (`EVAL_CASES.md`)
- [ ] 🚩 **PHASE GATE:** JARVIS told you something useful, unprompted, 3× in one week.

---

# PHASE 3 — VOICE HUB (Weeks 35–48, ~65 hrs, ~₹14,000)

- [ ] W35 — Track 0.12 audio fundamentals (sample rates, PCM, buffers, VAD)
- [ ] W36–39 — Full "Hey Jarvis" loop on the Mac, ₹0. Measure latency budget (<2s total)
- [ ] 🚩 **BUY GATE:** hardware only after the Mac loop works. See `BOM.md`
- [ ] W40–42 — Pi 5 setup, NVMe boot, Home Assistant OS
- [ ] W43–45 — Wyoming satellites (Whisper, Piper, openWakeWord), point HA Assist at JARVIS API
- [ ] W46–48 — Speaker verification, barge-in, Tailscale remote access, `RUNBOOK.md`
- [ ] 🚩 **PHASE GATE:** speak "Hey Jarvis, TekPOS ka status?" aloud, spoken answer in <2s.

---

# PHASE 4 — EDITH WEARABLE (Weeks 49–62, ~55 hrs, ~₹5,500)

- [ ] W49 — Track 0.13 electronics + **Adafruit LiPo safety guide** (mandatory before buying a cell)
- [ ] W50 — Soldering practice on ₹50 perfboard. Not on the XIAO.
- [ ] W51–53 — XIAO: blink → Wi-Fi → WebSocket to Pi
- [ ] W54–56 — I2S mic stream + push-to-talk button
- [ ] W57–58 — Bone conduction audio out
- [ ] W59–60 — Camera frame on demand → VLM call
- [ ] W61 — Power management, deep sleep
- [ ] W62 — Mount to glasses (3D-printed clip)
- [ ] 🚩 **PHASE GATE:** tap glasses, ask a question, hear the answer through your skull.

---

# PHASE 5 — SOVEREIGNTY (Weeks 63+)

- [ ] Ollama on Mac, benchmark local model tool-calling vs Claude
- [ ] Route trivial intents locally, hard reasoning to cloud
- [ ] Local RAG over all notes/code/transcripts
- [ ] 🚩 **GATE:** turn off Wi-Fi, it still works.

---

## Slip log
*Record every missed week and why. The plan budgets for ~25% slippage — this log proves you're inside budget, not failing.*

| Week | Planned | What happened | Recovered? |
|---|---|---|---|
| | | | |