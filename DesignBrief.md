# DESIGN BRIEF — CRM KITABOOKS

**Dự án:** Hệ thống CRM nội bộ cho Công ty Sách Kitabooks (kitabook.vn) **Phiên bản:** 1.0 — Giai đoạn 1 **Phong cách chủ đạo:** Tối giản, kính mờ nhẹ (frosted glass), font mỏng, nhiều khoảng trắng, một màu accent duy nhất **Cảm hứng:** Trang giấy cũ của sách quý — vàng kem ấm, nâu vàng của bìa da, không gian sáng và tĩnh lặng như một thư viện hiện đại

---

## 1\. Color Palette

Bảng màu chỉ dùng **một màu accent chính** (Amber Gold) — tất cả hành động quan trọng, trạng thái nổi bật, biểu đồ chính đều dùng tone này. Các màu còn lại đóng vai trò nền và chữ.

### 1.1. Màu nền (Background)

| Tên | HEX | Vai trò |
| :---- | :---- | :---- |
| Paper White | `#FBF8F1` | Nền chính của toàn bộ ứng dụng — gợi giấy ngà |
| Cream Mist | `#F4EFE3` | Nền phụ, nền card phụ |
| Frosted Glass | `rgba(255, 251, 240, 0.65)` | Nền sidebar và modal — hiệu ứng backdrop-blur 20px |
| Pure Ivory | `#FFFFFF` | Nền card chính, nền input |

### 1.2. Màu accent (chỉ một)

| Tên | HEX | Vai trò |
| :---- | :---- | :---- |
| **Amber Gold** | `#C8881C` | **Màu accent duy nhất** — nút chính, link, biểu đồ, badge VIP, focus ring |
| Amber Gold Soft | `#E8C77A` | Hover state, fill nhạt của amber |
| Amber Gold Tint | `#F7EBC9` | Background của badge, highlight nhẹ |

### 1.3. Màu trung tính (Neutral)

| Tên | HEX | Vai trò |
| :---- | :---- | :---- |
| Ink Brown | `#3A2E1F` | Tiêu đề chính, chữ đậm |
| Soft Brown | `#6B5A45` | Chữ thân bài |
| Muted Sand | `#A89980` | Chữ phụ, placeholder |
| Border Whisper | `#EDE6D6` | Border, divider |

### 1.4. Màu trạng thái (dùng tiết chế)

| Tên | HEX | Vai trò |
| :---- | :---- | :---- |
| Success Sage | `#7A9A6E` | Đơn hoàn thành, lead chốt |
| Warning Ochre | `#D4A24A` | Cảnh báo nhẹ |
| Error Clay | `#B5563C` | Lỗi, đơn huỷ |

**Nguyên tắc:** Toàn UI giữ độ tương phản tối thiểu 4.5:1 theo WCAG. Chỉ amber gold được phép dùng làm điểm nhấn — không bao giờ thêm màu thứ hai để "trang trí".

---

## 2\. Typography

### 2.1. Font family

- **Primary:** `Inter` — toàn bộ giao diện  
- **Display (tiêu đề lớn):** `Fraunces` (serif) — chỉ dùng cho tên trang, dashboard headline, gợi cảm giác sách in  
- **Mono:** `JetBrains Mono` — cho mã đơn, ID

### 2.2. Cân nặng (Weight) — ưu tiên font mỏng

| Vai trò | Weight |
| :---- | :---- |
| Display Headline (tên trang) | Fraunces **300** (Light) |
| H1 (tiêu đề mục) | Inter **400** (Regular) |
| H2 / H3 | Inter **500** (Medium) |
| Body | Inter **400** |
| Caption / Meta | Inter **300** (Light) |
| Button | Inter **500** |

### 2.3. Scale

| Token | Size | Line-height | Letter-spacing |
| :---- | :---- | :---- | :---- |
| display | 40px | 48px | \-0.02em |
| h1 | 28px | 36px | \-0.01em |
| h2 | 22px | 30px | \-0.005em |
| h3 | 18px | 26px | 0 |
| body | 14px | 22px | 0 |
| small | 13px | 20px | 0 |
| caption | 12px | 18px | 0.02em |

### 2.4. Quy tắc dùng chữ

- **Không bao giờ bold tiêu đề** — dùng size \+ weight 400/500 \+ spacing để tạo cấp bậc.  
- **Letter-spacing âm nhẹ** ở tiêu đề lớn để chữ "sách hơn".  
- Tiêu đề trang sử dụng Fraunces 300 — tạo nét đặc trưng riêng cho Kitabooks giữa các CRM khác.

