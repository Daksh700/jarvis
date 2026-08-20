# JARVIS — Learning Curriculum
**v2 — recalibrated for actual starting level (Aug 2026)**

---

## 0. Correction to v1

The first version of this document assumed you knew Docker, git, SQL, the terminal, HTTP, and testing, and only needed Python + AI on top. That was wrong, and you were right to call it out.

**New assumption: you know how to make things work — you don't yet know why they work.** You ship a React Native app and run Prisma migrations, but you learned those by following paths, with AI filling gaps. The underlying layers (shell, git internals, SQL, containers, networking, how a program actually runs) are holes.

That's a completely normal place to be, and it's fixable. But it changes three things:

1. **A foundations phase goes in front.** Not as school — every week produces something that touches Vionaut or TekPOS.
2. **Two of my earlier verdicts were wrong**, and I'm reversing them:
   - **"Automate the Boring Stuff" — skip it.** ❌ Reversed. I said skip because I thought you were an intermediate JS dev. At your actual level, chapters 1–6 are a good, gentle Python on-ramp. It's free online (automatetheboringstuff.com). Read Part I only, skip Part II (you'll learn automation from your own project instead).
   - **"Grokking Algorithms" — skip it.** ❌ Reversed. I said it wasn't relevant to agents. True, but it *is* relevant to you having programming intuition at all. It's short, illustrated, and ~6 hours. Read it during Phase 1 as background.
3. **The timeline stretches.** ~11–12 months became **~14–16 months**. Doing the foundations is faster than not doing them — I'd rather give you the honest number.

**The reframe that matters:** these foundations aren't a detour from JARVIS. Every single one of them makes you better at Vionaut and TekPOS *this month*. Learning SQL makes your Prisma queries stop being magic. Learning git properly means the marketing agent's `git log` parsing makes sense. Learning Docker properly means your disk doesn't hit 228 GB again. **You are not pausing work to study. You are removing the ceiling you keep hitting.**

---

## 1. How to use this document

**Principle: Just-In-Time, not Just-In-Case.** At <5 hrs/week you cannot afford a theory year. Every item is mapped to the phase where you need it.

**Three tiers per topic:**
- 🔴 **Blocking** — you cannot build the next phase without this
- 🟡 **Needed soon** — learn during that phase, not before
- 🟢 **Depth** — makes you better, never blocks you

**Rule: do not read ahead into 🟢 until 🔴 is done.** The most common failure mode for someone in your position is reading interesting things instead of building boring ones.

---

# TRACK 0 — FOUNDATIONS
### Phase -1, Weeks 1–8 · ~40 hrs · the phase v1 didn't have

**One resource above all others:**

> ### 🔴 MIT — "The Missing Semester of Your CS Education" (2026 edition)
> **missing-semester.mit.edu/2026** · free · **9 lectures** · YouTube playlist available
>
> This is literally a course about everything I wrongly assumed you knew: shell, command-line environment, dev tools, debugging, version control, packaging, agentic coding, code quality. Made by MIT PhD students precisely because universities skip it.
>
> **Use the 2026 edition** (missing.csail.mit.edu/2026) — that's what you've already started. The 2020 edition (11 lectures) had different topics: Shell Tools & Scripting and Data Wrangling were separate lectures in 2020 but are not in 2026. Those gaps are covered via Tutor chat exercises instead.
>
> **2026 full lecture list:**
> - L1 (1/12): Course Overview + Introduction to the Shell ✅ done
> - L2 (1/13): Command-line Environment → Week 1 remaining / Week 6
> - L3 (1/14): Development Environment and Tools → Week 1 remaining
> - L4 (1/15): Debugging and Profiling → Week 7–8
> - L5 (1/16): Version Control and Git → Week 2
> - L6 (1/20): Packaging and Shipping Code → bonus, Week 6
> - L7 (1/21): Agentic Coding → bonus, Phase 1 (directly relevant)
> - L8 (1/22): Beyond the Code → bonus, read when useful
> - L9 (1/23): Code Quality → bonus, Phase 1
>
> **If you do one thing from this entire document, do this course.** L1–L5 collapse about half of Track 0 into ~5 hours.

Also, across all of Track 0: **Julia Evans' zines and blog** (jvns.ca). She explains exactly these topics — how git works, how containers work, how DNS works, bite-size command line — in illustrated, beginner-friendly form. Her free blog posts cover most of it. Best writer on the internet for the gaps you have.

---

## 0.1 🔴 Terminal & shell — Week 1

You type commands into a terminal daily and mostly don't know what's happening. Fix that first; everything else runs on top of it.

**What you must be able to do by the end:** navigate confidently, pipe commands together, understand `PATH` and env vars, edit your `.zshrc` and know why, kill a stuck process, read a man page, write a 10-line bash script.

