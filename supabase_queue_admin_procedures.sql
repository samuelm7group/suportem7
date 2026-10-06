-- ═══════════════════════════════════════════════════════════════
-- M7 Service Desk — Agente admin de filas + Procedimentos
-- Cole e execute TUDO no SQL Editor do Supabase
-- ═══════════════════════════════════════════════════════════════

-- 1. Flag: agente também administra as próprias filas
alter table users add column if not exists queue_admin boolean default false;

-- 2. Tabela de Procedimentos (intranet por área)
create table if not exists procedures (
  id          text primary key,
  title       text not null,
  description text,
  area_id     text,                 -- área a que pertence (null = geral)
  file        jsonb,                -- { name, url, type, size }
  created_by  text,
  created_at  timestamptz default now()
);
alter table procedures enable row level security;
do $$ begin
  if not exists (select 1 from pg_policies where tablename='procedures' and policyname='allow_all_procedures') then
    create policy "allow_all_procedures" on procedures for all using (true) with check (true);
  end if;
end $$;
