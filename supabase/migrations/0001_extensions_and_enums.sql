-- =========================================================
-- 0001_extensions_and_enums.sql
-- Extensions and enums for CRM Kitabooks
-- =========================================================

create extension if not exists "pgcrypto";
create extension if not exists "citext";
create extension if not exists "pg_trgm";

-- 3 cấp role theo PRD §6
create type user_role     as enum ('admin', 'team_lead', 'sales');
create type team_type     as enum ('sales', 'marketing', 'support');
create type lead_status   as enum ('new', 'in_consult', 'callback', 'won', 'lost');
create type lead_source   as enum (
  'facebook_ads','google_ads','tiktok','kol','affiliate',
  'website_form','hotline','referral','walk_in'
);
create type task_type     as enum (
  'call','message','email','note','reminder',
  'meeting','quote','followup','procurement'
);
create type task_status   as enum ('open','done','cancelled');
create type activity_kind as enum (
  'login','logout','role_change','data_export',
  'delete','update','create','permission_change'
);
