-- =========================================================
-- 0005_helpers.sql
-- Helper functions used by RLS policies.
-- security definer + stable to avoid recursion through RLS.
-- =========================================================

create or replace function public.current_role()
returns user_role
language sql
stable
security definer
set search_path = public
as $$
  select role from public.profiles where id = auth.uid()
$$;

create or replace function public.is_admin()
returns boolean
language sql
stable
security definer
set search_path = public
as $$
  select coalesce(
    (select role = 'admin' from public.profiles where id = auth.uid()),
    false
  )
$$;

-- Các team mà user hiện tại làm leader
create or replace function public.led_team_ids()
returns setof uuid
language sql
stable
security definer
set search_path = public
as $$
  select team_id
    from public.team_members
   where user_id = auth.uid()
     and is_leader = true
$$;

-- Các team mà user hiện tại là thành viên (gồm cả leader)
create or replace function public.member_team_ids()
returns setof uuid
language sql
stable
security definer
set search_path = public
as $$
  select team_id from public.team_members where user_id = auth.uid()
$$;

-- Có quyền "thấy" user khác không
create or replace function public.can_see_user(target uuid)
returns boolean
language sql
stable
security definer
set search_path = public
as $$
  select
    target = auth.uid()
    or public.is_admin()
    or exists (
      select 1 from public.team_members tm
       where tm.user_id = target
         and tm.team_id in (select public.led_team_ids())
    )
$$;
