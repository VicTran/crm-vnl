import React, { useEffect, useState } from 'react';
import { apiService } from '../services/apiService';
import { Plus, MoreVertical, Calendar, DollarSign } from 'lucide-react';
import './LeadKanban.css';

const LeadKanban = () => {
  const [leads, setLeads] = useState([]);
  const [loading, setLoading] = useState(true);

  const columns = [
    { id: 'new', title: 'Mới nhận', color: '#EDE6D6' },
    { id: 'callback', title: 'Hẹn gọi lại', color: '#F7EBC9' },
    { id: 'in_consult', title: 'Đang tư vấn', color: '#D4A24A' },
    { id: 'negotiate', title: 'Thương thảo', color: '#C8881C' },
    { id: 'won', title: 'Đã hoàn thành', color: '#7A9A6E' }
  ];

  useEffect(() => {
    const loadData = async () => {
      const data = await apiService.getLeads();
      setLeads(data);
      setLoading(false);
    };
    loadData();
  }, []);

  if (loading) return <div className="loading">Đang sắp xếp các bản thảo...</div>;

  return (
    <div className="kanban-page">
      <header className="page-header">
        <div>
          <h1 className="page-title">Tiến độ xử lý Lead</h1>
          <p className="page-subtitle">Theo dõi hành trình từ độc giả tiềm năng đến khách hàng thân thiết.</p>
        </div>
        <button className="btn-primary">
          <Plus size={18} />
          <span>Tạo Lead Mới</span>
        </button>
      </header>

      <div className="kanban-board">
        {columns.map(column => (
          <div key={column.id} className="kanban-column">
            <div className="column-header">
              <div className="column-title-group">
                <div className="column-dot" style={{ backgroundColor: column.color }}></div>
                <h3 className="column-title">{column.title}</h3>
                <span className="column-count">
                  {leads.filter(l => l.status === column.id).length}
                </span>
              </div>
              <button className="column-add"><Plus size={16} /></button>
            </div>
            
            <div className="kanban-cards">
              {leads
                .filter(l => l.status === column.id)
                .map(lead => (
                  <div key={lead.id} className="kanban-card card">
                    <div className="card-header">
                      <span className="lead-id">#{lead.id.padStart(4, '0')}</span>
                      <button className="card-options"><MoreVertical size={14} /></button>
                    </div>
                    <h4 className="card-lead-name">{lead.full_name}</h4>
                    <p className="card-company">{lead.company}</p>
                    
                    <div className="card-tags">
                      <span className="tag-source">{lead.source}</span>
                    </div>

                    <div className="card-footer">
                      <div className="footer-item">
                        <DollarSign size={14} />
                        <span>{(lead.estimated_value / 1000000).toFixed(1)}M</span>
                      </div>
                      {lead.next_action_at && (
                        <div className="footer-item">
                          <Calendar size={14} />
                          <span>{new Date(lead.next_action_at).toLocaleDateString('vi-VN', {day: '2-digit', month: '2-digit'})}</span>
                        </div>
                      )}
                      <div className="card-avatar">
                        {lead.owner.charAt(0)}
                      </div>
                    </div>
                  </div>
                ))}
            </div>
          </div>
        ))}
      </div>
    </div>
  );
};

export default LeadKanban;