---

## 3\. Layout Structure — 6 trang chính

Toàn bộ trang dùng grid 12 cột, max-width 1440px, padding ngoài 32px, gap giữa các khối **24px hoặc 32px** (ưu tiên khoảng trắng rộng).

### 3.1. Trang Đăng nhập (Login)

┌────────────────────────────────────────────────────┐

│                                                    │

│                                                    │

│              \[Logo Kitabooks — 48px\]               │

│                                                    │

│         Chào mừng trở lại nhà sách (Fraunces 300\)  │

│              Đăng nhập để tiếp tục                 │

│                                                    │

│         ┌─────────────────────────────┐            │

│         │  Email                       │           │

│         └─────────────────────────────┘            │

│         ┌─────────────────────────────┐            │

│         │  Mật khẩu                    │           │

│         └─────────────────────────────┘            │

│         \[  Đăng nhập  \] (amber gold)               │

│              — hoặc —                              │

│         \[  Đăng nhập với Google  \] (outline)       │

│                                                    │

│              Quên mật khẩu?                        │

│                                                    │

└────────────────────────────────────────────────────┘

- Form căn giữa, max-width 400px, **nền frosted glass** chồng trên một ảnh trừu tượng gáy sách rất mờ.  
- Không có sidebar, không có header.

### 3.2. Dashboard (Trang chủ)

- **Top bar (64px):** logo trái, ô tìm kiếm toàn cục giữa, avatar phải.  
- **Sidebar trái (240px):** menu module, nền frosted glass.  
- **Khu vực chính (12 cột grid):**  
  - **Hàng 1 — KPI cards** (4 card ngang đều nhau): Tổng doanh số tháng, Lead mới, Tỷ lệ chuyển đổi, Khách quay lại.  
  - **Hàng 2 — Chart doanh số 30 ngày** (8 cột) \+ **Nhắc việc hôm nay** (4 cột).  
  - **Hàng 3 — Lead cần chăm sóc** (bảng 8 cột) \+ **Top khách VIP** (4 cột).

### 3.3. Danh sách Khách hàng (Customers)

- Header trang: tiêu đề "Khách hàng" (Fraunces 300, 40px) \+ nút "+ Thêm khách" amber gold ở phải.  
- **Filter bar:** ô tìm, dropdown Phân khúc, dropdown Nhân viên phụ trách, dropdown Thể loại yêu thích.  
- **Bảng:** Tên, Số ĐT, Phân khúc (badge), Tổng đã mua, Lần mua gần nhất, Phụ trách.  
- Row hover: nền chuyển Cream Mist, không đường gạch ngang đậm — chỉ border-bottom 1px Border Whisper.

### 3.4. Chi tiết Khách hàng (Customer 360\)

- **Cột trái (4 cột) — sticky:** avatar tròn, tên (Fraunces 300), badge phân khúc, thông tin liên hệ, tags thể loại, nút "Tạo đơn hàng" amber gold full-width.  
- **Cột phải (8 cột) — tab navigation:** Tổng quan / Tương tác / Đơn hàng / Ghi chú.  
- Mỗi tab nội dung là một stack card đứng — nhiều khoảng trắng giữa các card (gap 24px).

### 3.5. Lead — Kanban Board

- **5 cột Kanban:** Mới → Đang tư vấn → Cần gọi lại → Đã chốt → Đã huỷ.  
- Tiêu đề cột: tên \+ số đếm nhỏ Muted Sand bên cạnh.  
- Cột huỷ và chốt có opacity 0.7 để mắt tự tập trung vào pipeline đang chạy.  
- Card lead kéo thả mượt, có animation 200ms ease-out.

### 3.6. Báo cáo (Reports)

- Header: dropdown khoảng thời gian (Tuần này, Tháng này, Quý này, Tuỳ chọn).  
- Lưới 2 cột:  
  - Trái: chart doanh số theo nhân viên (bar), chart nguồn lead (donut).  
  - Phải: bảng chi tiết lead theo nguồn, bảng top 10 đầu sách bán chạy.  
- Tất cả chart **chỉ dùng amber gold \+ 2 sắc độ neutral** — không bao giờ dùng cầu vồng.

---

## 4\. Component Style

### 4.1. Card

background: \#FFFFFF

border: 1px solid \#EDE6D6

border-radius: 16px

padding: 24px

box-shadow: 0 1px 2px rgba(58, 46, 31, 0.04)

hover: box-shadow 0 4px 16px rgba(58, 46, 31, 0.06), translateY(-1px)

