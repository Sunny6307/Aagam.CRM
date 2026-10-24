-- AAGAM Stainless CRM: Supabase PostgreSQL schema
-- Run this SQL in Supabase SQL Editor before using index.html.
create extension if not exists pgcrypto;

create table if not exists public.customers (
  id uuid primary key default gen_random_uuid(),
  party_name text not null,
  contact_person text,
  address text,
  state text,
  email text,
  phone_number text,
  item text,
  grade text,
  sizes text,
  current_supplier text,
  created_by uuid not null references auth.users(id) on delete restrict,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.calls (
  id uuid primary key default gen_random_uuid(),
  customer_id uuid not null references public.customers(id) on delete cascade,
  call_date date not null default current_date,
  call_status text not null default 'Answered',
  interest text not null default 'Pending',
  quotation_sent text not null default 'No',
  follow_up_date date,
  next_action text,
  caller_name text,
  remarks text,
  created_by uuid not null references auth.users(id) on delete restrict,
  created_at timestamptz not null default now()
);

create index if not exists customers_party_name_idx on public.customers (party_name);
create index if not exists customers_phone_idx on public.customers (phone_number);
create index if not exists calls_call_date_idx on public.calls (call_date);
create index if not exists calls_follow_up_date_idx on public.calls (follow_up_date);
create index if not exists calls_customer_id_idx on public.calls (customer_id);

alter table public.customers enable row level security;
alter table public.calls enable row level security;

-- Initial team model: authenticated users in the same CRM can read/write shared records.
-- Add role-based restrictions before production if callers should see only assigned leads.
create policy "authenticated team can read customers" on public.customers
for select to authenticated using (true);
create policy "authenticated team can add customers" on public.customers
for insert to authenticated with check (auth.uid() = created_by);
create policy "authenticated team can update customers" on public.customers
for update to authenticated using (true) with check (true);
create policy "authenticated team can delete customers" on public.customers
for delete to authenticated using (true);

create policy "authenticated team can read calls" on public.calls
for select to authenticated using (true);
create policy "authenticated team can add calls" on public.calls
for insert to authenticated with check (auth.uid() = created_by);
create policy "authenticated team can update calls" on public.calls
for update to authenticated using (true) with check (true);
create policy "authenticated team can delete calls" on public.calls
for delete to authenticated using (true);
