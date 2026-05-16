-- =========================================================
-- seed.sql — Dữ liệu mẫu Kitabooks
--
-- YÊU CẦU TRƯỚC KHI CHẠY:
--   Tạo 6 auth user qua Supabase Dashboard (Authentication → Users)
--   hoặc dùng supabase.auth.admin.createUser() với các email sau:
--
--     admin@kitabook.vn        (sẽ là admin)
--     lead.hn@kitabook.vn      (Trưởng nhóm Sales Hà Nội)
--     lead.hcm@kitabook.vn     (Trưởng nhóm Sales TP.HCM)
--     son@kitabook.vn          (Sales HN — Nguyễn Văn Sơn)
--     ha@kitabook.vn           (Sales HN — Lê Thị Hà)
--     tuan@kitabook.vn         (Sales HCM — Trần Minh Tuấn)
--
-- Trigger handle_new_user() đã tự tạo các dòng public.profiles.
-- File này sẽ:
--   1) Seed pipeline_stages, teams, lead_tags
--   2) Update role + tên đầy đủ vào profiles
--   3) Insert team_members
--   4) Insert leads, lead_tag_map, lead_lists, tasks, subscriptions
-- =========================================================

-- ---------- Pipeline stages ----------
insert into public.pipeline_stages (code, name, sort_order, is_terminal, color) values
  ('new',        'Mới',          1, false, '#EDE6D6'),
  ('in_consult', 'Đang tư vấn',  2, false, '#F7EBC9'),
  ('callback',   'Cần gọi lại',  3, false, '#D4A24A'),
  ('won',        'Đã chốt',      4, true,  '#7A9A6E'),
  ('lost',       'Đã huỷ',       5, true,  '#B5563C');

-- ---------- Teams ----------
insert into public.teams (id, name, type, description) values
  ('11111111-1111-1111-1111-111111111111','Sales Hà Nội',         'sales',    'Đội kinh doanh khu vực miền Bắc'),
  ('22222222-2222-2222-2222-222222222222','Sales TP.HCM',         'sales',    'Đội kinh doanh khu vực miền Nam'),
  ('33333333-3333-3333-3333-333333333333','Marketing Performance','marketing','Đội chạy quảng cáo FB / Google / TikTok');

-- ---------- Lead tags ----------
insert into public.lead_tags (name, tag_group, color) values
  ('VIP',                  'segment','#C8881C'),
  ('Doanh nghiệp',         'segment','#3A2E1F'),
  ('Đại lý sỉ',            'segment','#6B5A45'),
  ('Phụ huynh',            'role',   '#A89980'),
  ('Khách cá nhân',        'role',   '#A89980'),
  ('Văn học kinh điển',    'genre',  '#7A9A6E'),
  ('Thiếu nhi',            'genre',  '#E8C77A'),
  ('Kỹ năng sống',         'genre',  '#D4A24A'),
  ('Kinh tế - Kinh doanh', 'genre',  '#3A2E1F'),
  ('Giáo trình',           'genre',  '#6B5A45');

-- ---------- Profiles: cập nhật role + tên ----------
update public.profiles set role='admin',     full_name='Giám đốc Kitabooks', phone='0901000001' where email='admin@kitabook.vn';
update public.profiles set role='team_lead', full_name='Phạm Thanh Hằng',    phone='0901000002' where email='lead.hn@kitabook.vn';
update public.profiles set role='team_lead', full_name='Đỗ Quang Vinh',      phone='0901000003' where email='lead.hcm@kitabook.vn';
update public.profiles set role='sales',     full_name='Nguyễn Văn Sơn',     phone='0901000004' where email='son@kitabook.vn';
update public.profiles set role='sales',     full_name='Lê Thị Hà',          phone='0901000005' where email='ha@kitabook.vn';
update public.profiles set role='sales',     full_name='Trần Minh Tuấn',     phone='0901000006' where email='tuan@kitabook.vn';

-- ---------- Team members ----------
insert into public.team_members (team_id, user_id, is_leader)
select '11111111-1111-1111-1111-111111111111', id, true  from public.profiles where email='lead.hn@kitabook.vn'
union all select '11111111-1111-1111-1111-111111111111', id, false from public.profiles where email='son@kitabook.vn'
union all select '11111111-1111-1111-1111-111111111111', id, false from public.profiles where email='ha@kitabook.vn'
union all select '22222222-2222-2222-2222-222222222222', id, true  from public.profiles where email='lead.hcm@kitabook.vn'
union all select '22222222-2222-2222-2222-222222222222', id, false from public.profiles where email='tuan@kitabook.vn';

