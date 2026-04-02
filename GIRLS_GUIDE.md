# 💗 Girl Power Coders — Build Guide & Integration Docs

> **Olatoye Academy Code Quest 2026 · Hackathon: Saturday 4th April, 6:30pm**
> Team: Elsie (Gravesend) · Hannah (Middleton) · Sophia (Middleton)

---

## 🗂️ Your Project at a Glance

| Thing | Detail |
|---|---|
| 🌐 Live Site | https://girlpowercoders.github.io/girlpowerquiz/ |
| 📦 GitHub Repo | https://github.com/girlpowercoders/girlpowerquiz |
| 🗄️ Supabase Project | https://jrjmkqzjloikdhhatrwa.supabase.co |
| 🔑 Supabase Anon Key | `eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Impyam1rcXpqbG9pa2RoaGF0cndhIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzUwODAyOTEsImV4cCI6MjA5MDY1NjI5MX0.0TYBifEH3uSUMBnrF_Gtu9PJ9KLv20XXZYI_UQ0hf8s` |
| 🤖 AI Tool | https://claude.ai |
| 📅 Hackathon Date | Saturday 4th April 2026 at 6:30pm |

---

## 🗄️ Database Setup (Run This First!)

Go to your Supabase SQL Editor:
**https://supabase.com/dashboard/project/jrjmkqzjloikdhhatrwa/sql/new**

Paste and run the SQL from `setup_database.sql` in this repo. It will create:
- `quiz_questions` — stores all your quiz questions
- `quiz_scores` — saves everyone's scores when they play

It also loads 5 starter questions to get you going.

---

## 📁 File Structure

```
girlpowerquiz/
├── index.html          ← Your main webpage (team homepage)
├── quiz.html           ← Your quiz game (build this with Claude!)
├── GIRLS_GUIDE.md      ← This file
├── setup_database.sql  ← Run this in Supabase to set up the DB
└── README.md
```

---

## 🧠 Database Tables Explained

### `quiz_questions`
Stores every question in your quiz.

| Column | What it is |
|---|---|
| `id` | Unique ID (auto-generated) |
| `question` | The question text |
| `option_a` | Answer choice A |
| `option_b` | Answer choice B |
| `option_c` | Answer choice C |
| `option_d` | Answer choice D |
| `correct_answer` | Which letter is correct: `a`, `b`, `c`, or `d` |
| `category` | Topic e.g. `superheroes`, `tech`, `about-us` |
| `created_by` | Who added it e.g. `elsie`, `hannah`, `sophia` |

### `quiz_scores`
Saves a score every time someone finishes the quiz.

| Column | What it is |
|---|---|
| `id` | Unique ID (auto-generated) |
| `player_name` | Name of the person who played |
| `score` | How many they got right |
| `total_questions` | How many questions were in the quiz |
| `percentage` | Auto-calculated score % |
| `played_at` | When they played |

---

## 🔌 Connecting Your Quiz to the Database

Copy this JavaScript snippet into your `quiz.html`. It handles everything — loading questions and saving scores.

```html
<script>
  const SUPABASE_URL = 'https://jrjmkqzjloikdhhatrwa.supabase.co';
  const SUPABASE_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Impyam1rcXpqbG9pa2RoaGF0cndhIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzUwODAyOTEsImV4cCI6MjA5MDY1NjI5MX0.0TYBifEH3uSUMBnrF_Gtu9PJ9KLv20XXZYI_UQ0hf8s';

  // ── Load questions from the database ──
  async function loadQuestions() {
    const res = await fetch(`${SUPABASE_URL}/rest/v1/quiz_questions?select=*&order=random()&limit=10`, {
      headers: {
        'apikey': SUPABASE_KEY,
        'Authorization': `Bearer ${SUPABASE_KEY}`
      }
    });
    const questions = await res.json();
    return questions;
  }

  // ── Save a score to the database ──
  async function saveScore(playerName, score, totalQuestions) {
    await fetch(`${SUPABASE_URL}/rest/v1/quiz_scores`, {
      method: 'POST',
      headers: {
        'apikey': SUPABASE_KEY,
        'Authorization': `Bearer ${SUPABASE_KEY}`,
        'Content-Type': 'application/json',
        'Prefer': 'return=minimal'
      },
      body: JSON.stringify({ player_name: playerName, score, total_questions: totalQuestions })
    });
  }

  // ── Load the leaderboard ──
  async function loadLeaderboard() {
    const res = await fetch(`${SUPABASE_URL}/rest/v1/quiz_scores?select=*&order=score.desc&limit=10`, {
      headers: {
        'apikey': SUPABASE_KEY,
        'Authorization': `Bearer ${SUPABASE_KEY}`
      }
    });
    const scores = await res.json();
    return scores;
  }
</script>
```

