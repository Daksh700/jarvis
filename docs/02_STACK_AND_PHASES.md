# JARVIS — Tech Stack & Phase Plan

---

# PART A — THE STACK

> ### A0. Jargon decoder (read first)
> Part A uses terms v1 assumed you knew. One line each — enough to read the rest without stopping. Depth comes from doc 02.
>
> | Term | Plain meaning |
> |---|---|
> | **Agent loop** | A `while` loop: ask the model → it asks to run a function → you run it → give it the result → repeat until done. That's the whole idea. |
> | **Tool / function calling** | Giving the model a list of functions it's allowed to request. It doesn't run them; it asks you to, and you decide. |
> | **MCP** | Model Context Protocol — a standard format for describing tools, so the same tool works in Claude Desktop, Claude Code, and your own agent. |
> | **Token** | A chunk of text (~¾ of a word). You're billed per token, in and out. |
> | **Context window** | The model's short-term memory limit, measured in tokens. Nothing outside it exists to the model. |
> | **Prompt caching** | Paying less for the unchanging part of your prompt by telling the API to reuse it. |
> | **Embedding** | Text converted into a list of numbers, so "similar meaning" becomes "close together". Powers semantic search. |
> | **Vector DB / sqlite-vec** | A store that finds the closest embeddings to a query. |
> | **RAG** | Retrieval-Augmented Generation — search your own documents, paste the hits into the prompt, then answer. |
> | **Structured output** | Forcing the model to return valid JSON matching a schema instead of prose. |
> | **Eval** | An automated test for an LLM feature: fixed inputs, expected qualities, scored. |
> | **Observability / tracing** | Recording every model call and tool call so you can see why something went wrong. |
> | **State machine** | Code modelled as named states + allowed transitions, instead of tangled ifs. LangGraph is one. |
> | **Human-in-the-loop / gate** | The agent pauses and waits for your approval before an irreversible action. |
> | **Headless** | Running a program with no UI, driven by a script. `claude -p` is Claude Code headless. |
> | **STT / TTS / VAD** | Speech→text · text→speech · voice activity detection (is anyone talking?). |
> | **Wake word** | The always-listening local model that only reacts to "Hey Jarvis". |
> | **Barge-in** | Being able to interrupt the assistant mid-sentence. |
> | **Local model / Ollama** | An LLM running on your own machine, no internet, no per-token cost. |
> | **Quantized** | A model compressed to smaller numbers so it fits in less RAM, slightly less accurate. |
> | **Prompt injection** | Text the agent *reads* (an email, an issue) containing instructions that hijack it. Your #1 security threat. |
> | **I2S / GPIO / LiPo** | Digital audio wiring standard · general-purpose pins on a chip · lithium-polymer battery. |

For every layer: what to use, what else exists, and **why** — because you said you want the hard road, and the hard road means understanding tradeoffs, not copying a list.

## A1. Language & tooling

| Concern | Choice | Alternatives | Why |
|---|---|---|---|
| Language | **Python 3.12+** | Node/TS | You already know JS. Picking Python is the *point* — plus every AI library, paper implementation, and model runtime is Python-first. Node exists in this world but you'd be permanently one library behind. |
| Package mgmt | **uv** | pip, poetry, pdm | Rust-based, ~10–100× faster than pip, replaces pip+venv+pyenv. This is the current standard; don't learn the old pain. |
| Linting/format | **Ruff** | black + flake8 + isort | One tool, replaces all three. |
| Type checking | **mypy** or **ty** | pyright | Coming from TS you'll want types. Python's are optional and worse — accept it. |
| Testing | **pytest** | unittest | Non-negotiable for agent code; agents fail silently. |
| Data validation | **Pydantic v2** | dataclasses, attrs | Tool schemas, LLM structured outputs, config — all Pydantic. Learn this deeply, it's everywhere in AI Python. |
| Env/secrets | **python-dotenv** + OS keyring | — | |
| Task runner | **just** or Makefile | — | |