| Resource | Type | Time |
|---|---|---|
| **Missing Semester 2026** — L1 (Shell) ✅ done · L2 (Command-line Environment) · L3 (Dev Tools) | Course | ~2 hrs remaining for Week 1 |
| **Missing Semester 2020** — L2 (Shell Tools) + L4 (Data Wrangling) | Reference only | These 2020 lectures cover grep/sed/awk/xargs — watch if you want depth after Tutor exercises. Not required. |
| **"The Linux Command Line"** — William Shotts (free PDF, linuxcommand.org) | Book | Read Parts 1–2 |
| **Julia Evans — "Bite Size Command Line"** zine | Zine | 1 hr |
| **explainshell.com** | Tool | Paste any command, get every flag explained. Use constantly. |
| **tldr** (`brew install tlrp`/`tldr`) | Tool | Man pages but readable |

**Concepts to be able to explain out loud:** stdin/stdout/stderr · pipes and redirects (`|`, `>`, `>>`, `2>&1`) · exit codes · env vars and `PATH` · `chmod` and permission bits · foreground vs background jobs · what a shell actually is vs a terminal emulator.

**Deliverable:** a bash script `status.sh` that cds into your Vionaut repo, prints branch, uncommitted file count, and last 5 commits.

---

## 0.2 🔴 Git — properly, not just the 5 commands — Week 2

You use git. You do not understand git. This gap will bite you specifically in JARVIS, because the marketing agent parses `git log` and the sprint agent reads git state — you can't design tools around a system you treat as magic.

**What you must be able to do:** explain what a commit actually *is* (a snapshot + parent pointer), branch and merge without fear, rebase, use `reflog` to recover from disasters, resolve conflicts calmly, write a `.gitignore` that actually protects your `.env`.

| Resource | Type | Time |
|---|---|---|
| **Learn Git Branching** (learngitbranching.js.org) | Interactive | 3 hrs — **best way to learn git that exists.** Do it. |
| **Missing Semester 2026** — L5: Version Control and Git | Video | 1 hr — the *mental model*, taught from the data structure up |
| **"Pro Git"** — Chacon & Straub (free at git-scm.com/book) | Book | Ch. 1–3 now, Ch. 10 (Internals) later 🟢 |
| **Julia Evans — "How Git Works"** zine | Zine | Paid (~$12) but excellent |
| **ohshitgit.com** | Reference | Bookmark it. You will need it. |

**Concepts:** commit as immutable snapshot · HEAD, refs, branches as pointers · merge vs rebase (and when each) · staging area · detached HEAD · `reflog` as your undo button · tags · remotes and tracking branches.

**Deliverable:** deliberately break a repo (bad rebase, reset --hard, detached HEAD) in a scratch clone, and recover it with `reflog`. Doing this on purpose once removes the fear permanently.

---

## 0.3 🔴 HTTP, APIs & how the internet works — Week 3

You consume APIs daily. JARVIS *is* an API client, an API server, and a webhook receiver all at once.

| Resource | Type | Time |
|---|---|---|
| **MDN — HTTP guide** (developer.mozilla.org, "HTTP" section) | Docs | 3 hrs — Overview, Messages, Methods, Status codes, Headers, CORS |
| **Julia Evans — "HTTP: Learn your browser's language"** zine + her blog posts | Zine | 1 hr |
| **howdns.works** (comic) | Comic | 20 min |
| **Cloudflare Learning Center** (cloudflare.com/learning) | Site | Free, excellent short explainers on DNS/TLS/CDN |
| **httpie** or **curl** practice | Hands-on | Hit your own Vionaut `/api/rates` endpoint from the terminal |

**Concepts:** request/response anatomy · methods & idempotency · status code families · headers (Content-Type, Authorization) · JSON · REST vs RPC · authentication: API keys vs Bearer tokens vs OAuth2 vs JWT (you use Clerk — learn what it's actually doing) · webhooks (Vionaut's Clerk→Svix webhook is one) · rate limiting (you use Arcjet — learn the concept) · CORS · TLS basics.

**Deliverable:** curl every endpoint of your own Vionaut staging API and document the shapes by hand. You'll find at least one thing you didn't know your own API did.

---

## 0.4 🔴 Databases & SQL — Week 4

**This is your biggest hidden gap.** You run Prisma and Mongoose without knowing what they generate. TekPOS is a multi-tenant financial system on PostgreSQL — not knowing SQL there is genuinely risky, and JARVIS's memory layer is SQLite.

| Resource | Type | Time |
|---|---|---|
| **SQLBolt** (sqlbolt.com) | Interactive | 2 hrs — free, in-browser, the fastest good SQL intro |
| **Select Star SQL** (selectstarsql.com) | Interactive book | 3 hrs — free, teaches thinking not just syntax |
| **"Practical SQL"** — Anthony DeBarros | Book | 🟡 Reference for later depth |
| **Use The Index, Luke** (use-the-index-luke.com) | Site | 🟡 Free. Indexes and why queries are slow. Read before Phase 2. |
| **SQLite docs** — "Appropriate Uses For SQLite" + core API | Docs | 🟡 Before Phase 1 week 7 |
| **PostgreSQL Tutorial** (postgresqltutorial.com) | Site | 🟡 TekPOS-relevant |

