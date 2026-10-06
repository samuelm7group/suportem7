-- ─────────────────────────────────────────────
-- M7 Service Desk — Checklist de itens na fila
-- Cole e execute no SQL Editor do Supabase
-- ─────────────────────────────────────────────
-- A fila pode ter uma lista de itens pré-cadastrados (ex: materiais).
-- Ao abrir o ticket, o usuário escolhe itens e quantidades.

-- Itens pré-cadastrados da fila: ["Papel A4", "Caneta", ...]
alter table queues  add column if not exists checklist_items jsonb default null;

-- Itens escolhidos no ticket: [{ "name":"Papel A4", "qty":5 }, ...]
alter table tickets add column if not exists checklist jsonb default '[]'::jsonb;
