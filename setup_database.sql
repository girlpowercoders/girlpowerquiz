-- ============================================================
-- Girl Power Coders · Supabase Database Setup
-- Run this in: https://supabase.com/dashboard/project/jrjmkqzjloikdhhatrwa/sql/new
-- ============================================================

-- Quiz questions table
CREATE TABLE IF NOT EXISTS quiz_questions (
  id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  question text NOT NULL,
  option_a text NOT NULL,
  option_b text NOT NULL,
  option_c text NOT NULL,
  option_d text NOT NULL,
  correct_answer text NOT NULL CHECK (correct_answer IN ('a','b','c','d')),
  category text DEFAULT 'general',
  created_by text DEFAULT 'team',
  created_at timestamp with time zone DEFAULT now()
);

-- Quiz scores table
CREATE TABLE IF NOT EXISTS quiz_scores (
  id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  player_name text NOT NULL,
  score integer NOT NULL DEFAULT 0,
  total_questions integer NOT NULL DEFAULT 0,
  percentage numeric GENERATED ALWAYS AS (ROUND((score::numeric / NULLIF(total_questions,0)) * 100, 1)) STORED,
  played_at timestamp with time zone DEFAULT now()
);

-- Enable Row Level Security
ALTER TABLE quiz_questions ENABLE ROW LEVEL SECURITY;
ALTER TABLE quiz_scores ENABLE ROW LEVEL SECURITY;

-- Allow everyone to read and write (hackathon mode — open access)
CREATE POLICY "Allow all on quiz_questions" ON quiz_questions FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Allow all on quiz_scores" ON quiz_scores FOR ALL USING (true) WITH CHECK (true);

-- ── Starter Questions ──
INSERT INTO quiz_questions (question, option_a, option_b, option_c, option_d, correct_answer, category, created_by) VALUES
  ('What does AI stand for?',
   'Automated Internet', 'Artificial Intelligence', 'Advanced Interface', 'Artistic Imagination',
   'b', 'tech', 'team'),

  ('Which superhero uses a ring to create anything they imagine?',
   'Iron Man', 'Shuri', 'Green Lantern', 'Riri Williams',
   'c', 'superheroes', 'team'),

  ('What is a prompt?',
   'A type of code', 'Words you give to an AI', 'A website address', 'A database table',
   'b', 'tech', 'team'),

  ('Where is Elsie based?',
   'Middleton', 'New York', 'Gravesend', 'Manchester',
   'c', 'about-us', 'team'),

  ('What is the name of the Olatoye family coding event?',
   'Code Wars', 'Hack Day', 'Code Quest', 'Build Fest',
   'c', 'about-us', 'team'),

  ('Which character from Black Panther is known for building amazing tech?',
   'Okoye', 'Nakia', 'Shuri', 'Ramonda',
   'c', 'superheroes', 'team'),

  ('What do you call the place where your app lives on the internet?',
   'A database', 'Hosting', 'A prompt', 'A leaderboard',
   'b', 'tech', 'team'),

  ('What city is Hannah and Sophia based in?',
   'London', 'Gravesend', 'New York', 'Middleton',
   'd', 'about-us', 'team'),

  ('Riri Williams is known as which superhero?',
   'Storm', 'Ironheart', 'Shuri', 'Black Widow',
   'b', 'superheroes', 'team'),

  ('What is the hackathon prize?',
   'A trophy', 'Cash money', 'Bragging rights', 'A medal',
   'c', 'about-us', 'team')

ON CONFLICT DO NOTHING;

-- ── Verify setup ──
SELECT 'quiz_questions' as table_name, COUNT(*) as rows FROM quiz_questions
UNION ALL
SELECT 'quiz_scores', COUNT(*) FROM quiz_scores;
