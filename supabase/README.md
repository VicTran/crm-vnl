# Supabase — CRM Kitabooks

Thư mục này chứa toàn bộ schema, RLS policy và seed data cho hệ thống CRM Kitabooks giai đoạn 1.

## Cấu trúc

```
supabase/
├── migrations/
│   ├── 0001_extensions_and_enums.sql   Extensions + enums (role, status, source...)
│   ├── 0002_schema.sql                  10 bảng + FK + trigger updated_at
│   ├── 0003_indexes.sql                 Index cho RLS predicates + hot paths
│   ├── 0004_auth_triggers.sql           handle_new_user + handle_user_signin
│   ├── 0005_helpers.sql                 is_admin / led_team_ids / member_team_ids
│   └── 0006_rls_policies.sql            Tất cả RLS policy (3 cấp)
├── seed/
│   └── seed.sql                         Dữ liệu mẫu Kitabooks
└── README.md
```

## Chạy migrations

### Cách 1 — Supabase CLI (khuyến nghị)

```bash
# Trong thư mục project
supabase init                # nếu chưa có config.toml
supabase start               # local stack
supabase db reset            # apply toàn bộ migrations/
```

Supabase CLI sẽ chạy lần lượt các file trong `migrations/` theo thứ tự tên file.

### Cách 2 — psql trực tiếp (cloud)

```bash
psql "$DATABASE_URL" -f migrations/0001_extensions_and_enums.sql
psql "$DATABASE_URL" -f migrations/0002_schema.sql
psql "$DATABASE_URL" -f migrations/0003_indexes.sql
psql "$DATABASE_URL" -f migrations/0004_auth_triggers.sql
psql "$DATABASE_URL" -f migrations/0005_helpers.sql
psql "$DATABASE_URL" -f migrations/0006_rls_policies.sql
```

## Chuẩn bị Auth trước khi seed

PRD §10 yêu cầu Admin pre-provision tài khoản. Tạo trước 6 auth user qua **Supabase Dashboard → Authentication → Users → Add user**, hoặc dùng Admin API:

```ts
import { createClient } from '@supabase/supabase-js'

const supabaseAdmin = createClient(SUPABASE_URL, SERVICE_ROLE_KEY)

const users = [
  { email: 'admin@kitabook.vn',     password: 'TempPass!23' },
  { email: 'lead.hn@kitabook.vn',   password: 'TempPass!23' },
  { email: 'lead.hcm@kitabook.vn',  password: 'TempPass!23' },
  { email: 'son@kitabook.vn',       password: 'TempPass!23' },
  { email: 'ha@kitabook.vn',        password: 'TempPass!23' },
  { email: 'tuan@kitabook.vn',      password: 'TempPass!23' },
]
for (const u of users) {
  await supabaseAdmin.auth.admin.createUser({
    email: u.email, password: u.password, email_confirm: true
  })
}
```

Trigger `handle_new_user()` tự động tạo dòng `public.profiles` tương ứng (role mặc định `sales`).

Sau đó chạy seed:

```bash
psql "$DATABASE_URL" -f seed/seed.sql
```

Seed sẽ cập nhật role (`admin` / `team_lead` / `sales`), gán team, và đổ leads/tasks/lists.

## Cấu hình Auth quan trọng

Trong **Authentication → Providers / Settings** của Supabase Dashboard:

| Cài đặt | Giá trị | Lý do |
|---|---|---|
| Email provider | ON | Đăng nhập bằng email/password |
| Google provider | ON (dán Client ID/Secret) | Đăng nhập Google OAuth |
| Allow new users to sign up | **OFF** | Chỉ admin được tạo tài khoản (PRD §4.1) |
| Automatic account linking | **ON** | "1 email = 1 user" — Google identity tự link vào user có sẵn |
| JWT expiry | 12h | PRD §10.3 |
| Confirm email | ON (prod) | Bảo mật |

## Kiểm thử RLS

Mở SQL editor, giả lập một user:

```sql
-- Giả lập là Sơn (sales HN). Lấy UUID từ profiles trước.
select set_config('request.jwt.claims',
  json_build_object('sub', (select id::text from public.profiles where email='son@kitabook.vn'),
                    'role','authenticated')::text,
  true);

-- Sơn chỉ thấy lead của mình
select full_name, owner_id from public.leads;
-- Mong đợi: Mai Anh, Lê Hoàng Phương (do Sơn là owner)
```

Tương tự cho `lead.hn@kitabook.vn` (thấy toàn bộ team Sales HN) và `admin@kitabook.vn` (thấy tất).

## Sơ đồ quan hệ

```
auth.users (Supabase)
  └── 1:1 ── profiles ──┬── N:N ── teams           (via team_members)
                        ├── 1:N ── leads (owner_id)
                        ├── 1:N ── tasks (assignee_id, created_by)
                        ├── 1:N ── lead_lists (owner_id)
                        ├── 1:N ── subscriptions
                        └── 1:N ── activity_logs (actor_id)

teams ──┬── 1:N ── leads (team_id)
        ├── 1:N ── tasks (team_id)
        └── 1:N ── lead_lists (team_id)

pipeline_stages ── 1:N ── leads (stage_id)

leads ──┬── N:N ── lead_tags        (via lead_tag_map)
        ├── N:N ── lead_lists       (via lead_list_items)
        └── 1:N ── tasks (lead_id)

lead_lists ──┬── 1:N ── lead_list_items
             └── 1:N ── subscriptions
```

## Cơ chế phân quyền 3 cấp

| Cấp | Cách xác định | Quyền |
|---|---|---|
| **Admin** | `profiles.role = 'admin'` | Toàn bộ mọi bảng |
| **Team Lead** | `team_members.is_leader = true` | Bản ghi có `team_id ∈ led_team_ids()` |
| **Sales** | `profiles.role = 'sales'` | Bản ghi có `owner_id = auth.uid()` |

Mọi RLS policy đều tham chiếu 3 hàm helper: `is_admin()`, `led_team_ids()`, `member_team_ids()`. Đổi cơ chế chỉ cần sửa 3 hàm này.