transition: 200ms ease-out

- Card phụ (nền): background Cream Mist `#F4EFE3`, không shadow.  
- Card "kính mờ" (modal, sidebar): `backdrop-filter: blur(20px)`, background `rgba(255, 251, 240, 0.65)`, border `1px solid rgba(237, 230, 214, 0.5)`.

### 4.2. Button

**Primary**

background: \#C8881C

color: \#FFFFFF

font-weight: 500

padding: 10px 20px

border-radius: 10px

hover: background \#B0761A

disabled: opacity 0.4

**Secondary (outline)**

background: transparent

color: \#3A2E1F

border: 1px solid \#EDE6D6

hover: background \#F4EFE3

**Ghost (text only)**

background: transparent

color: \#C8881C

hover: background \#F7EBC9

Tất cả button cao **40px** (standard) hoặc **32px** (small). Không bao giờ dùng gradient hay shadow đậm.

### 4.3. Input

height: 44px

background: \#FFFFFF

border: 1px solid \#EDE6D6

border-radius: 10px

padding: 0 14px

font: Inter 400 14px

placeholder color: \#A89980

focus: border \#C8881C, ring 3px rgba(200, 136, 28, 0.15)

- Label đặt **trên** input, font weight 400, color Soft Brown.  
- Không dùng border underline kiểu Material.

### 4.4. Badge

Badge cao **22px**, padding ngang 10px, border-radius **999px** (pill), font Inter 500 size 12px.

| Loại | Background | Text |
| :---- | :---- | :---- |
| VIP | `#F7EBC9` | `#8B5E0B` |
| Mới | `#EDE6D6` | `#6B5A45` |
| Doanh nghiệp | `#E6DCC8` | `#3A2E1F` |
| Đã chốt | `#DBE7D4` | `#3F5A33` |
| Đã huỷ | `#EFD9D2` | `#7A3826` |

### 4.5. Sidebar

width: 240px (collapsed 72px)

background: rgba(255, 251, 240, 0.65)

backdrop-filter: blur(24px)

border-right: 1px solid \#EDE6D6

padding: 24px 16px

- Mỗi mục menu cao 40px, icon 20px (stroke 1.5px — thin line icons), khoảng cách icon–text 12px.  
- Mục active: background `#F7EBC9`, text Ink Brown, có thanh dọc amber gold 3px bên trái.  
- Nhóm menu cách nhau 24px, có caption nhỏ uppercase Muted Sand "QUẢN LÝ", "BÁO CÁO"…

### 4.6. Kanban Card

background: \#FFFFFF

border: 1px solid \#EDE6D6

border-radius: 12px

padding: 16px

margin-bottom: 12px

- Cấu trúc dọc:  
  - Dòng 1: Tên khách (Inter 500, 14px, Ink Brown)  
  - Dòng 2: Sản phẩm quan tâm (Inter 400, 13px, Soft Brown)  
  - Dòng 3: Giá trị dự kiến (Inter 500, amber gold) \+ avatar tròn nhân viên phụ trách (24px) căn phải  
  - Dòng 4: Badge nguồn lead \+ chấm nhỏ deadline  
- Khi kéo: shadow nâng lên `0 12px 32px rgba(58, 46, 31, 0.12)`, rotate \-1deg.

---

## 5\. Dữ liệu mẫu (Sample Data)

### 5.1. Sáu khách hàng tiềm năng (Lead)

| \# | Họ tên | Công ty | Phân khúc | Sản phẩm quan tâm | Giá trị (VND) |
| :---- | :---- | :---- | :---- | :---- | :---- |
| 1 | Nguyễn Thị Mai Anh | Trường Quốc tế Vinschool | Doanh nghiệp — Giáo dục | Combo 300 cuốn sách kỹ năng sống cho học sinh THCS | 165.000.000 |
| 2 | Trần Quang Huy | Công ty Cổ phần FPT | Doanh nghiệp — Quà tặng | 500 cuốn "Tư duy nhanh và chậm" làm quà tặng nhân viên | 245.000.000 |
| 3 | Lê Hoàng Phương | Ngân hàng TMCP Techcombank | Doanh nghiệp — Đào tạo | Combo sách lãnh đạo Harvard Business Review (150 bộ) | 412.500.000 |
| 4 | Phạm Minh Khoa | Hệ thống Nhà sách Phương Nam | Đại lý sỉ | Đặt sỉ 1.200 cuốn sách thiếu nhi cho mùa khai giảng | 96.000.000 |
| 5 | Đỗ Thị Thu Hằng | Tập đoàn Vingroup — VinUni | Doanh nghiệp — Giáo dục | Sách giáo trình kinh tế bản quyền cho thư viện trường | 580.000.000 |
| 6 | Vũ Tiến Đạt | Cá nhân — Phụ huynh học sinh Ams | Cá nhân — VIP | Combo sách luyện thi chuyên Anh \+ sách văn học kinh điển | 8.400.000 |

