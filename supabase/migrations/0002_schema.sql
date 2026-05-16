-- =========================================================
-- 0002_schema.sql
-- Tables, FKs and updated_at trigger
-- =========================================================

-- ---------- profiles ----------
create table public.profiles (
  id            uuid primary key references auth.users(id) on delete cascade,
  email         citext not null unique,
  full_name     text   not null,
  phone         text,
  role          user_role not null default 'sales',
  status        text   not null default 'active'
                check (status in ('active','suspended','left')),
  avatar_url    text,
  last_login_at timestamptz,
  created_at    timestamptz not null default now(),
  updated_at    timestamptz not null default now()
);
comment on table  public.profiles      is 'Hồ sơ chính 1-1 với auth.users. Role lưu ở đây.';
comment on column public.profiles.role is 'admin = toàn quyền; team_lead = trong nhóm; sales = chỉ data của mình';

-- ---------- teams ----------
create table public.teams (
  id          uuid primary key default gen_random_uuid(),
  name        text not null unique,
  type        team_type not null default 'sales',
  description text,
  created_at  timestamptz not null default now()
);

-- ---------- team_members (N-N) ----------
create table public.team_members (
  team_id   uuid not null references public.teams(id)    on delete cascade,
  user_id   uuid not null references public.profiles(id) on delete cascade,
  is_leader boolean not null default false,
  joined_at timestamptz not null default now(),
  primary key (team_id, user_id)
);
-- Mỗi team chỉ có tối đa 1 leader
create unique index team_members_one_leader_per_team
  on public.team_members(team_id) where is_leader = true;

-- ---------- pipeline_stages ----------
create table public.pipeline_stages (
  id          uuid primary key default gen_random_uuid(),
  code        text not null unique,
  name        text not null,
  sort_order  int  not null,
  is_terminal boolean not null default false,
  color       text
);

-- ---------- leads ----------
create table public.leads (
  id                  uuid primary key default gen_random_uuid(),
  full_name           text not null,
  phone               text,
  email               citext,
  company             text,
  segment             text,
  source              lead_source not null,
  campaign            text,
  interested_products text,
  estimated_value     numeric(14,2) default 0,
  status              lead_status not null default 'new',
  stage_id            uuid references public.pipeline_stages(id),
  owner_id            uuid not null references public.profiles(id) on delete restrict,
  team_id             uuid not null references public.teams(id)    on delete restrict,
  next_action_at      timestamptz,
  note                text,
  created_at          timestamptz not null default now(),
  updated_at          timestamptz not null default now()
);

-- ---------- lead_tags + map ----------
create table public.lead_tags (
  id         uuid primary key default gen_random_uuid(),
  name       text not null,
  tag_group  text not null check (tag_group in ('segment','genre','role','custom')),
  color      text,
  created_at timestamptz not null default now(),
  unique (tag_group, name)
);

create table public.lead_tag_map (
  lead_id uuid not null references public.leads(id)     on delete cascade,
  tag_id  uuid not null references public.lead_tags(id) on delete cascade,
  primary key (lead_id, tag_id)
);

-- ---------- lead_lists + items ----------
create table public.lead_lists (
  id          uuid primary key default gen_random_uuid(),
  name        text not null,
  description text,
  owner_id    uuid not null references public.profiles(id) on delete cascade,
  team_id     uuid          references public.teams(id)    on delete set null,
  is_shared   boolean not null default false,
  criteria    jsonb,
  created_at  timestamptz not null default now()
);

create table public.lead_list_items (
  list_id  uuid not null references public.lead_lists(id) on delete cascade,
  lead_id  uuid not null references public.leads(id)      on delete cascade,
  added_at timestamptz not null default now(),
  primary key (list_id, lead_id)
);

-- ---------- tasks ----------
create table public.tasks (
  id          uuid primary key default gen_random_uuid(),
  title       text not null,
  description text,
  type        task_type   not null,
  status      task_status not null default 'open',
  lead_id     uuid references public.leads(id) on delete set null,
  assignee_id uuid not null references public.profiles(id) on delete restrict,
  team_id     uuid not null references public.teams(id)    on delete restrict,
  created_by  uuid not null references public.profiles(id) on delete restrict,
  due_at      timestamptz,
  done_at     timestamptz,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);

-- ---------- subscriptions (user subscribe to lead_list) ----------
create table public.subscriptions (
  id         uuid primary key default gen_random_uuid(),
  user_id    uuid not null references public.profiles(id)   on delete cascade,
  list_id    uuid not null references public.lead_lists(id) on delete cascade,
  notify_on  text[] not null default '{lead_added,lead_status_changed}',
  created_at timestamptz not null default now(),
  unique (user_id, list_id)
);

-- ---------- activity_logs ----------
create table public.activity_logs (
  id         bigserial primary key,
  actor_id   uuid references public.profiles(id) on delete set null,
  team_id    uuid references public.teams(id)    on delete set null,
  kind       activity_kind not null,
  entity     text,
  entity_id  uuid,
  payload    jsonb,
  ip_address inet,
  user_agent text,
  created_at timestamptz not null default now()
);

-- ---------- updated_at trigger ----------
create or replace function public.touch_updated_at()
returns trigger language plpgsql as $$
begin
  new.updated_at := now();
  return new;
end $$;

create trigger trg_profiles_updated before update on public.profiles
  for each row execute function public.touch_updated_at();

create trigger trg_leads_updated before update on public.leads
  for each row execute function public.touch_updated_at();

create trigger trg_tasks_updated before update on public.tasks
  for each row execute function public.touch_updated_at();