**Coming from JS, the 5 things that will bite you:** no `async` by default (asyncio is opt-in and viral), GIL means threads don't parallelize CPU work, imports are runtime-executed, mutable default arguments, and `pip install` polluting global state (uv fixes the last one).

## A2. The model layer

| Role | Choice | Why |
|---|---|---|
| Primary reasoning | **Claude Sonnet 4.6** | Best tool-use reliability; you already work in this ecosystem |
| Router / cheap classify | **Claude Haiku 4.5** | ~10–20× cheaper. Route first, escalate only when needed. This alone is most of your cost control. |
| Vision (cheap, high volume) | **Gemini 2.5 Flash** | You already use it in Vionaut; cheapest good vision |
| Coding agent | **Claude Code (headless)** | Already your workflow |
| Local (Phase 5) | **Ollama** + Qwen3 / Llama 3.x / Gemma | |
| Embeddings | **Voyage AI** or local `bge-m3` / `all-MiniLM-L6-v2` | Local ones run fine on your Mac |

**Cost mechanics you must learn early:** prompt caching (huge — your system prompt + project context is static, cache it), batch API for non-urgent jobs (50% off), streaming for perceived latency, and token accounting per request. Read Anthropic's docs on caching before you write your first agent loop, not after your first ₹2,000 bill.

**One important operational note:** as of mid-2026, programmatic Claude Code usage (`claude -p`, Agent SDK) draws from your Claude subscription's usage limits; Anthropic recommends using a Claude Platform API key for predictable pay-as-you-go automation. For an unattended agent that might fire 50 Claude Code runs a day, plan for the API-key path and budget accordingly.

## A3. Agent framework — the decision that matters most

**Phase 0–1: write the loop yourself. No framework.**

I'm serious, and this is exactly the "hard route" you asked for. It's also *easier* than a framework for a beginner — 60 lines you wrote beats 60,000 lines you didn't. The agent loop is ~60 lines:

```python
while True:
    response = client.messages.create(model=..., messages=msgs, tools=TOOLS)
    if response.stop_reason != "tool_use":
        return response
    for block in response.content:
        if block.type == "tool_use":
            result = dispatch(block.name, block.input)   # your code
            msgs.append(tool_result(block.id, result))
```