### 5.2. Năm công việc thực tế ngành sách

| \# | Loại | Nội dung công việc | Deadline | Phụ trách |
| :---- | :---- | :---- | :---- | :---- |
| 1 | Gọi điện | Gọi chị Mai Anh (Vinschool) để xác nhận lại danh sách 300 đầu sách kỹ năng sống và lịch giao tháng 8 | Hôm nay 16:00 | Nguyễn Văn Sơn |
| 2 | Báo giá | Gửi báo giá ưu đãi 18% cho đơn 500 cuốn của FPT, kèm phương án in tem chúc Tết theo logo công ty | Mai 10:00 | Lê Thị Hà |
| 3 | Chăm sóc sau bán | Hỏi thăm anh Vũ Tiến Đạt về trải nghiệm bộ sách luyện thi đã giao tuần trước, đề xuất combo văn học kinh điển | Thứ Tư 09:00 | Trần Minh Tuấn |
| 4 | Đặt hàng nhà xuất bản | Đặt thêm 800 cuốn "Đắc Nhân Tâm" và 500 cuốn "Nhà Giả Kim" để chuẩn bị tồn kho mùa khai giảng | Thứ Sáu trong tuần | Phạm Thanh Hằng |
| 5 | Họp KOL | Họp với KOL Reviewer Tuấn Tiệp Books về kế hoạch livestream giới thiệu 10 đầu sách mới của Nhà xuất bản Trẻ | Thứ Năm 14:00 | Đỗ Quang Vinh |

### 5.3. Ba danh sách khách hàng phù hợp phân nhóm

**Danh sách 1 — "VIP Doanh nghiệp Quý 3"** Tiêu chí: Khách doanh nghiệp có ít nhất một đơn hàng trên 100 triệu trong 90 ngày, hoặc đã ký hợp đồng cung cấp sách định kỳ. Dùng để gửi catalogue sách mới của Nhà xuất bản Trẻ và NXB Kim Đồng quý 3, kèm chương trình chiết khấu 12% cho đơn từ 200 cuốn.

**Danh sách 2 — "Phụ huynh học sinh — Mùa khai giảng"** Tiêu chí: Khách hàng cá nhân có tag "Phụ huynh", đã từng mua sách thiếu nhi hoặc sách học thuật, lần mua gần nhất trong 12 tháng. Dùng để chạy chiến dịch combo sách bổ trợ mùa khai giảng từ 15/7 đến 15/9, mỗi combo có ưu đãi tặng kèm cẩm nang phương pháp học.

**Danh sách 3 — "Độc giả Văn học Kinh điển"** Tiêu chí: Khách hàng đã mua ít nhất 2 đầu sách thuộc thể loại "Văn học kinh điển" hoặc "Văn học Việt Nam", có tag thể loại "Văn học". Dùng để giới thiệu các bản đặc biệt bìa cứng, các đợt tái bản giới hạn, và tour ra mắt sách cùng tác giả/dịch giả tại Hà Nội và TP.HCM.

---

## 6\. Quy tắc tổng (Design Principles)

1. **Một accent duy nhất.** Khi cần điểm nhấn — dùng amber gold. Khi cần thêm điểm nhấn — bớt đi, đừng thêm.  
2. **Khoảng trắng là nội dung.** Mỗi card cách nhau tối thiểu 24px. Mỗi section cách nhau 48px. Đừng lấp đầy.  
3. **Mỏng, không đậm.** Mọi tiêu đề mặc định weight 300–400. Bold chỉ dùng cho cảnh báo hoặc số liệu quan trọng nhất.  
4. **Kính mờ thay vì border đậm.** Sidebar, modal, dropdown đều dùng `backdrop-filter: blur` thay vì shadow nặng.  
5. **Tĩnh lặng như thư viện.** Hạn chế animation. Khi có — chỉ 200ms ease-out, biên độ nhỏ (translateY 1px, opacity 0.04 → 0.06).

---

*Tài liệu này là kim chỉ nam thiết kế cho toàn bộ Giai đoạn 1\. Mọi màn hình, mọi component mới phải tham chiếu lại Design Brief này trước khi đưa vào sản xuất.*  
