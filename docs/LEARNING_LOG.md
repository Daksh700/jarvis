# LEARNING_LOG.md
**Append-only. Har session ke baad ek entry. Yahi build-in-public content hai.**

---

## Week 1, Session 1 — Aug 2026

Aaj shell ke basics kiye — teen quote types, stream redirection, exit codes, aur child/parent processes. Sabse interesting cheez: `cd` built-in isliye hai kyunki child process parent ki directory change kar hi nahi sakta. File permissions ka `rwx` system samjha — `chmod +x` se pehle script run hi nahi hoti thi. Pipeline bhi banaya: `find | grep | sort | uniq -c | head` se Desktop ke top file extensions nikale. Concept tha simple — har command ka output doosre ka input.

---

## Week 1, Session 2 — Aug 2026

Aaj 18 exercises complete kiye — xargs se samjha ki stdin lines ko arguments kaise bante hain, aur `-print0`/`-0` pair kyun zaruri hai spaces ke liye. curl se HTML fetch kiya aur grep se lectures count kiye. jq se JSON filter kiya. awk se columns swap kiye. Aur sabse satisfying — apni poori zsh_history pe pipeline chalaya: `cat | awk | sort | uniq -c | sort -rn | head` — nikla ki git 316 baar use kiya hai. Yeh sab alag tools hain but ek saath mile toh real kaam karte hain.

---

## Week 1, Session 3 — Aug 2026

L2 exercises khatam kiye. `--` ne sikhaaya ki flags aur arguments mein farak kaise bataate hain shell ko. Process substitution `<()` interesting tha — command ka output temporary file ban jaata hai, `diff` ko pata bhi nahi chalta. `marco`/`polo` se samjha ki bash functions mein global variables kaise kaam karte hain, aur `source` kyun zaroori tha. Sabse satisfying — flaky script wala: `while` loop ne 88 baar chalaya jab tak 42 nahi aaya. Poora concept ek saath kaam karta dikh gaya.

---

## Week 1 Complete — Aug 2026

`status.sh` ship kiya — Vionaut ka branch, uncommitted file count, aur last 5 commits ek script mein. Raste mein L1 aur L2 ke 18+18 exercises kiye. Sabse important cheez jo samajh aayi: child process parent ki state change nahi kar sakta — isliye `cd` built-in hai, isliye `marco`/`polo` ke liye `source` chahiye tha, isliye `wait` different session mein kaam nahi karta. Ek concept, teen jagah kaam aaya.

---

## Week 2, Session 1 — Aug 2026

Learn Git Branching ka Main sequence aur Push & Pull (Remote) section kiya. Sabse important cheez jo samajh aayi: Git ka data model — commits sirf pointers hain apne parent pe, branches sirf pointers hain commits pe. Kuch bhi copy nahi hota — sirf references move hote hain. `git branch -f main C6` ek line mein poori branch ko move kar deta hai bina checkout ke. Relative refs (`HEAD^`, `HEAD~3`) se navigate karna ab comfortable lagta hai.

---

## Week 2, Session 2 — Aug 2026

Scratch repo mein deliberately teen disasters kiye aur `reflog` se recover kiya. `reset --hard` se 3 commits gayab kiye — `reflog` ne sha diya, `reset --hard` se wapas aaye. Detached HEAD mein commit kiya, branch switch kiya — orphan commit gayab — `git branch recovered <sha>` se wapas laya. Rebase undo kiya — phir se reflog. Pattern har baar same tha: `git reflog` → sha dhundo → recover karo. Sabse important realization: `git log` sirf reachable commits dikhata hai, `reflog` HEAD ki poori movement history hai — kuch bhi permanently delete nahi hota jab tak git garbage collect na kare.

---

## Week 2 Complete — Aug 2026

`.gitignore` banaya jarvis repo mein — `.env` aur `.env.local` dono protected. `git status` se verify kiya ki `.env` untracked nahi dikh raha. Commit aur push kiya. Week 2 done: git ka data model samajh aaya, reflog se teen disasters recover kiye, aur repo ko secrets ke liye safe banaya.

