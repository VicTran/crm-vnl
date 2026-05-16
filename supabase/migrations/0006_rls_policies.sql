-- =========================================================
-- 0006_rls_policies.sql
-- Row Level Security: 3-tier (admin / team_lead / sales)
-- =========================================================

alter table public.profiles         enable row level security;
alter table public.teams            enable row level security;
alter table public.team_members     enable row level security;
alter table public.pipeline_stages  enable row level security;
alter table public.leads            enable row level security;
alter table public.lead_tags        enable row level security;
alter table public.lead_tag_map     enable row level security;
alter table public.lead_lists       enable row level security;
alter table public.lead_list_items  enable row level security;
alter table public.tasks            enable row level security;
alter table public.subscriptions    enable row level security;
alter table public.activity_logs    enable row level security;

-- =====================================================
-- profiles
-- =====================================================
create policy profiles_select on public.profiles
for select to authenticated
using ( public.can_see_user(id) );

-- User tự cập nhật thông tin cá nhân, KHÔNG được tự đổi role / status
create policy profiles_self_update on public.profiles
for update to authenticated
using ( id = auth.uid() )
with check (
  id = auth.uid()
  and role   = (select role   from public.profiles where id = auth.uid())
  and status = (select status from public.profiles where id = auth.uid())
);

-- Admin toàn quyền
create policy profiles_admin_all on public.profiles
for all to authenticated
using      ( public.is_admin() )
with check ( public.is_admin() );

-- KHÔNG cấp INSERT cho client. Profile chỉ được tạo qua trigger handle_new_user.

-- =====================================================
-- teams
-- =====================================================
create policy teams_select on public.teams
for select to authenticated
using (
  public.is_admin()
  or id in (select public.member_team_ids())
);

create policy teams_admin_write on public.teams
for all to authenticated
using      ( public.is_admin() )
with check ( public.is_admin() );

-- =====================================================
-- team_members
-- =====================================================
create policy team_members_select on public.team_members
for select to authenticated
using (
  public.is_admin()
  or user_id = auth.uid()
  or team_id in (select public.led_team_ids())
);

create policy team_members_admin_write on public.team_members
for all to authenticated
using      ( public.is_admin() )
with check ( public.is_admin() );

-- =====================================================
-- pipeline_stages (config)
-- =====================================================
create policy pipeline_select on public.pipeline_stages
for select to authenticated
using ( true );

create policy pipeline_admin_write on public.pipeline_stages
for all to authenticated
using      ( public.is_admin() )
with check ( public.is_admin() );

-- =====================================================
-- leads — 3-tier core
-- =====================================================
create policy leads_select on public.leads
for select to authenticated
using (
  public.is_admin()
  or owner_id = auth.uid()
  or team_id in (select public.led_team_ids())
);

create policy leads_insert on public.leads
for insert to authenticated
with check (
  public.is_admin()
  or (
    owner_id = auth.uid()
    and team_id in (select public.member_team_ids())
  )
);

create policy leads_update on public.leads
for update to authenticated
using (
  public.is_admin()
  or owner_id = auth.uid()
  or team_id in (select public.led_team_ids())
)
with check (
  public.is_admin()
  or owner_id = auth.uid()
  or team_id in (select public.led_team_ids())
);

create policy leads_delete on public.leads
for delete to authenticated
using (
  public.is_admin()
  or team_id in (select public.led_team_ids())
);

-- =====================================================
-- lead_tags (catalog)
-- =====================================================
create policy lead_tags_select on public.lead_tags
for select to authenticated
using ( true );

create policy lead_tags_manage on public.lead_tags
for all to authenticated
using      ( public.is_admin() or public.current_role() = 'team_lead' )
with check ( public.is_admin() or public.current_role() = 'team_lead' );

-- =====================================================
-- lead_tag_map: theo quyền của lead tương ứng
-- =====================================================
create policy lead_tag_map_select on public.lead_tag_map
for select to authenticated
using (
  exists (select 1 from public.leads l where l.id = lead_id)
);