---

## ➕ Adding Your Own Questions

### Option 1 — Via Supabase Dashboard (easiest)
1. Go to **https://supabase.com/dashboard/project/jrjmkqzjloikdhhatrwa/editor**
2. Click `quiz_questions` table
3. Click **Insert row**
4. Fill in your question, 4 options, and the correct answer letter

### Option 2 — Ask Claude to add them for you!
Tell Claude:

> *"Add these questions to my Supabase database. The Supabase URL is `https://jrjmkqzjloikdhhatrwa.supabase.co`, the anon key is `eyJ...` (see GIRLS_GUIDE.md). Here are my questions: [paste your questions]"*

### Option 3 — Via SQL
Go to the SQL editor and run:
```sql
INSERT INTO quiz_questions (question, option_a, option_b, option_c, option_d, correct_answer, category, created_by)
VALUES ('Your question here?', 'Option A', 'Option B', 'Option C', 'Option D', 'b', 'general', 'elsie');
```

---

## 🚀 How to Publish Changes to Your Live Site

Every time you update your code with Claude, you need to push it to GitHub so the live site updates.

**Tell Claude exactly this:**
> *"Push my updated index.html (or quiz.html) to GitHub. The repo is `https://github.com/girlpowercoders/girlpowerquiz`, the token is `ASK_UNCLE_B_FOR_GITHUB_TOKEN`, the branch is `main`."*

Claude will do the rest. The site updates within about 60 seconds of pushing.

---

## 🤖 Prompting Claude — Tips for the Girls

### Building your quiz page
> *"Build me a fun, girly quiz game webpage. It should load questions from Supabase, show 4 answer buttons for each question, tell me if I'm right or wrong, and show my final score at the end with a leaderboard. Use these colours: rose pink `#FF3D8A`, violet `#8B2FC9`, gold `#FFD166`. Make it fun and animated!"*

### Customising your homepage
> *"Update my Girl Power Coders homepage. In the Elsie card, add that my favourite things are [your list]. In the Hannah card, add [Hannah's list]. Make the music section say we love [your artists]."*

### Adding a new section
> *"Add a new section to my webpage called 'Our Superpowers' with three cards — one for each team member — describing what superpower each of us would have."*

### Fixing something
> *"The quiz isn't loading questions. Here is my code: [paste code]. The Supabase URL is `https://jrjmkqzjloikdhhatrwa.supabase.co` and the anon key is in GIRLS_GUIDE.md. Please fix the loadQuestions function."*

---

## 🎨 Your Design System (keep it consistent!)

```css
--rose:    #FF3D8A;   /* main pink — buttons, highlights */
--violet:  #8B2FC9;   /* purple — gradients, accents */
--gold:    #FFD166;   /* gold — badges, special text */
--mint:    #06D6A0;   /* green — success states */
--deep:    #0D0618;   /* dark background */
```

Fonts: **Playfair Display** (headings) + **DM Sans** (body text)

---

## 📋 Hackathon Day Checklist ✅

- [ ] Homepage personalised — all three girls' info filled in
- [ ] Quiz game built and working
- [ ] At least 10 questions in the database
- [ ] Leaderboard showing scores
- [ ] Live site tested and working on phone + laptop
- [ ] Team name displayed on the page
- [ ] Ready to demo to the family at 6:30pm on 4th April!

---

## 🆘 If Something Breaks

1. **Quiz not loading?** — Check the Supabase URL and anon key are pasted correctly
2. **Site not updating?** — Wait 60 seconds after pushing, then hard refresh (Ctrl+Shift+R)
3. **Can't push to GitHub?** — Make sure you're using the token in this guide
4. **Ask Uncle B!** — He built the whole Code Quest app with the same tools 💪

---

*Built with 💗 by Girl Power Coders · Olatoye Academy Code Quest 2026*
