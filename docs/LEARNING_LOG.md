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

`.gitignore` banaya jarvis repo mein — `.env` aur `.env.local` dono protected. `git status` se verify kiya ki `.env` untracked nahi dikh raha. Commit aur push kiya. Yeh ek baar sahi karo toh phir secrets commit hone ka risk nahi — R17 (never push secrets) ab code mein enforce ho gayi. Week 2 done: git ka data model samajh aaya, reflog se teen disasters recover kiye, aur repo ko secrets ke liye safe banaya.