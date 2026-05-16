import React, { useEffect, useState } from 'react';
import { apiService } from '../services/apiService';
import { Filter, Search, MoreHorizontal, UserPlus, Mail, Phone } from 'lucide-react';
import './CustomerList.css';

const CustomerList = () => {
  const [leads, setLeads] = useState([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const loadLeads = async () => {
      const data = await apiService.getLeads();
      setLeads(data);
      setLoading(false);
    };
    loadLeads();
  }, []);

  const getStatusBadge = (status) => {
    switch (status) {
      case 'new': return <span className="badge badge-neutral">Mới</span>;
      case 'in_consult': return <span className="badge badge-warning">Đang tư vấn</span>;
      case 'won': return <span className="badge badge-success">Đã chốt</span>;
      case 'callback': return <span className="badge badge-warning">Hẹn gọi lại</span>;
      default: return <span className="badge badge-neutral">{status}</span>;
    }
  };

  if (loading) return <div className="loading">Đang tra cứu danh mục...</div>;

  return (
    <div className="page-container">
      <header className="page-header">
        <div>
          <h1 className="page-title">Danh sách Lead & Khách hàng</h1>
          <p className="page-subtitle">Quản lý và phân loại 1,240 độc giả tiềm năng.</p>
        </div>
        <div className="header-actions">
          <button className="btn-secondary">
            <Filter size={18} />
            <span>Lọc</span>
          </button>
          <button className="btn-primary">
            <UserPlus size={18} />
            <span>Thêm khách hàng</span>
          </button>
        </div>
      </header>

      <div className="card table-card">
        <div className="table-filters">
          <div className="search-box">
            <Search size={16} />
            <input type="text" placeholder="Tìm tên, công ty hoặc số điện thoại..." />
          </div>
          <div className="filter-tabs">
            <button className="tab active">Tất cả</button>
            <button className="tab">Đang hoạt động</button>
            <button className="tab">Đã hoàn thành</button>
            <button className="tab">Lưu trữ</button>
          </div>
        </div>

        <table className="custom-table">
          <thead>
            <tr>
              <th>Họ và tên</th>
              <th>Công ty / Đơn vị</th>
              <th>Nguồn Lead</th>
              <th>Giá trị dự kiến</th>
              <th>Trạng thái</th>
              <th>Phụ trách</th>
              <th></th>
            </tr>
          </thead>
          <tbody>
            {leads.map(lead => (
              <tr key={lead.id}>
                <td>
                  <div className="lead-name-cell">
                    <div className="avatar-mini">{lead.full_name.charAt(0)}</div>
                    <div>
                      <p className="name">{lead.full_name}</p>
                      <p className="segment">{lead.segment}</p>
                    </div>
                  </div>
                </td>
                <td>{lead.company}</td>
                <td>
                  <span className="source-tag">{lead.source}</span>
                </td>
                <td className="value-cell">{lead.estimated_value.toLocaleString()} đ</td>
                <td>{getStatusBadge(lead.status)}</td>
                <td>{lead.owner}</td>
                <td>
                  <button className="action-dots">
                    <MoreHorizontal size={18} />
                  </button>
                </td>
              </tr>
            ))}
          </tbody>
        </table>
        
        <div className="table-pagination">
          <p>Hiển thị 1-6 của 1,240 lead</p>
          <div className="page-btns">
            <button disabled>Trước</button>
            <button className="active">1</button>
            <button>2</button>
            <button>3</button>
            <button>Sau</button>
          </div>
        </div>
      </div>
    </div>
  );
};

export default CustomerList;