create policy lead_tag_map_write on public.lead_tag_map
for all to authenticated
using (
  exists (
    select 1 from public.leads l
     where l.id = lead_id
       and (
         public.is_admin()
         or l.owner_id = auth.uid()
         or l.team_id in (select public.led_team_ids())
       )
  )
)
with check (
  exists (
    select 1 from public.leads l
     where l.id = lead_id
       and (
         public.is_admin()
         or l.owner_id = auth.uid()
         or l.team_id in (select public.led_team_ids())
       )
  )
);

-- =====================================================
-- lead_lists
-- =====================================================
create policy lead_lists_select on public.lead_lists
for select to authenticated
using (
  public.is_admin()
  or owner_id = auth.uid()
  or team_id in (select public.led_team_ids())
  or (is_shared and team_id in (select public.member_team_ids()))
);

create policy lead_lists_insert on public.lead_lists
for insert to authenticated
with check (
  public.is_admin()
  or (
    owner_id = auth.uid()
    and (team_id is null or team_id in (select public.member_team_ids()))
  )
);

create policy lead_lists_update on public.lead_lists
for update to authenticated
using (
  public.is_admin()
  or owner_id = auth.uid()
  or team_id in (select public.led_team_ids())
)
with check (
  public.is_admin()
  or owner_id = auth.uid()
  or team_id in (select public.led_team_ids())
);

create policy lead_lists_delete on public.lead_lists
for delete to authenticated
using (
  public.is_admin()
  or owner_id = auth.uid()
  or team_id in (select public.led_team_ids())
);

-- =====================================================
-- lead_list_items
-- =====================================================
create policy lead_list_items_select on public.lead_list_items
for select to authenticated
using (
  exists (select 1 from public.lead_lists ll where ll.id = list_id)
  and exists (select 1 from public.leads l where l.id = lead_id)
);

create policy lead_list_items_write on public.lead_list_items
for all to authenticated
using (
  exists (
    select 1 from public.lead_lists ll
     where ll.id = list_id
       and (
         public.is_admin()
         or ll.owner_id = auth.uid()
         or ll.team_id in (select public.led_team_ids())
       )
  )
)
with check (
  exists (
    select 1 from public.lead_lists ll
     where ll.id = list_id
       and (
         public.is_admin()
         or ll.owner_id = auth.uid()
         or ll.team_id in (select public.led_team_ids())
       )
  )
);

-- =====================================================
-- tasks
-- =====================================================
create policy tasks_select on public.tasks
for select to authenticated
using (
  public.is_admin()
  or assignee_id = auth.uid()
  or created_by  = auth.uid()
  or team_id in (select public.led_team_ids())
);

-- Sales tự tạo việc cho mình; leader giao việc cho thành viên trong team
create policy tasks_insert on public.tasks
for insert to authenticated
with check (
  public.is_admin()
  or (
    created_by = auth.uid()
    and (
      assignee_id = auth.uid()
      or (
        team_id in (select public.led_team_ids())
        and exists (
          select 1 from public.team_members tm
           where tm.team_id = tasks.team_id
             and tm.user_id = tasks.assignee_id
        )
      )
    )
  )
);

create policy tasks_update on public.tasks
for update to authenticated
using (
  public.is_admin()
  or assignee_id = auth.uid()
  or team_id in (select public.led_team_ids())
)
with check (
  public.is_admin()
  or assignee_id = auth.uid()
  or team_id in (select public.led_team_ids())
);

create policy tasks_delete on public.tasks
for delete to authenticated
using (
  public.is_admin()
  or team_id in (select public.led_team_ids())
);

-- =====================================================
-- subscriptions (mỗi user chỉ thao tác sub của mình)
-- =====================================================
create policy subscriptions_select on public.subscriptions
for select to authenticated
using ( user_id = auth.uid() or public.is_admin() );

create policy subscriptions_write on public.subscriptions
for all to authenticated
using      ( user_id = auth.uid() )
with check ( user_id = auth.uid() );

-- =====================================================
-- activity_logs (immutable)
-- =====================================================
create policy activity_logs_select on public.activity_logs
for select to authenticated
using (
  public.is_admin()
  or actor_id = auth.uid()
  or team_id in (select public.led_team_ids())
);

create policy activity_logs_insert on public.activity_logs
for insert to authenticated
with check ( actor_id = auth.uid() );

-- KHÔNG cấp UPDATE / DELETE: log bất biến.
