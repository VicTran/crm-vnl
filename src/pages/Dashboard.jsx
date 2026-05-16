import React, { useEffect, useState } from 'react';
import { apiService } from '../services/apiService';
import { TrendingUp, Users, Target, UserPlus, Clock, ExternalLink } from 'lucide-react';
import './Dashboard.css';

const Dashboard = () => {
  const [stats, setStats] = useState(null);
  const [tasks, setTasks] = useState([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const loadData = async () => {
      const [statsData, tasksData] = await Promise.all([
        apiService.getStats(),
        apiService.getTasks()
      ]);
      setStats(statsData);
      setTasks(tasksData);
      setLoading(setLoading(false));
    };
    loadData();
  }, []);

  if (loading) return <div className="loading">Đang mở kho lưu trữ...</div>;

  return (
    <div className="dashboard-container">
      <header className="page-header">
        <div>
          <h1 className="page-title">Xin chào, Thủ thư</h1>
          <p className="page-subtitle">Ngày 16 tháng 5 năm 2024 — Tiết trời thanh tịnh cho việc lưu trữ.</p>
        </div>
        <button className="btn-primary">
          <UserPlus size={18} />
          <span>Thêm khách mới</span>
        </button>
      </header>

      <div className="stats-grid">
        <div className="card stat-card">
          <div className="stat-icon-wrapper amber">
            <TrendingUp size={24} />
          </div>
          <div className="stat-info">
            <p className="stat-label">Doanh thu dự kiến</p>
            <h3 className="stat-value">{stats.totalRevenue.toLocaleString()} đ</h3>
            <p className="stat-trend positive">+12.5% so với tháng trước</p>
          </div>
        </div>
        
        <div className="card stat-card">
          <div className="stat-icon-wrapper green">
            <Users size={24} />
          </div>
          <div className="stat-info">
            <p className="stat-label">Khách hàng mới</p>
            <h3 className="stat-value">{stats.newLeads}</h3>
            <p className="stat-trend positive">+8 khách mới tuần này</p>
          </div>
        </div>

        <div className="card stat-card">
          <div className="stat-icon-wrapper brown">
            <Target size={24} />
          </div>
          <div className="stat-info">
            <p className="stat-label">Tỷ lệ chốt</p>
            <h3 className="stat-value">{stats.conversionRate}%</h3>
            <p className="stat-trend positive">+2.1% từ KOLs</p>
          </div>
        </div>
      </div>

      <div className="dashboard-grid">
        <div className="card dashboard-main">
          <h3 className="section-title">Nhắc việc trong ngày</h3>
          <div className="task-list">
            {tasks.map(task => (
              <div key={task.id} className="task-item">
                <div className="task-check">
                  <div className="checkbox-custom"></div>
                </div>
                <div className="task-content">
                  <p className="task-title">{task.title}</p>
                  <div className="task-meta">
                    <span className="task-lead"><Users size={12} /> {task.lead_name}</span>
                    <span className="task-time"><Clock size={12} /> {new Date(task.due_at).toLocaleTimeString([], {hour: '2-digit', minute:'2-digit'})}</span>
                  </div>
                </div>
                <div className={`task-type-badge ${task.type}`}>
                  {task.type === 'call' ? 'Gọi điện' : task.type === 'quote' ? 'Báo giá' : 'Theo dõi'}
                </div>
              </div>
            ))}
          </div>
          <button className="view-all-btn">Xem toàn bộ lịch trình <ExternalLink size={14} /></button>
        </div>

        <div className="card dashboard-side">
          <h3 className="section-title">Gợi ý từ CRM</h3>
          <div className="insight-box">
            <div className="insight-icon">✨</div>
            <p className="insight-text">
              "Khách hàng VIP thường phản hồi tốt nhất vào sáng thứ Hai. Bạn nên lên lịch gửi email hàng loạt vào khung giờ 09:00 - 10:00."
            </p>
          </div>
          <div className="kpi-mini-grid">
            <div className="kpi-mini">
              <p className="kpi-mini-label">Khách quay lại</p>
              <p className="kpi-mini-value">{stats.returningCustomers}%</p>
            </div>
            <div className="kpi-mini">
              <p className="kpi-mini-label">Nguồn Lead top</p>
              <p className="kpi-mini-value">Referral</p>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default Dashboard;
