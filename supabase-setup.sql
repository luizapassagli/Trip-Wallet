-- ============================================================
-- Trip Wallet — Script de criação das tabelas no Supabase
-- Cole este conteúdo em: Supabase → SQL Editor → New query
-- ============================================================

-- Tabela de viagens
create table if not exists trips (
  id          text primary key,
  name        text not null,
  budget      numeric(10,2) not null,
  days        integer not null default 14,
  created_at  bigint not null,
  updated_at  bigint not null default extract(epoch from now()) * 1000
);

-- Tabela de gastos
create table if not exists expenses (
  id          text primary key,
  trip_id     text not null references trips(id) on delete cascade,
  amount      numeric(10,2) not null,
  category    text not null default 'other',
  note        text not null default '',
  ts          bigint not null,
  created_at  bigint not null default extract(epoch from now()) * 1000
);

-- Índices para busca rápida por viagem
create index if not exists expenses_trip_id_idx on expenses(trip_id);
create index if not exists expenses_ts_idx on expenses(ts desc);

-- Habilitar acesso público (RLS off para uso pessoal simples)
-- Se quiser adicionar autenticação depois, habilite RLS e crie policies
alter table trips    disable row level security;
alter table expenses disable row level security;