-- ---------- Leads (6 lead — DesignBrief §5.1) ----------
with
  son  as (select id from public.profiles where email='son@kitabook.vn'),
  ha   as (select id from public.profiles where email='ha@kitabook.vn'),
  tuan as (select id from public.profiles where email='tuan@kitabook.vn'),
  s_new      as (select id from public.pipeline_stages where code='new'),
  s_consult  as (select id from public.pipeline_stages where code='in_consult'),
  s_callback as (select id from public.pipeline_stages where code='callback'),
  s_won      as (select id from public.pipeline_stages where code='won')
insert into public.leads
  (full_name, phone, email, company, segment, source, campaign,
   interested_products, estimated_value, status, stage_id, owner_id, team_id, next_action_at)
values
  ('Nguyễn Thị Mai Anh','0912000001','maianh@vinschool.edu.vn','Trường Quốc tế Vinschool',
   'Doanh nghiệp - Giáo dục','referral','Q3-Education-Combo',
   'Combo 300 cuốn sách kỹ năng sống cho học sinh THCS', 165000000, 'in_consult',
   (select id from s_consult), (select id from son), '11111111-1111-1111-1111-111111111111',
   now() + interval '2 day'),

  ('Trần Quang Huy','0912000002','huy.tq@fpt.com.vn','Công ty Cổ phần FPT',
   'Doanh nghiệp - Quà tặng','kol','Tet-Gift-2026',
   '500 cuốn "Tư duy nhanh và chậm" làm quà tặng nhân viên', 245000000, 'new',
   (select id from s_new), (select id from ha), '11111111-1111-1111-1111-111111111111',
   now() + interval '1 day'),

  ('Lê Hoàng Phương','0912000003','phuong.lh@techcombank.com.vn','Ngân hàng TMCP Techcombank',
   'Doanh nghiệp - Đào tạo','referral','HBR-Leadership-2026',
   'Combo sách lãnh đạo Harvard Business Review (150 bộ)', 412500000, 'callback',
   (select id from s_callback), (select id from son), '11111111-1111-1111-1111-111111111111',
   now() + interval '3 day'),

  ('Phạm Minh Khoa','0912000004','khoa.pm@phuongnam.com.vn','Hệ thống Nhà sách Phương Nam',
   'Đại lý sỉ','hotline','Back-to-School-2026',
   'Đặt sỉ 1.200 cuốn sách thiếu nhi cho mùa khai giảng', 96000000, 'in_consult',
   (select id from s_consult), (select id from tuan), '22222222-2222-2222-2222-222222222222',
   now() + interval '5 day'),

  ('Đỗ Thị Thu Hằng','0912000005','hang.dtt@vinuni.edu.vn','Tập đoàn Vingroup - VinUni',
   'Doanh nghiệp - Giáo dục','website_form','VinUni-Library',
   'Sách giáo trình kinh tế bản quyền cho thư viện trường', 580000000, 'new',
   (select id from s_new), (select id from tuan), '22222222-2222-2222-2222-222222222222',
   now() + interval '2 day'),

  ('Vũ Tiến Đạt','0912000006','dat.vt@gmail.com','Cá nhân - Phụ huynh học sinh Ams',
   'Cá nhân - VIP','facebook_ads','Ams-Combo-2026',
   'Combo sách luyện thi chuyên Anh + sách văn học kinh điển', 8400000, 'won',
   (select id from s_won), (select id from ha), '11111111-1111-1111-1111-111111111111',
   null);

-- ---------- lead_tag_map ----------
insert into public.lead_tag_map (lead_id, tag_id)
select l.id, t.id from public.leads l, public.lead_tags t
 where (l.full_name='Nguyễn Thị Mai Anh' and t.name in ('Doanh nghiệp','Kỹ năng sống'))
    or (l.full_name='Trần Quang Huy'     and t.name in ('Doanh nghiệp','Kinh tế - Kinh doanh'))
    or (l.full_name='Lê Hoàng Phương'    and t.name in ('Doanh nghiệp','Kinh tế - Kinh doanh','VIP'))
    or (l.full_name='Phạm Minh Khoa'     and t.name in ('Đại lý sỉ','Thiếu nhi'))
    or (l.full_name='Đỗ Thị Thu Hằng'    and t.name in ('Doanh nghiệp','Giáo trình'))
    or (l.full_name='Vũ Tiến Đạt'        and t.name in ('VIP','Phụ huynh','Văn học kinh điển'));

-- ---------- Lead lists (3 list — DesignBrief §5.3) ----------
insert into public.lead_lists (id, name, description, owner_id, team_id, is_shared, criteria)
select
  '44444444-4444-4444-4444-444444444401',
  'VIP Doanh nghiệp Quý 3',
  'KH doanh nghiệp có đơn ≥ 100tr trong 90 ngày, hoặc đã ký hợp đồng định kỳ.',
  p.id, '11111111-1111-1111-1111-111111111111', true,
  '{"segment":["Doanh nghiệp"],"min_order_value":100000000,"window_days":90}'::jsonb
