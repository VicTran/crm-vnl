-- =========================================================
-- 0004_auth_triggers.sql
-- Auto-create / link profile on auth signup; sync last_login
-- Enforces: 1 email = 1 user, regardless of provider
-- =========================================================

create or replace function public.handle_new_user()
returns trigger
language plpgsql
security definer
set search_path = public, auth
as $$
declare
  v_full_name text;
  v_avatar    text;
begin
  v_full_name := coalesce(
    new.raw_user_meta_data ->> 'full_name',
    new.raw_user_meta_data ->> 'name',
    split_part(new.email, '@', 1)
  );
  v_avatar := new.raw_user_meta_data ->> 'avatar_url';

  -- Nếu Admin đã pre-provision profile bằng email → reuse, gắn lại id
  -- Nếu chưa có → tạo mới với role mặc định 'sales'
  insert into public.profiles (id, email, full_name, avatar_url, role)
  values (new.id, new.email, v_full_name, v_avatar, 'sales')
  on conflict (email) do update
    set id         = excluded.id,
        full_name  = coalesce(public.profiles.full_name,  excluded.full_name),
        avatar_url = coalesce(public.profiles.avatar_url, excluded.avatar_url);

  return new;
end $$;

drop trigger if exists on_auth_user_created on auth.users;
create trigger on_auth_user_created
  after insert on auth.users
  for each row execute function public.handle_new_user();

-- Đồng bộ last_login_at khi user đăng nhập (auth.users.last_sign_in_at đổi)
create or replace function public.handle_user_signin()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  if new.last_sign_in_at is distinct from old.last_sign_in_at then
    update public.profiles
       set last_login_at = new.last_sign_in_at
     where id = new.id;
  end if;
  return new;
end $$;

drop trigger if exists on_auth_user_signin on auth.users;
create trigger on_auth_user_signin
  after update of last_sign_in_at on auth.users
  for each row execute function public.handle_user_signin();
