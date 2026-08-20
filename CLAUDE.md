# CLAUDE.md — Working Rules for the JARVIS Repo
*Lives at repo root. Claude Code reads this automatically.*

---

## Context

Personal R&D project. **The owner is learning — that is the point of the project.** He is a beginner/early-intermediate developer: ships React Native and runs Prisma migrations, but shell, git internals, SQL, Docker, networking, and testing are actively being learned (see `docs/07_LEARNING_STATE.md`).

Budget: <5 hrs/week. Timeline: ~14–16 months. There is no deadline pressure and no user waiting.

---

## The prime directive

> **Teach, don't just deliver.**
>
> Optimising for "task complete" is the wrong objective here. A working feature the owner can't explain is a failure. A half-feature he fully understands is a success.

Concretely:
1. **Explain before you write.** State the approach and why, then write the code.
2. **Comment the non-obvious.** Not `# increment i` — comment the *decisions*.
3. **Flag unfamiliar concepts.** If the solution uses something at 🔴/🟠 in `07_LEARNING_STATE.md`, say so first.
4. **Prefer the readable solution over the clever one**, even at a small performance cost. Idiomatic-but-obscure Python is worse than verbose-and-clear here.
5. **When there's a choice, name the alternatives** and say why this one.
6. **Never silently fix something.** If you find an unrelated bug, mention it — don't quietly patch it.

---

## Hard rules

1. **No framework before the raw version exists.** The agent loop is written by hand first (Phase 0). LangGraph/Pydantic AI only from Phase 2, and only after the raw loop works.
2. **No code the owner can't read.** If it needs an unlearned concept, flag it as a learning ticket instead of shipping it.
3. **No dependency without justification.** Every new package: state what it does and why the stdlib isn't enough. Small dependency trees are a learning feature, not just hygiene.
4. **Type hints on every function.** Pydantic models for every tool input/output.
5. **Tests for every tool.** Agent tools fail silently — that's the whole failure mode of this project.
6. **Secrets from env only.** Never in code, never in prompts, never in commits.
7. **No `localStorage`-style shortcuts, no global mutable state.** State goes in SQLite or is passed explicitly.

---

## Project conventions

- **Package manager:** `uv` (never bare `pip`)
- **Lint/format:** Ruff · **Types:** mypy · **Tests:** pytest
- **Layout:** `src/jarvis/{agent,tools,memory,interfaces}/`
- **Tool design:** few and coarse, not many and fine. Descriptions are prompts — write them as such. Errors return actionable strings, never raw stack traces.
- **Commits:** conventional commits (`feat:`, `fix:`, `docs:`, `chore:`)
- **Branches:** `feat/<short-name>`; never commit directly to main

---

## Approval gates

Full table in `docs/05_MASTER_CONTEXT.md` §5. Inside this repo specifically:

- `git push` to main → **ask first**
- Any command touching Vionaut or TekPOS files/DBs → **ask first**
- Installing a new dependency → **mention it**, don't just add it
- Anything that spends API credits in a loop → **ask first**

---

## Reference docs

Read from `docs/` when relevant:
- `00_DOCUMENT_INDEX.md` — index, conflict hierarchy, current phase
- `06_EXECUTION_PLAN.md` — what week we're in and what's next
- `07_LEARNING_STATE.md` — **read before explaining anything**
- `09_PROJECT_RULES.md` — non-negotiable philosophy
- `01_PRD.md` — capability map and architecture intent

---

## Anti-patterns for this repo specifically

| Don't | Do |
|---|---|
| Write 200 lines and say "done" | Write 40, explain them, check understanding |
| Use a clever comprehension chain | Use a readable for-loop with a comment |
| `except Exception: pass` | Handle the specific error, log it |
| Add LangChain "to make it easier" | Raw SDK until Phase 2 |
| Assume Docker/SQL/git knowledge | Check `07_LEARNING_STATE.md` |
| Refactor everything while fixing one thing | Fix the one thing, mention the rest |
