export const mockLeads = [
  {
    id: '1',
    full_name: 'Nguyễn Thị Mai Anh',
    company: 'Trường Quốc tế Vinschool',
    segment: 'Doanh nghiệp - Giáo dục',
    source: 'referral',
    interested_products: 'Combo 300 cuốn sách kỹ năng sống cho học sinh THCS',
    estimated_value: 165000000,
    status: 'in_consult',
    owner: 'Nguyễn Văn Sơn',
    next_action_at: '2026-05-18T16:00:00Z'
  },
  {
    id: '2',
    full_name: 'Trần Quang Huy',
    company: 'Công ty Cổ phần FPT',
    segment: 'Doanh nghiệp - Quà tặng',
    source: 'kol',
    interested_products: '500 cuốn "Tư duy nhanh và chậm" làm quà tặng nhân viên',
    estimated_value: 245000000,
    status: 'new',
    owner: 'Lê Thị Hà',
    next_action_at: '2026-05-17T10:00:00Z'
  },
  {
    id: '3',
    full_name: 'Lê Hoàng Phương',
    company: 'Ngân hàng TMCP Techcombank',
    segment: 'Doanh nghiệp - Đào tạo',
    source: 'referral',
    interested_products: 'Combo sách lãnh đạo Harvard Business Review (150 bộ)',
    estimated_value: 412500000,
    status: 'callback',
    owner: 'Nguyễn Văn Sơn',
    next_action_at: '2026-05-19T09:00:00Z'
  },
  {
    id: '4',
    full_name: 'Phạm Minh Khoa',
    company: 'Hệ thống Nhà sách Phương Nam',
    segment: 'Đại lý sỉ',
    source: 'hotline',
    interested_products: 'Đặt sỉ 1.200 cuốn sách thiếu nhi cho mùa khai giảng',
    estimated_value: 96000000,
    status: 'in_consult',
    owner: 'Trần Minh Tuấn',
    next_action_at: '2026-05-21T10:00:00Z'
  },
  {
    id: '5',
    full_name: 'Đỗ Thị Thu Hằng',
    company: 'Tập đoàn Vingroup - VinUni',
    segment: 'Doanh nghiệp - Giáo dục',
    source: 'website_form',
    interested_products: 'Sách giáo trình kinh tế bản quyền cho thư viện trường',
    estimated_value: 580000000,
    status: 'new',
    owner: 'Trần Minh Tuấn',
    next_action_at: '2026-05-18T14:00:00Z'
  },
  {
    id: '6',
    full_name: 'Vũ Tiến Đạt',
    company: 'Cá nhân - Phụ huynh học sinh Ams',
    segment: 'Cá nhân - VIP',
    source: 'facebook_ads',
    interested_products: 'Combo sách luyện thi chuyên Anh + sách văn học kinh điển',
    estimated_value: 8400000,
    status: 'won',
    owner: 'Lê Thị Hà',
    next_action_at: null
  }
];

export const mockTasks = [
  {
    id: 't1',
    title: 'Gọi xác nhận danh sách 300 đầu sách Vinschool',
    type: 'call',
    status: 'open',
    due_at: '2026-05-16T16:00:00Z',
    assignee: 'Nguyễn Văn Sơn',
    lead_name: 'Nguyễn Thị Mai Anh'
  },
  {
    id: 't2',
    title: 'Gửi báo giá ưu đãi 18% đơn 500 cuốn FPT',
    type: 'quote',
    status: 'open',
    due_at: '2026-05-17T10:00:00Z',
    assignee: 'Lê Thị Hà',
    lead_name: 'Trần Quang Huy'
  },
  {
    id: 't3',
    title: 'Chăm sóc sau bán anh Vũ Tiến Đạt',
    type: 'followup',
    status: 'open',
    due_at: '2026-05-19T09:00:00Z',
    assignee: 'Trần Minh Tuấn',
    lead_name: 'Vũ Tiến Đạt'
  }
];

export const mockStats = {
  totalRevenue: 1245000000,
  newLeads: 24,
  conversionRate: 18.5,
  returningCustomers: 42
};
