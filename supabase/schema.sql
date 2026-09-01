-- Fragancias LiMar: esquema base para catálogo y pedidos
create extension if not exists pgcrypto;

create table if not exists public.products (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  description text default '',
  category text not null default 'Perfumes',
  price numeric(12,2) not null default 0,
  stock integer not null default 0,
  image_url text default '',
  active boolean not null default true,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.orders (
  id uuid primary key default gen_random_uuid(),
  customer_name text not null,
  customer_phone text not null,
  delivery_address text not null,
  notes text default '',
  payment_method text not null default 'contra_entrega',
  status text not null default 'pendiente',
  total numeric(12,2) not null default 0,
  created_at timestamptz not null default now()
);

create table if not exists public.order_items (
  id uuid primary key default gen_random_uuid(),
  order_id uuid not null references public.orders(id) on delete cascade,
  product_id uuid references public.products(id) on delete set null,
  product_name text not null,
  unit_price numeric(12,2) not null,
  quantity integer not null check (quantity > 0),
  subtotal numeric(12,2) not null
);

alter table public.products enable row level security;
alter table public.orders enable row level security;
alter table public.order_items enable row level security;

drop policy if exists products_public_read on public.products;
create policy products_public_read on public.products
  for select using (active = true);

drop policy if exists orders_public_insert on public.orders;
create policy orders_public_insert on public.orders
  for insert with check (payment_method = 'contra_entrega');

drop policy if exists order_items_public_insert on public.order_items;
create policy order_items_public_insert on public.order_items
  for insert with check (true);

create index if not exists products_active_idx on public.products(active);
create index if not exists orders_status_idx on public.orders(status);
