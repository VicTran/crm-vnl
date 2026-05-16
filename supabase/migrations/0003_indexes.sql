-- =========================================================
-- 0003_indexes.sql
-- Indexes for hot paths and RLS predicates
-- =========================================================

-- profiles
create index profiles_role_idx   on public.profiles(role);
create index profiles_status_idx on public.profiles(status) where status = 'active';

-- team_members
create index team_members_user_idx   on public.team_members(user_id);
create index team_members_leader_idx on public.team_members(user_id) where is_leader;

-- leads
create index leads_owner_idx        on public.leads(owner_id);
create index leads_team_idx         on public.leads(team_id);
create index leads_status_idx       on public.leads(status);
create index leads_stage_idx        on public.leads(stage_id);
create index leads_next_action_idx  on public.leads(next_action_at)
  where status not in ('won','lost');
create index leads_phone_trgm_idx   on public.leads using gin (phone     gin_trgm_ops);
create index leads_name_trgm_idx    on public.leads using gin (full_name gin_trgm_ops);

-- tasks
create index tasks_assignee_idx on public.tasks(assignee_id);
create index tasks_team_idx     on public.tasks(team_id);
create index tasks_due_idx      on public.tasks(due_at) where status = 'open';
create index tasks_lead_idx     on public.tasks(lead_id);

-- lead_tag_map
create index lead_tag_map_tag_idx on public.lead_tag_map(tag_id);

-- lead_lists
create index lead_lists_owner_idx     on public.lead_lists(owner_id);
create index lead_lists_team_idx      on public.lead_lists(team_id) where is_shared;
create index lead_list_items_lead_idx on public.lead_list_items(lead_id);

-- subscriptions
create index subscriptions_list_idx on public.subscriptions(list_id);

-- activity_logs
create index activity_logs_actor_idx  on public.activity_logs(actor_id, created_at desc);
create index activity_logs_entity_idx on public.activity_logs(entity, entity_id);
create index activity_logs_time_idx   on public.activity_logs(created_at desc);