That's it. That's the "secret sauce" Gemini gestured at. If you start with LangChain you will learn LangChain, not agents — and when it breaks (it will, at an abstraction boundary you didn't choose) you won't know why. Build it raw, feel the pain, *then* adopt a framework knowing what it's solving.

**Phase 2+: adopt a state machine.**

| Framework | Verdict |
|---|---|
| **LangGraph** | ✅ Recommended. Graph/state-machine model, real persistence, human-in-the-loop interrupts built in, time-travel debugging. Fits approval gates perfectly. |
| **Pydantic AI** | ✅ Strong alternative. Cleanest, most Pythonic, type-safe. Lighter than LangGraph. Pick this if LangGraph feels over-engineered. |
| **Claude Agent SDK** | ✅ Use for the *coding* sub-agent specifically — it's the Claude Code engine as a library. |
| LangChain (classic) | ⚠️ Heavy, leaky abstractions, churns fast. Learn the concepts from its docs, don't necessarily ship on it. |
| CrewAI / AutoGen | ⚠️ Role-play multi-agent. Nice demos, hard to debug. Not for a system you depend on. |
| OpenAI Agents SDK | ⚠️ Fine, but ties you to OpenAI-shaped thinking |
| smolagents (HF) | ✅ Great for *learning* — tiny, readable source. Read it. |

## A4. Tool layer — MCP

**Model Context Protocol** is the spine. Write tools once as MCP servers → usable from Claude Desktop, Claude Code, and your JARVIS loop.

- Official Python SDK: `mcp` (FastMCP-style decorators)
- Existing servers to use, not rebuild: filesystem, git, github, notion, postgres, puppeteer/playwright, brave-search, sqlite
- Custom servers you'll write:
  - `vionaut-mcp` — reads `docs/11_EXECUTION_PLAN.md` + all 19 docs, Railway API (deploy status, logs), EAS API (build status, submission), MongoDB Atlas API (M0 usage), Clerk dashboard
  - `tekpos-mcp` — reads `IMPLEMENTATION_PLAN.md` + 4 other docs, Prisma CLI wrapper (`migrate status`, `migrate deploy`, `generate`), Hostinger SSH + PM2 status, PostgreSQL query
  - `marketing-mcp` — git diff → post draft (Vionaut brand voice from `13_BRAND_VOICE.md`), Buffer/Typefully API
  - `jarvis-memory-mcp` — SQLite + sqlite-vec, episodic + semantic memory
- Claude Code itself can run as an MCP server, exposing its tools to your agent

**Tool design principles** (this is where agents actually fail):
- Tools should be *few and coarse*, not many and fine. 40 tools = confused model. 8 well-designed tools = reliable model.
- Descriptions are prompts. Write them like prompts.
- Return structured, compact results — not 5,000-token dumps
- Errors must be *actionable strings* the model can recover from, not stack traces
- Every tool: idempotent where possible, and explicit about whether it mutates

## A5. Memory

| Layer | Tech | Holds |
|---|---|---|
| Working | `project_state.json` / Redis | Current sprint, active task, session |
| Episodic | SQLite (`conversations`, `actions`) | What happened, when |
| Semantic | **SQLite + sqlite-vec** | Vector search over notes, transcripts, code, docs |
| Procedural | Markdown files (`CLAUDE.md`, `MASTER_CONTEXT.md`) | How things are done here |

Start with SQLite. Postgres+pgvector only when SQLite hurts (it won't, at your scale). Read about **Letta/MemGPT** and **mem0** for architecture ideas, but don't adopt a memory framework early — memory is the layer most worth understanding by hand.

## A6. Voice pipeline (Phase 3)

| Stage | Choice | Alternatives | Notes |
|---|---|---|---|
| Wake word | **openWakeWord** | Porcupine (better accuracy, licence limits), microWakeWord (for ESP32) | Custom "Hey Jarvis" model trainable |
| VAD | **Silero VAD** | webrtcvad | Cheap, essential — stops you streaming silence |
| STT | **faster-whisper** (CTranslate2) | whisper.cpp, distil-whisper, Vosk, Moonshine | `small.en` on Pi 5 ≈ real-time. Moonshine is newer + faster for short commands. |
| TTS | **Piper** | Kokoro TTS (better quality), Coqui, ElevenLabs (cloud, ₹₹) | Piper on Pi is instant. Kokoro if you want it to sound good. |
| Orchestration | **Wyoming protocol** + Home Assistant | Pipecat, LiveKit Agents | Wyoming = HA's voice satellite protocol, purpose-built for exactly this |
| Speaker ID | resemblyzer / SpeechBrain ECAPA | | For privileged-command gating |

**Learn Pipecat's docs even if you don't use it** — it's the best-documented explanation of real-time voice agent problems: interruption handling, turn detection, latency budgets.

## A7. Wearable (Phase 4)

- **Board:** Seeed XIAO ESP32-S3 Sense — dual-core 240MHz, camera, digital mic, 8MB PSRAM, 21×17.5mm
- **Firmware:** ESP-IDF (hard mode, correct) or Arduino (fast). ESPHome if going the Home Assistant route.
- **Audio out:** bone conduction transducer + small amp
- **Protocol:** stream Opus-encoded audio over WebSocket to the Pi. The glasses think about nothing.
- **Power:** 3.7V LiPo 300–500mAh. Realistically 2–4 hrs active. Manage expectations.

## A8. Infra & observability

FastAPI · SQLite · Redis · APScheduler (or arq) for cron · Docker (you know it) · Tailscale for secure remote access to your Pi · **Langfuse** for LLM tracing (self-hostable, free) · **promptfoo** for evals.

**Do not skip observability.** Agents fail in ways logs don't capture. Without traces you'll be debugging blind by Phase 2.

---

# PART B — THE PHASES

Calibrated to **<5 hrs/week (~20 hrs/month)**. I'd rather give you a plan you'll finish than a fantasy.

**Total honest timeline: ~14–16 months to a working EDITH.** (v1 said 11–12 — that assumed foundations you don't have yet. Phase -1 is the difference. It is the highest-ROI phase in the document.)

---

## Phase -1 — Foundations (Weeks 1–8, ~40 hrs, ₹0)

**Goal:** stop treating your own tools as magic. Full syllabus in doc 02, Track 0.

Every week has a deliverable that touches Vionaut or TekPOS, so this is not school — it's paying off technical debt you already carry.

| Week | Learn | Deliverable |
|---|---|---|
| 1 | Terminal & shell (Missing Semester L1–4) | `status.sh` — prints Vionaut branch, uncommitted count, last 5 commits |
| 2 | Git properly (Learn Git Branching + Missing Semester L6) | Break a scratch repo on purpose, recover it with `reflog` |
| 3 | HTTP, APIs, auth, webhooks (MDN) | curl every Vionaut staging endpoint, document the shapes by hand |
| 4 | SQL & databases (SQLBolt, Select Star SQL) | Write raw SQL for 3 queries TekPOS does via Prisma; compare |
| 5 | Docker for real (images/volumes/layers) | `docker-compose.yml` for TekPOS Postgres + documented `pg_dumpall` backup |
| 6 | Linux, SSH, systemd, PM2, logs | SSH to Hostinger, find the process and read logs — no runbook |
| 7 | How programs run (Crash Course CS, concurrency) | Write it up in `LEARNING_LOG.md`: process vs thread, blocking vs async |
| 8 | Testing & debugging (pdb, stack traces, pytest intro) | Debug one real Vionaut/TekPOS bug with a debugger, not print statements |

**Gate:** you can read a piece of code Claude wrote and clearly mark which parts you understand and which you don't. That line is the whole point of this phase.

**Why this isn't optional:** JARVIS is a system that fails silently. AI can rescue you from a stack trace; it cannot rescue you from an agent that returns confident wrong answers because you don't know what your own tools do.

---

## Phase 0 — Python + the Agent Loop (Weeks 9–14, ~30 hrs, ₹0)

**Goal:** Python that doesn't feel foreign + one raw agent loop you wrote yourself.

| Week | Do | Deliverable |
|---|---|---|
| 9 | Python basics — Automate the Boring Stuff Part I (Ch. 1–6). uv, venvs. | Port `status.sh` from week 1 into Python |
| 10 | Official Python tutorial. Data structures, comprehensions, modules, file I/O. | Script that parses `docs/11_EXECUTION_PLAN.md` and prints task status |
| 11 | Type hints + Pydantic. httpx. | Typed script hitting the GitHub API for open PRs |
| 12 | asyncio (the JS-dev trap — different model from JS). | Async version of the above, fetching both repos concurrently |
| 13 | **Tier-0 AI reads (doc 02, Track 3).** Anthropic SDK, Messages API. **Write the raw tool-calling loop by hand.** Two tools: `get_time`, `read_file`. | `agent.py` — ~60 lines, works |
| 14 | Add 3 real tools: `git_status(repo)`, `list_open_prs(repo)`, `read_notion_page(id)`. Cost logging. pytest basics. | CLI you can actually ask "Vionaut ka git status?" |

**Gate:** you can explain what happens between "user types a question" and "tool executes" without looking at code. If not, repeat week 13.

---

## Phase 1 — The Brain + Telegram (Weeks 15–24, ~50 hrs, ₹0)

**Goal:** JARVIS on your phone, wired into your real sprint workflow.

| Week | Do |
|---|---|
| 15 | Telegram bot (`python-telegram-bot`). Text in → agent → text out. Whitelist your user ID only. |
| 16 | Voice notes: Telegram voice → faster-whisper (on Mac) → agent → TTS voice note back. **You have voice JARVIS in week 16 — month 4, no hardware.** |
| 17 | SQLite persistence: conversations, actions, audit log. Session continuity. |
| 18–19 | Convert your tools to a **proper MCP server** (`jarvis-mcp`). Verify it in Claude Desktop too. |
| 20 | **Sprint state tool** — parse `docs/11_EXECUTION_PLAN.md` (Vionaut) or `IMPLEMENTATION_PLAN.md` (TekPOS) + git log + Notion → structured project state. This is the "status" feature done properly. |
| 21–22 | **Claude Code headless integration**: `claude -p "<prompt>" --output-format json` (plan mode: add `--permission-mode plan`; implement mode: add `--allowedTools Read,Edit,Bash --permission-mode acceptEdits`), captured and parsed from Python. |
| 23 | **Approval gates** — Telegram inline keyboards. Approve/Reject/Edit before anything runs. |
| 24 | The full loop, end to end (see doc 03). Cost meter + hard cap. |

**Gate:** one full working day of Vionaut driven through JARVIS instead of manual copy-paste.

**This is where the plan pays for itself.** Everything after this is upside.

---

## Phase 2 — Proactive + Marketing (Weeks 25–34, ~50 hrs, ₹0)

| Week | Do |
|---|---|
| 25–26 | LangGraph (or Pydantic AI) migration. Proper state machine, checkpointing, interrupts. |
| 27 | Semantic memory: sqlite-vec, embed your MD files + transcripts. "TekPOS invoice race condition kaise solve kiya tha?" works. |
| 28 | Scheduler + monitors: GitHub Actions, Vercel, Atlas usage, Resend quota, Sentry. |
| 29 | **Proactive alerts.** JARVIS messages you first. Morning brief at 9am. |
| 30–31 | Sub-agent architecture: router → coding / marketing / research / ops. Tool allowlists per agent. |
| 32 | **Marketing agent v1**: git diff → what shipped → draft LinkedIn + X thread + Instagram copy. Draft only, approval required. Never fabricate. |
| 33 | Posting integrations + engagement digest. (Cost warning below.) |
| 34 | Langfuse tracing + a real eval suite (20 golden cases, promptfoo). |

**Posting API reality check — nobody tells you this:**
- **X API**: free tier is severely limited for posting; Basic tier is ~$100–200/month. **At your budget: don't.** Draft + one-tap copy to the app.
- **LinkedIn API**: personal posting requires app review; painful. Same recommendation.
- **Instagram Graph API**: needs a Business/Creator account linked to a Facebook Page; image must be at a public URL. Doable but fiddly.
- **Buffer / Typefully**: have APIs, cheaper than X's, and solve scheduling. Best value option.
- **Pragmatic v1:** JARVIS drafts all three, sends to Telegram, you tap-copy and paste. Saves 90% of the effort at 0% of the cost. Automate posting only once drafting is proven good.

**Gate:** JARVIS told you something useful you didn't already know, unprompted, 3× in a week.

---

## Phase 3 — Voice Hub (Weeks 35–48, ~65 hrs, ~₹14,000)

**Weeks 35–39: prove it on the Mac first. ₹0.** (Do doc 02 Track 0.12 — audio fundamentals — first. Sample rates and buffers are where voice pipelines actually break.)
openWakeWord + Silero VAD + faster-whisper + Piper, all local on your MacBook. Full "Hey Jarvis" loop. Measure your latency budget: wake (<200ms) → VAD endpoint (<300ms) → STT (<500ms) → LLM first token (<800ms) → TTS first audio (<200ms). If it's over 2s, users disengage — and you're the user.

**Only after this works: buy hardware.**

### BOM — Phase 3 (India, verify current prices at robu.in / Robocraze / Silverline / ThinkRobotics)

| Item | Est. ₹ | Notes |
|---|---|---|
| Raspberry Pi 5 8GB | 7,200–8,300 | Buy from authorised resellers. **Avoid Amazon** — I found listings at ₹23,499 for the same board. Genuinely check 3 sites. |
| Official 27W USB-C PSU | 700–1,200 | Don't cheap out. Undervolting causes bizarre bugs. |
| Active cooler | 600–800 | Required. Pi 5 throttles without it. |
| NVMe HAT + 256GB NVMe | 3,000–4,000 | **Do not use microSD.** Voice pipeline write-cycles will kill it. |
| Case | 600–1,000 | |
| USB mic array (ReSpeaker 4-Mic or USB conference mic) | 1,200–6,000 | Start with a ₹1,200 USB conference mic. Upgrade only if far-field fails. |
| Powered speaker | 0–800 | Reuse anything you have |
| **Total** | **₹13,300–22,100** | Realistic target ~₹14,000 with the cheap mic |

**Weeks 40–48:** Pi setup → Home Assistant OS → Wyoming satellite add-ons (Whisper, Piper, openWakeWord) → point HA's Assist at your JARVIS API → speaker verification → barge-in → Tailscale for remote access.

**Gate:** "Hey Jarvis, TekPOS ka status?" spoken aloud, answered aloud, in <2s.

---

## Phase 4 — EDITH Glasses (Weeks 49–62, ~55 hrs, ~₹3,500 + ~₹2,200 tools)

| Item | Est. ₹ |
|---|---|
| XIAO ESP32-S3 **Sense** (camera + mic) | 1,800–2,600 |
| Bone conduction transducer + mini amp | 700–1,200 |
| LiPo 3.7V 400mAh + JST | 300–500 |
| Tactile button, wires, heatshrink | 200 |
| 3D-printed clip | 0–300 (college lab / local print shop) |
| **Subtotal (parts)** | **₹3,000–4,800** |
| Soldering iron + solder + flux | 900–1,500 |
| Multimeter | 500–800 |
| Breadboard + jumper kit + perfboard practice pieces | 300–500 |
| **Total incl. one-time tools** | **₹4,700–7,600** |

**⚠️ Before you buy the battery:** read Adafruit's LiPo guide (doc 02, Track 0.13). LiPo cells vent, swell, and catch fire when punctured, over-discharged, or charged wrong — and this one sits on your face. Buy a cell with a built-in protection circuit, never charge unattended, and stop using any cell that puffs.

**Practice soldering on a ₹50 perfboard before touching the ₹2,500 XIAO.** Non-negotiable.

**Build order:** blink an LED → Wi-Fi + WebSocket to Pi → mic stream (I2S) → button push-to-talk → audio out via bone conduction → camera frame on demand → VLM call → the whole loop → power management (deep sleep) → mount to glasses.

Open-source references to study: `ESP32-AI-SmartGlass`, TPGmini, OpenGlass (BasedHardware), Seeed's own XIAO Sense camera examples.

**Realistic expectations:** 2–4 hrs battery, slightly awkward on the frame, camera is 1600×1200 not 4K, no visual overlay. It will still feel like magic the first time you hear an answer through your skull.

---

## Phase 5 — Sovereignty (Weeks 63+, ₹0 → ₹25k+ later)

Ollama on the Mac first (M-series is genuinely good at this). Qwen3 8B / Llama 3.x 8B quantized. Benchmark tool-calling reliability against Claude — you'll find local models are notably worse at multi-step tool use; that's the real lesson. Route trivial intents locally, hard reasoning to cloud. Pi 5 alone will be sluggish (a few tokens/sec); a used Mini PC or a GPU box is the eventual answer, but that's a next-year purchase.

---

## Budget summary

| Phase | Spend | Cumulative |
|---|---|---|
| -1 to 2 | ₹0 hardware (+ ~₹500–1,500/mo API from Phase 0) | ₹0 |
| Learning materials (books, one-time) | ~₹3,000–5,000 | ~₹4,000 |
| 3 — Pi voice hub | ~₹14,000 | ~₹18,000 |
| 4 — wearable + tools | ~₹5,500 | ~₹23,500 |
| **Total** | | **~₹23,500 spread over 14+ months (~₹1,700/month)** |

That's slightly above the ₹20k figure, but it's spread across more than a year — and Phase 4 is 12 months out, so it's a next-budget-cycle problem, not a now problem. If you want to stay strictly under ₹20k: skip the ReSpeaker (use a ₹1,200 USB conference mic), borrow a multimeter, and use library/PDF copies for books.

API spend is the ongoing line item. Cap it at ₹1,500/month in code, and use Haiku + prompt caching aggressively. Also check whether you're eligible for the GitHub Student Developer Pack — it carries credits for several services you'd otherwise pay for.
