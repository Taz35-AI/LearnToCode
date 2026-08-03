-- Reimbursement Tracker — database schema
-- Run this once in the Supabase SQL Editor (Dashboard → SQL Editor → New query).

create table if not exists public.payments (
  id uuid primary key default gen_random_uuid(),
  date date not null,
  reference text not null default '',
  supplier text not null default '',
  description text not null default '',
  vat_rate numeric not null default 20,
  gross_pence bigint not null check (gross_pence >= 0),
  net_pence bigint not null check (net_pence >= 0),
  vat_pence bigint not null check (vat_pence >= 0),
  reimbursed boolean not null default false,
  reimbursed_date date,
  created_at timestamptz not null default now()
);

-- Row Level Security: only signed-in users can touch the data.
-- Anonymous visitors (anyone who finds the site URL) get nothing.
alter table public.payments enable row level security;

drop policy if exists "Authenticated can read payments" on public.payments;
create policy "Authenticated can read payments"
  on public.payments for select to authenticated using (true);

drop policy if exists "Authenticated can insert payments" on public.payments;
create policy "Authenticated can insert payments"
  on public.payments for insert to authenticated with check (true);

drop policy if exists "Authenticated can update payments" on public.payments;
create policy "Authenticated can update payments"
  on public.payments for update to authenticated using (true) with check (true);

drop policy if exists "Authenticated can delete payments" on public.payments;
create policy "Authenticated can delete payments"
  on public.payments for delete to authenticated using (true);

-- IMPORTANT — after running this:
-- 1. Create the login accounts in Dashboard → Authentication → Users →
--    "Add user" (tick "Auto Confirm User"). One for you, one for the boss.
-- 2. Disable public sign-ups in Dashboard → Authentication → Sign In / Up →
--    turn OFF "Allow new users to sign up", so only those accounts exist.