from public.profiles p where p.email='lead.hn@kitabook.vn'
union all
select
  '44444444-4444-4444-4444-444444444402',
  'Phụ huynh học sinh - Mùa khai giảng',
  'Tag Phụ huynh + đã mua sách thiếu nhi/học thuật trong 12 tháng.',
  p.id, '33333333-3333-3333-3333-333333333333', true,
  '{"tags":["Phụ huynh"],"genres":["Thiếu nhi","Giáo trình"],"window_months":12}'::jsonb
from public.profiles p where p.email='admin@kitabook.vn'
union all
select
  '44444444-4444-4444-4444-444444444403',
  'Độc giả Văn học Kinh điển',
  '≥ 2 đầu sách thể loại "Văn học kinh điển" hoặc "Văn học VN".',
  p.id, '22222222-2222-2222-2222-222222222222', true,
  '{"genres":["Văn học kinh điển"],"min_book_count":2}'::jsonb
from public.profiles p where p.email='lead.hcm@kitabook.vn';

-- ---------- lead_list_items: gắn lead phù hợp vào list ----------
insert into public.lead_list_items (list_id, lead_id)
select '44444444-4444-4444-4444-444444444401', l.id from public.leads l
 where l.full_name in ('Nguyễn Thị Mai Anh','Trần Quang Huy','Lê Hoàng Phương','Đỗ Thị Thu Hằng')
union all
select '44444444-4444-4444-4444-444444444402', l.id from public.leads l
 where l.full_name in ('Vũ Tiến Đạt')
union all
select '44444444-4444-4444-4444-444444444403', l.id from public.leads l
 where l.full_name in ('Vũ Tiến Đạt');

-- ---------- Tasks (5 task — DesignBrief §5.2) ----------
insert into public.tasks (title, description, type, assignee_id, team_id, created_by, lead_id, due_at)
select
  'Gọi xác nhận danh sách 300 đầu sách Vinschool',
  'Gọi chị Mai Anh xác nhận danh sách sách kỹ năng sống và lịch giao tháng 8',
  'call', son.id, '11111111-1111-1111-1111-111111111111', hang.id,
  l.id, current_date + interval '16 hours'
from public.profiles son, public.profiles hang, public.leads l
where son.email='son@kitabook.vn'
  and hang.email='lead.hn@kitabook.vn'
  and l.full_name='Nguyễn Thị Mai Anh'

union all
select
  'Gửi báo giá ưu đãi 18% đơn 500 cuốn FPT',
  'Kèm phương án in tem chúc Tết theo logo FPT',
  'quote', ha.id, '11111111-1111-1111-1111-111111111111', hang.id,
  l.id, current_date + interval '1 day 10 hours'
from public.profiles ha, public.profiles hang, public.leads l
where ha.email='ha@kitabook.vn'
  and hang.email='lead.hn@kitabook.vn'
  and l.full_name='Trần Quang Huy'

union all
select
  'Chăm sóc sau bán anh Vũ Tiến Đạt',
  'Hỏi trải nghiệm bộ sách luyện thi, đề xuất combo văn học kinh điển',
  'followup', tuan.id, '22222222-2222-2222-2222-222222222222', vinh.id,
  l.id, current_date + interval '3 day 9 hours'
from public.profiles tuan, public.profiles vinh, public.leads l
where tuan.email='tuan@kitabook.vn'
  and vinh.email='lead.hcm@kitabook.vn'
  and l.full_name='Vũ Tiến Đạt'

union all
select
  'Đặt thêm 800 "Đắc Nhân Tâm" + 500 "Nhà Giả Kim"',
  'Chuẩn bị tồn kho mùa khai giảng',
  'procurement', hang.id, '11111111-1111-1111-1111-111111111111', hang.id,
  null, current_date + interval '5 day'
from public.profiles hang where hang.email='lead.hn@kitabook.vn'

union all
select
  'Họp KOL Tuấn Tiệp Books về livestream NXB Trẻ',
  'Kế hoạch livestream giới thiệu 10 đầu sách mới của NXB Trẻ',
  'meeting', vinh.id, '33333333-3333-3333-3333-333333333333', vinh.id,
  null, current_date + interval '4 day 14 hours'
from public.profiles vinh where vinh.email='lead.hcm@kitabook.vn';

-- ---------- Subscriptions ----------
insert into public.subscriptions (user_id, list_id)
select p.id, '44444444-4444-4444-4444-444444444401' from public.profiles p where p.email='lead.hn@kitabook.vn'
union all
select p.id, '44444444-4444-4444-4444-444444444403' from public.profiles p where p.email='lead.hcm@kitabook.vn'
union all
select p.id, '44444444-4444-4444-4444-444444444402' from public.profiles p where p.email='admin@kitabook.vn';
