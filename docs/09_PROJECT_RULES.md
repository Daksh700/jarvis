# JARVIS — Project Rules
**Highest authority in this project.** Nothing in any other document overrides these.

---

## 1. The learning rules

**R1 — Never accept code you cannot read.**
Unreadable generated code is a learning ticket, not a completed task. This is the single most important rule in the project. Break it consistently and you end up with a JARVIS you cannot debug — strictly worse than no JARVIS.

**R2 — Docs before AI.**
On any new library or tool, read the official docs first, ask Claude second. Slower for a week, ~3× faster forever.

**R3 — The Feynman check.**
If you can't explain it in three lines in `LEARNING_LOG.md`, you haven't learned it. Mark it 🟡 in `07_LEARNING_STATE.md` and move on honestly.

**R4 — Foundations are not skippable.**
Phase -1 gates are hard gates. Every skipped foundations week costs roughly three weeks of confused debugging later.

**R5 — Update `07_LEARNING_STATE.md` weekly, honestly.**
Inflating it produces explanations pitched over your head. That's self-sabotage with extra steps.

---

## 2. The build rules

**R6 — Raw before framework.**
Write the agent loop by hand before touching LangGraph or Pydantic AI. Sixty lines you wrote beat sixty thousand you didn't.

**R7 — Ground truth or silence.**
Never fabricate project status, task completion, or marketing content. Read the actual files, the actual git log. If nothing shipped, say nothing shipped.

**R8 — Fresh context for reviews.**
The architectural reviewer must never share a conversation with the planner. Same-context reviews are sycophantic and defeat the entire purpose.

**R9 — Gate before you act.**
Nothing destructive, public, or production-facing runs without an explicit approval tap. Full table: `05_MASTER_CONTEXT.md` §5.

**R10 — Tools are few and coarse.**
Forty fine-grained tools produce a confused model. Eight well-designed ones produce a reliable one. Tool descriptions are prompts.

**R11 — Reader agent ≠ actor agent.**
Anything that reads external content (issues, emails, web pages) is read-only and cannot chain into a write tool in the same turn. Prompt injection is the #1 real threat.

**R12 — Observability from day one of Phase 1.**
Agents fail silently. No traces means debugging blind.

---

## 3. The scope rules

**R13 — Three-bucket discipline** (carried over from Vionaut).
Every new idea goes to exactly one: **Now** (current phase) · **Next** (Ideas Chat parking lot) · **Never** (write it down, close it). Scope explosion is listed as a High risk in the PRD for a reason.

**R14 — The utility test.**
Every feature must answer: *does this save me time on Vionaut or TekPOS, or teach me something on the critical path?* If neither, it goes to Next.

**R15 — Ship usable before ship complete.**
Telegram voice at week 16 beats a perfect architecture at week 40. The most likely failure mode for this project is abandonment, not bad code.

**R16 — Missing a week is fine. Quitting isn't.**
The plan budgets ~25% slippage. Log it in the slip log and continue. Do not restart the plan.

---

## 4. The safety rules

**R17 — Never push secrets.** Check `git status` before every commit. `.env` is in `.gitignore` from commit one.

**R18 — Scoped credentials only.** The JARVIS GitHub token is repo-scoped, never account-wide. Separate API keys with their own budget caps.

**R19 — Hard spend cap in code.** ₹1,500/month ceiling, enforced programmatically. Alert at 50%. An agent looping on a tool error can burn ₹5,000 in an hour.

**R20 — Iteration cap.** Hard limit of ~15 tool-call iterations per task, then bail loudly.

**R21 — Never touch Vionaut or TekPOS production from JARVIS without an explicit gate.** These are a live Play Store app and a live multi-tenant client system. JARVIS is a toy relative to them. It never gets to break them.

**R22 — LiPo batteries are a fire hazard, not a formality.** Protected cells only. Never charge unattended. Discard any cell that swells. This one goes on your face.

**R23 — Wearable ethics.** Push-to-talk, never always-on capture. Visible indicator when recording. Never enroll a face without consent. Don't wear it in someone's home or office without telling them.

---

## 5. The one-line summary

> **The output of this project is Daksh, not JARVIS.**
> A half-built assistant he fully understands is a win. A complete assistant he can't debug is a loss.