---

## Week 3, Session 1 — Sep 2026

MDN HTTP guide padha — Overview, Messages, Methods, Status codes, Headers. HTTP stateless hai but cookies se sessions maintain hote hain. Request structure samjha — start line (method + path + version), headers, blank line, body. Response mein status code sabse important — 200 success, 401 unauthenticated, 403 authenticated but no permission, 404 not found, 429 rate limited, 500 server error. CORS samjha — browser ek origin ka JS doosre origin se data nahi maang sakta by default, server `Access-Control-Allow-Origin` header se allow karta hai.

---

## Week 3, Session 2 — Sep 2026

Vionaut staging endpoints curl kiye. `/health` aur `/api/rates` bina auth ke 200 diya — `ratelimit` header mein Arcjet ka kaam dikha (30 req/min). `/api/trips` aur `/api/search/cities` ne 401 diya — `x-clerk-auth-status: signed-out` header se samajh aaya ki Clerk reject kar raha hai. Phir Clerk secret se test user banaya, session banaya, JWT token nikala — us token se `/api/trips` aur `/api/user/me` hit kiye, 200 mila. Bearer token ka flow ab crystal clear hai: secret → user → session → JWT → Authorization header.

---

## Week 3 Complete — Sep 2026

DNS aur TLS bhi padha. DNS ka flow: browser → resolver (ISP) → root server → TLD → authoritative nameserver → IP. Glue records ne circular dependency solve kiya. TLS = encryption + authentication + data integrity. HTTPS = HTTP + TLS, port 443. Public/private key pair — public key se encrypt, private key se decrypt. Sabse valuable cheez: curl se apne hi Vionaut API ko hit kiya aur har header ka matlab samjha — rate limiting, auth status, content type — yeh sab ab real endpoints dekh ke samjha, sirf padhke nahi.

---

## Week 4, Session 1 — Sep/Oct 2026

SQLBolt ke lessons 1–18 kiye — SELECT, WHERE, ORDER BY, LIMIT/OFFSET, JOIN (INNER, LEFT, RIGHT, FULL), NULL handling (IS NULL / IS NOT NULL), aggregate functions (COUNT, SUM, AVG, MIN, MAX), GROUP BY, HAVING, subqueries, INSERT, UPDATE, DELETE, CREATE/ALTER/DROP TABLE, constraints (PRIMARY KEY, FOREIGN KEY, UNIQUE, NOT NULL). Lessons 18–19 (additional topics) skip kiye — woh optional extension tha. Sabse important concept: normalization — kyun alag tables mein data rakhte hain. JOIN ka mental model clear hua — ek common key pe do tables ko combine karo, ek bhi row miss nahi hoti INNER JOIN mein jab tak match ho.

---

## Week 4, Session 2 — Oct 2026

Select Star SQL ke 3 chapters kiye (Beazley, Claims of Innocence, The Long Tail) — real Texas execution dataset pe queries chalai. GROUP BY practically samjha — WHERE filter pehle chalta hai, GROUP BY baad mein grouping karta hai, HAVING aggregation ke baad filter karta hai. Nested queries samjhi — outer query mein inner query ka result use karo percentage calculate karne ke liye. Chapter 4 nahi kiya is session mein.

---

## Week 4 Complete — Oct 2026

TekPOS ke 3 real Prisma queries ko raw SQL mein convert kiya aur psql se local database pe chalaya (Postgres.app, `psql -U dakshgoel -d tekpos`). Query 1: simple SELECT with WHERE — 5 User rows mile (superadmin, owner, manager, cashier, chef). Query 2: INNER JOIN with Branch — Priya Nair ka branch "Koramangala" nikla. Query 3: Wastage + WastageItem JOIN — 1 row, expired chicken, 2.000 quantity, processed. Transaction ka purpose samjha: BEGIN → parent INSERT (RETURNING id) → children INSERT → COMMIT — agar beech mein fail ho toh ROLLBACK, orphan records nahi bante. `$transaction` isliye zaruri hai TekPOS mein — wastage aur wastage items ek saath ya dono nahi.