**Concepts:** relational model · primary/foreign keys · JOINs (inner/left — draw them) · GROUP BY & aggregates · indexes and why they matter · transactions and ACID (TekPOS's `$transaction` rule exists *because* of this) · N+1 query problem · what an ORM actually generates.

**Deliverable:** open your local TekPOS Postgres with `psql` or Prisma Studio, and write raw SQL for three queries your app already does via Prisma. Compare. This one exercise will change how you write Prisma forever.

---

## 0.5 🔴 Docker — actually understanding it — Week 5

Your `Docker.raw` hit 228 GB. That happened because containers, images, volumes, and build cache were undifferentiated in your head.

| Resource | Type | Time |
|---|---|---|
| **Docker's own "Get Started" guide** (docs.docker.com/get-started) | Docs | 2 hrs |
| **"Docker Deep Dive"** — Nigel Poulton | Book | 🟡 The clearest Docker book. Read Ch. 1–8. |
| **Julia Evans — "How Containers Work"** zine | Zine | 1 hr — explains namespaces/cgroups without a CS degree |
| **KodeKloud Docker for Beginners** | Free course | Hands-on labs |
| **NetworkChuck — "you need to learn Docker RIGHT NOW"** | YouTube | Good energy, good intro |

**Concepts:** image vs container vs volume vs network · layers and build cache (this is why your disk exploded) · Dockerfile · `docker-compose` · port mapping · bind mounts vs named volumes · `prune` commands and **exactly which ones destroy data** (your TekPOS Postgres volume lives in one).

**Deliverable:** write a `docker-compose.yml` from scratch for TekPOS's Postgres, with a named volume and a documented backup command using `pg_dumpall`.

---

## 0.6 🔴 Linux, servers & deployment — Week 6

You SSH into Hostinger and run PM2 commands from a runbook. JARVIS will live on a Raspberry Pi running Linux 24/7, so this stops being optional.

| Resource | Type | Time |
|---|---|---|
| **DigitalOcean tutorials** (digitalocean.com/community/tutorials) | Site | Free, best-written sysadmin tutorials anywhere. Read: SSH keys, users & permissions, systemd, nginx basics, ufw firewall. |
| **"The Linux Command Line"** — Parts 3–4 | Book | Scripting + system |
| **Missing Semester 2026** — L2: Command-line Environment (processes, job control, dotfiles, remote machines) | Video | 1 hr — directly relevant for Pi setup |
| **Missing Semester 2026** — L6: Packaging and Shipping Code | Video | 1 hr — bonus, useful for deploying JARVIS |
| **PM2 docs** | Docs | You use it blind on TekPOS — read it |
| **`man systemd.service`** + a systemd tutorial | Docs | 🟡 Needed Phase 3 for JARVIS as a service |

**Concepts:** file permissions & ownership · users and sudo · SSH keys (public/private — actually understand the asymmetry) · processes and daemons · systemd units · cron · log files and `journalctl` · environment on a server vs locally · reverse proxy basics.

**Deliverable:** SSH into your Hostinger box and, without a runbook, find the TekPOS process, read its logs, and check disk usage.

---

## 0.7 🔴 How programs actually run — Week 7

The layer under everything. Light but non-negotiable, because agent bugs live here (blocking calls, memory, encoding).

| Resource | Type | Time |
|---|---|---|
| **Crash Course Computer Science** (YouTube, PBS) — Episodes 1–20 | Video | ~4 hrs, 12-min episodes. Perfect gym/commute watching. |
| **Missing Semester 2026** — L4: Debugging and Profiling | Video | 1 hr — print debugging → real debuggers → profiling |
| **Rob Pike — "Concurrency is not Parallelism"** | Talk | 30 min. Clears up the confusion permanently. |
| **CS50 (Harvard)** — Weeks 0–5 | Course | 🟢 If you ever want real fundamentals. ~40 hrs. Excellent, but optional. |
| **"Computer Systems: A Programmer's Perspective"** | Book | 🟢 Someday. Heavy. |

**Concepts:** process vs thread · stack vs heap (roughly) · blocking vs non-blocking I/O · concurrency vs parallelism · text encoding (UTF-8, why emoji break things, base64) · buffering · what "the GIL" means before Python surprises you.

---

## 0.8 🔴 Testing, debugging & reading code — Week 8

You currently debug by pasting errors into Claude. That works until it doesn't — and agent systems fail *silently*, which is the exact case AI can't rescue you from.

| Resource | Type | Time |
|---|---|---|
| **Missing Semester 2026** — L4: Debugging and Profiling | Video | 1 hr (same lecture as 0.7 — watch once, applies to both) |
| **"Python Testing with pytest"** — Brian Okken | Book | 🟡 Read Ch. 1–5 during Phase 0 |
| **pytest docs** — Getting Started + Fixtures | Docs | 🟡 |
| **Julia Evans — "How to be a wizard programmer"** / her debugging posts | Blog | Free, 1 hr |
| **Test & Code** (Brian Okken) | Podcast | 🟢 Ambient |

**Skills:** read a stack trace top-to-bottom and find *your* line · use a real debugger (`pdb` / VS Code breakpoints) instead of print · minimal reproduction · logging levels vs print · what a unit test vs integration test is · mocking an API call.

**The meta-skill:** when Claude gives you code, you should be able to read it and say "this part I understand, this part I don't." Right now you probably can't draw that line, and that's the single most important thing Track 0 gives you.

---

## 0.9 🟡 Math for the AI parts — during Phases 0–2, background

Much less than you fear. You need vector intuition, not calculus.

| Resource | Type | Time |
|---|---|---|
| **3Blue1Brown — "Essence of Linear Algebra"** | YouTube playlist | 3 hrs. **Do this one.** Beautiful, and it's exactly the intuition embeddings need. |
| **3Blue1Brown — "Essence of Calculus"** | Playlist | 🟢 Only if you go into Karpathy's backprop videos |
| **Khan Academy** — probability & statistics basics | Site | 🟢 Fill gaps as they appear |

**What you actually need:** what a vector is · dot product · cosine similarity (this *is* semantic search) · what "high-dimensional space" means · basic probability (for sampling/temperature).

---

## 0.10 🟡 Security & secrets — during Phase 1

| Resource | Type |
|---|---|
| **OWASP Top 10** — skim the list, read the ones that apply | Site |
| **Missing Semester 2026** — L9: Code Quality (covers testing, linting, security practices) | Video — bonus |
| **Missing Semester 2020** — Lecture 9 (Security & Cryptography) | Video — the 2020 security lecture is still available and covers crypto basics not in 2026. Worth watching if security concepts are shaky. |
| **12-Factor App** (12factor.net) — §3 Config | Site — 15 min, changes how you handle env vars forever |
| **Simon Willison's prompt injection archive** (simonwillison.net/tags/prompt-injection/) | Blog — 🔴 before Phase 2 |

**Concepts:** never commit secrets (`git-secrets` / `gitleaks`) · env vars vs secret managers · principle of least privilege · scoped API tokens · why your JARVIS GitHub token should be repo-scoped, not account-wide.

---

## 0.11 🟡 Networking for the Pi — before Phase 3

| Resource | Type |
|---|---|
| **Cloudflare Learning Center** — networking section | Site |
| **Julia Evans** — networking zines/posts | Blog |
| **Tailscale docs** — "How Tailscale works" | Docs — genuinely great explainer |
| **Beej's Guide to Network Programming** | 🟢 Free book, if you want depth |

**Concepts:** LAN vs WAN, private IP ranges · ports · TCP vs UDP · WebSockets vs HTTP (JARVIS's wearable uses WS) · mDNS/Bonjour (how the Pi finds devices) · NAT and why remote access is hard · VPN/Tailscale.

---

## 0.12 🟡 Audio fundamentals — before Phase 3

Voice pipelines break in audio-specific ways, and no amount of Python knowledge helps if you don't know what a sample rate is.

| Resource | Type |
|---|---|
| **"The Scientist and Engineer's Guide to DSP"** (dspguide.com, free) | Book — read Ch. 1–3 only |
| **Wikipedia:** Sampling, Nyquist–Shannon, PCM | Reference — 1 hr |
| **Whisper / Piper / openWakeWord READMEs** | Docs |
| **Xiph.org — "Digital Show and Tell"** (Monty) | Video — 24 min, the best audio explainer on the internet |

**Concepts:** sample rate (16 kHz is the STT standard — know why) · bit depth · mono vs stereo · PCM/WAV vs compressed (Opus) · buffer size ↔ latency tradeoff · VAD · far-field vs near-field mics · I2S (how the ESP32 mic talks).

---

## 0.13 🟡 Electronics & soldering — before Phase 4

You're going to hold a soldering iron and a lithium battery. **The LiPo section is a genuine safety item, not a formality.**

| Resource | Type |
|---|---|
| **Paul McWhorter — Arduino/electronics YouTube series** | The best beginner electronics teacher on YouTube. Start here. |
| **"Getting Started in Electronics"** — Forrest Mims III | Book — hand-drawn classic, ~₹500 |
| **Adafruit Learn** (learn.adafruit.com) | Site — free, excellent, project-based |
| **Adafruit — "Li-Ion & LiPoly Batteries"** guide | 🔴 **Read before buying a battery.** Fire risk is real. |
| **EEVblog — soldering tutorial** | YouTube — 1 hr, watch before your first joint |
| **Andreas Spiess** | YouTube — best ESP32 channel, rigorous |
| **Ben Eater** | YouTube — 🟢 deep hardware intuition, wonderful but optional |

**Concepts:** voltage/current/resistance & Ohm's law · why a resistor · GPIO · digital vs analog · I2C/SPI/UART (and which your parts use) · LiPo charging, protection circuits, puncture/heat danger · multimeter basics (continuity, voltage) · soldering technique.

**Buy before Phase 4:** cheap soldering iron + solder + flux (~₹1,200), multimeter (~₹600), breadboard + jumper kit (~₹400). Practice on a ₹50 perfboard, **not** on your ₹2,500 XIAO board.

---

## 0.14 🔴 The meta-skill — ongoing, all phases

How to learn things without a tutorial. This is what separates you-now from you-in-a-year.

- **Read the docs first, AI second.** Force yourself to check official docs before asking Claude. Slower for a week, 3× faster forever.
- **Minimal reproduction.** Strip the bug down to 10 lines. You'll solve half of them in the stripping.
- **Read source code.** When a library confuses you, open it. Python libraries are readable — that's part of why we chose Python.
- **Write it down.** `LEARNING_LOG.md`. If you can't explain it in three lines, you don't know it.
- **The Feynman check:** explain the concept to an imaginary junior. Where you get vague is where the gap is.
- **Julia Evans — "How to ask good questions"** and **"How to be a wizard programmer"**: free, short, genuinely useful.

**How to use Claude Code without it replacing your learning:**
> Rule: **you may not accept code you cannot read.** If Claude Code writes something you don't understand, that's a learning ticket, not a completed task. Ask it to explain, or read the docs. Otherwise in 6 months you'll have a JARVIS you cannot debug — which is worse than no JARVIS.

---

# TRACK 1 — PYTHON
### Phase 0, Weeks 9–14 · 🔴

Recalibrated for actual level. Fluent Python moved to later — it's a great book that would have frustrated you in week 1.

| Resource | Type | When | Why |
|---|---|---|---|
| **"Automate the Boring Stuff with Python"** — Al Sweigart (free at automatetheboringstuff.com) | Book | Week 9 🔴 | Reversing my earlier call. Read **Part I only** (Ch. 1–6): basics, flow control, functions, lists, dicts, strings. Skip Part II — your own project is your automation practice. ~8 hrs. |
| **"Python Crash Course"** — Eric Matthes | Book | Alternative to above | If you prefer a paid, more structured book. Part I only. Pick one, not both. |
| **The official Python Tutorial** (docs.python.org/3/tutorial) | Docs | Week 10 🔴 | 2 hrs. Read after the basics land — it's a reference, not a first read. |
| **Real Python** (realpython.com) | Site | Ongoing 🔴 | Best tutorial quality for Python. Your go-to for any specific topic. |
| **Pydantic docs** — "Concepts" section | Docs | Week 11 🔴 | Pydantic is ~40% of modern AI Python. Non-optional. |
| **Python type hints** — mypy docs "Cheat Sheet" | Docs | Week 11 🔴 | Coming from JS you'll want types |
| **"Using Asyncio in Python"** — Caleb Hattingh | Book | Week 12 🟡 | ~100 pages. Async is the JS dev's overconfidence trap — it's not the same model. |
| **"Python Testing with pytest"** — Brian Okken | Book | Week 13 🟡 | Ch. 1–5 |
| **"Effective Python"** — Brett Slatkin | Book | Phase 1 🟡 | 90 "do this, not that" items. Great JIT reference. |
| **"Fluent Python", 2nd ed** — Ramalho | Book | Phase 2+ 🟢 | Deep. Read when Python feels comfortable, not before. |
| **ArjanCodes** | YouTube | Ongoing 🟢 | Python architecture & design patterns |
| **mCoding** (James Murphy) | YouTube | Ongoing 🟢 | Short, deep internals |
| **Talk Python To Me** | Podcast | Ambient 🟢 | |

**Coming from JS, the things that will trip you:** indentation as syntax · no `const`/`let` · mutable default arguments (`def f(x=[])` — a classic bug) · `self` everywhere · list comprehensions replacing `.map`/`.filter` · imports execute at runtime · asyncio is opt-in and "viral" · the GIL means threads don't parallelize CPU work · virtual environments (uv makes this painless).

---

# TRACK 2 — HOW LLMs ACTUALLY WORK
### Phases 0–2, background · 🟡

Do this on commutes and at the gym. It is not blocking, but it changes how you prompt and where you spend tokens.

### Start here (before the deep stuff)
| Resource | Time | Why |
|---|---|---|
| **Andrej Karpathy — "Deep Dive into LLMs like ChatGPT"** | ~3.5 hrs | 🔴 **If you watch one thing, this.** Pretraining → post-training → RLHF → hallucination. Beginner-accessible. |
| **Karpathy — "How I Use LLMs"** | ~2 hrs | 🔴 Practical, and directly improves your Claude Code workflow tomorrow |
| **Jay Alammar — "The Illustrated Transformer"** | 30 min | Visual, gentle |
| **3Blue1Brown — Neural Networks Ch. 5–7** (transformers, attention) | 3 hrs | The best visual explanation that exists. Do Track 0.9 (linear algebra) first. |

### Then, when you want depth 🟢
| Resource | Time |
|---|---|
| **Karpathy — "Let's build GPT: from scratch, spelled out"** | 2 hrs — type it out, don't just watch |
| **Karpathy — "Let's build the GPT Tokenizer"** | 2 hrs — explains a shocking amount of weird LLM behaviour |
| **Karpathy — "Neural Networks: Zero to Hero"** (full playlist) | ~15 hrs — the gold standard. Realistically a Phase 2–3 project for you. |
| **Karpathy — "Software Is Changing (Again)"** (Software 3.0 talk) | 40 min — framing for what you're building |

### Books
| Book | When |
|---|---|
| **"AI Engineering"** — Chip Huyen (O'Reilly, 2025) | 🔴 **The single most relevant book to this project.** Evals, RAG, agents, cost, latency. Buy this one. Read during Phase 1. |
| **"Hands-On Large Language Models"** — Alammar & Grootendorst | 🟡 Visual, practical, beginner-friendly |
| **"Grokking Algorithms"** — Bhargava | 🟡 Reversing my earlier call — read it in Phase 1 for general programming intuition. Short, illustrated, ~6 hrs. |
| **"Designing Machine Learning Systems"** — Chip Huyen | 🟢 After AI Engineering |
| **"Build a LLM (From Scratch)"** — Sebastian Raschka | 🟢 If you go all the way down |

### Blogs
- **Simon Willison** (simonwillison.net) — 🔴 the best practitioner blog in the field; his prompt-injection writing is required reading
- **Lilian Weng** (lilianweng.github.io) — agents, memory, hallucination
- **Anthropic Engineering blog** — 🔴 consistently the best agent-design writing anywhere
- **Chip Huyen** (huyenchip.com) · **Eugene Yan** (eugeneyan.com) · **Hamel Husain** (hamel.dev — "Your AI Product Needs Evals") · **Sebastian Raschka's "Ahead of AI"** newsletter

---

# TRACK 3 — TIER-0 AI READS
### 🔴 Before you write your first tool — Phase 0, Weeks 13–14

Moved *after* Track 0 and Python. In v1 these were week 1; you'd have understood a third of them. Now they'll land.

1. **Anthropic — "Building Effective Agents"** (~30 min). The best document on agent design. Thesis: most "agents" should be workflows. Read twice.
2. **Lilian Weng — "LLM Powered Autonomous Agents"** (~1 hr). The canonical survey — planning, memory, tool use, reflection.
3. **Anthropic docs — Tool Use** (~1 hr, hands on keyboard).
4. **Model Context Protocol — spec + Python SDK quickstart** (modelcontextprotocol.io, ~2 hrs). Learn before you write tools; it determines your architecture.

Also worth an hour: Anthropic's engineering posts on **writing tools for agents**, **effective context engineering**, and **prompt caching**.

---

# TRACK 4 — RESEARCH PAPERS
### One per week, max · Phase 1 onwards 🟡

Read abstract → intro → method → limitations. Skip the math. **Do not start these before Phase 1** — without Track 0 they'll be discouraging rather than useful.

**How to read a paper as a beginner:** watch **Yannic Kilcher's** walkthrough on YouTube first if one exists, then read. Halves the difficulty.

### Must read (Phases 1–2)
| Paper | Year | Why it matters to JARVIS |
|---|---|---|
| **ReAct: Synergizing Reasoning and Acting** (Yao et al.) | 2022 | The thought→action→observation loop. This *is* your agent loop. Read first. |
| **Toolformer** (Schick et al.) | 2023 | How models learn to call tools |
| **Reflexion** (Shinn et al.) | 2023 | Agents that critique and retry — your architectural-review step is this pattern |
| **Chain-of-Thought Prompting** (Wei et al.) | 2022 | Foundational, easy read |
| **Cognitive Architectures for Language Agents (CoALA)** (Sumers et al.) | 2023 | Best framework for agent memory types. Shapes your memory design directly. |
| **Generative Agents** (Park et al.) | 2023 | Memory stream + reflection + retrieval. Steal this architecture. |
| **MemGPT / Letta** (Packer et al.) | 2023 | Memory beyond the context window |
| **Voyager** (Wang et al.) | 2023 | **Read carefully.** Agent that writes its own reusable skills — capability 2.8, JARVIS extending itself. |

### Foundational 🟢
| Paper | Year | |
|---|---|---|
| **Attention Is All You Need** (Vaswani et al.) | 2017 | The transformer. Watch a walkthrough first — it's dense. |
| **Language Models are Few-Shot Learners** (GPT-3) | 2020 | In-context learning |
| **Retrieval-Augmented Generation** (Lewis et al.) | 2020 | RAG origin |
| **InstructGPT** (Ouyang et al.) | 2022 | Why chat models behave as they do |
| **Constitutional AI** (Bai et al., Anthropic) | 2022 | Alignment; relevant to your guardrails |
| **Whisper** (Radford et al.) | 2022 | Before Phase 3 |
| **LoRA** (Hu et al.) | 2021 | If you ever finetune |

### Advanced 🟢
**Tree of Thoughts** (2023) · **Self-RAG** (2023) · **SWE-agent: Agent-Computer Interfaces** (2024 — why interface design determines agent performance) · **Lost in the Middle** (2023 — why context position matters).

**Keeping up:** arxiv-sanity · Papers with Code · **AK (@_akhaliq)** on X · **Yannic Kilcher** on YouTube · Raschka's newsletter.

---

# TRACK 5 — AGENTS IN PRACTICE
### Phases 1–2 🔴

### Free courses
| Course | Provider | When |
|---|---|---|
| **Anthropic Academy** — prompt engineering interactive tutorial + MCP course | Anthropic | Phase 0 end 🔴 Most directly applicable |
| **Hugging Face Agents Course** (free, certificate) | HF | Phase 1 🔴 Best free structured agents course |
| **DeepLearning.AI short courses** (free, 1–2 hrs each) | DL.AI | Phase 1 🟡 Do: *Functions/Tools/Agents with LangChain*, *AI Agents in LangGraph*, *MCP: Build Rich-Context AI Apps*, *Building & Evaluating Advanced RAG* |
| **LangChain Academy — Intro to LangGraph** | LangChain | Phase 2 start 🟡 |

### Docs to read properly (not skim)
- **Anthropic API docs**: tool use, prompt caching, streaming, batch, structured outputs, Claude Agent SDK 🔴
- **Claude Code docs**: headless mode (`claude -p`, `--output-format json|stream-json`, `--allowedTools`, `--permission-mode`, `--bare`), MCP servers, `CLAUDE.md` memory, subagents, hooks 🔴
- **MCP**: spec, Python SDK, existing server implementations 🔴
- **Telegram Bot API** + **python-telegram-bot** docs: inline keyboards, voice messages, file handling — your Phase 1 interface 🔴
- **FastAPI** docs — the best-written docs in Python, genuinely 🟡
- **LangGraph**: concepts → persistence → human-in-the-loop → time travel 🟡
- **Pydantic AI** docs 🟡 · **Langfuse** docs 🟡
- **Expo + EAS docs** (Build/Submit/Updates), **Prisma docs** (migrate dev vs deploy, generate, studio), **Railway API docs** — needed to automate your own projects 🟡

### Codebases to read
Reading code is a skill Track 0.8 gives you — use it here.
- **smolagents** (HF) — tiny, readable agent framework. Read the whole thing in an evening. 🔴 Best first codebase.
- **OpenHands** / **SWE-agent** — production coding agents 🟢
- **Home Assistant `voice_assistant`** + **Wyoming** protocol 🟡 (Phase 3)
- **Pipecat** examples 🟡 · **awesome-mcp-servers** list 🟡

---

# TRACK 6 — VOICE & AUDIO
### Phase 3 🟡 (Track 0.12 first)

- **Home Assistant "Year of the Voice" blog series** (Ch. 1–5) — the entire journey by the people who built it. Best voice-assistant resource on the internet.
- **Wyoming protocol** docs
- **openWakeWord**, **faster-whisper**, **Piper**, **Silero VAD** — READMEs *and issues* (the issues are where the real knowledge lives)
- **Pipecat docs** — latency budgets, barge-in, turn detection
- **Whisper paper** (Track 4)
- YouTube: **Everything Smart Home** · **NetworkChuck** (Pi + self-hosting) · **Home Assistant** official channel
- **Raspberry Pi official documentation** — 🔴 read the getting-started + config sections before your Pi arrives

---

# TRACK 7 — EMBEDDED & WEARABLE
### Phase 4 🟡 (Track 0.13 first)

- **Paul McWhorter's series** — start here if electronics is new (it is)
- **ESP-IDF Programming Guide** (Espressif) — the hard, correct path 🟡
- **Arduino IDE + ESP32 core** — the fast path; use this first, ESP-IDF later
- **Seeed Studio XIAO ESP32S3 Sense wiki** — camera, mic, PSRAM, battery examples 🔴
- **ESPHome voice assistant** docs — if you'd rather configure than write firmware
- **microWakeWord** — wake word on the ESP32 itself
- GitHub: `ESP32-AI-SmartGlass`, **OpenGlass** (BasedHardware), TPGmini
- YouTube: **Andreas Spiess** (best ESP32 channel) · **DroneBot Workshop** · **Kevin Darrah**
- **Adafruit LiPo safety guide** 🔴 — before you buy a battery

---

# TRACK 8 — PODCASTS
### Ambient, all phases 🟢

| Podcast | Why |
|---|---|
| **Latent Space** (swyx & Alessio) | The AI engineer podcast. Closest to what you're building. |
| **Dwarkesh Podcast** | The Karpathy episodes are outstanding |
| **Lex Fridman** | Karpathy, Ilya Sutskever, Demis Hassabis episodes |
| **Anthropic's podcast** | Direct from the people building Claude |
| **ThursdAI** | Weekly roundup, saves you doomscrolling |
| **No Priors** · **TWIML** · **Practical AI** | Industry / technical / applied |
| **Talk Python To Me** · **Test & Code** | Python craft |
| **Syntax.fm** · **CoRecursive** | 🟢 General dev; CoRecursive's story-driven episodes are great for fundamentals |

**Conference talks:** AI Engineer Summit / World's Fair on YouTube — agent architectures, evals, voice agents. More current than any book.

---

# THE SCHEDULE

## Phase-by-phase learning gates

| Phase | Weeks | 🔴 Must know before starting |
|---|---|---|
| **-1 Foundations** | 1–8 | Nothing. Start here. |
| **0 Python + agent loop** | 9–14 | Terminal, git, HTTP, SQL basics, Docker, debugging (0.1–0.8) |
| **1 Brain + Telegram** | 15–24 | Python fundamentals, Pydantic, async basics, Tier-0 AI reads (Track 3) |
| **2 Proactive + marketing** | 25–34 | Agent loop built by hand, SQL/indexes, security & prompt injection (0.10) |
| **3 Voice hub** | 35–48 | Linux/systemd (0.6), networking (0.11), audio fundamentals (0.12) |
| **4 EDITH wearable** | 49–62 | Electronics + LiPo safety + soldering (0.13) |
| **5 Sovereignty** | 63+ | Track 2 depth |

## Weekly rhythm at <5 hrs/week

| Slot | Hours | Activity |
|---|---|---|
| Weekday nights ×2 | 1.5 | **Building / doing exercises.** Keyboard only. |
| Weekend block | 2 | The hard thing of the week |
| Commute / gym | free | Podcast, Crash Course CS, Karpathy, 3Blue1Brown |
| Sunday | 0.5 | Write `LEARNING_LOG.md` — what you learned, what still confuses you |

**During Track 0 (weeks 1–8), flip the ratio:** 60% learning / 40% doing. That's the only period where it's inverted. From Phase 0 onward it's 30/70 permanently.

## Rules that make this survive contact with reality

1. **Build : theory = 70:30** (except weeks 1–8).
2. **One paper per week, maximum.** Not before Phase 1.
3. **Never learn something you won't use within 3 weeks.**
4. **You may not accept code you cannot read.** The single most important rule in this document.
5. **`LEARNING_LOG.md` in the repo** — doubles as build-in-public content. Your learning hours and your marketing hours become the same hours.
6. **Missing a week is fine. Quitting isn't.** The plan assumes you lose ~25% of weeks to Vionaut/TekPOS deadlines; the timeline already accounts for it.
7. **Track 0 is not optional and not skippable.** Every week you skip there costs you three weeks of confused debugging later.

---

# THE 10 THINGS THAT ACTUALLY MATTER

Foundations first (Track 0), then these. Everything above is in service of them:

1. The agent loop (ReAct)
2. Tool design — descriptions are prompts; fewer, coarser tools win
3. Context engineering — what goes in the window, in what order, and why
4. Memory architecture — working / episodic / semantic / procedural
5. Structured output + reliable parsing
6. Evals — you cannot improve what you don't measure
7. Cost & latency engineering — routing, caching, batching
8. Failure modes — loops, hallucinated tool calls, silent wrong answers
9. Prompt injection & the trust boundary between reading and acting
10. Human-in-the-loop design — where to put the gate, and how to make approving cheap

---

# BUDGET FOR LEARNING MATERIALS

Almost all of this is free. What's worth paying for:

| Item | ~₹ | Priority |
|---|---|---|
| **AI Engineering** — Chip Huyen | 2,500–4,000 | 🔴 The one book to buy |
| **Grokking Algorithms** | 500–900 | 🟡 |
| **Getting Started in Electronics** — Mims | 400–700 | 🟡 Phase 4 |
| **Python Testing with pytest** | 1,500–2,500 | 🟡 Or use free pytest docs |
| **Docker Deep Dive** — Poulton | 1,500–2,500 | 🟢 Free alternatives exist |
| **Julia Evans zines** | ~₹1,000 each | 🟢 Worth it, but her free blog covers most |
| **Fluent Python / Effective Python** | 3,000–4,500 each | 🟢 Phase 2+, library copies fine |

**Free and better than most paid courses:** Missing Semester 2026 (missing.csail.mit.edu/2026) · Learn Git Branching · SQLBolt · Automate the Boring Stuff · Pro Git · The Linux Command Line · DigitalOcean tutorials · 3Blue1Brown · Karpathy · Crash Course CS · HF Agents Course · DeepLearning.AI shorts · Anthropic Academy · CS50 · Julia Evans' blog · dspguide.com · Adafruit Learn.

**Realistic spend: ₹3,000–5,000 total.** Also check the **GitHub Student Developer Pack** — it carries free credits and tool licences you'd otherwise pay for.
