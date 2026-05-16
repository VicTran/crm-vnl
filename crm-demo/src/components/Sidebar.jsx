import React from 'react';
import { NavLink } from 'react-router-dom';
import { 
  LayoutDashboard, 
  Users, 
  Kanban, 
  BarChart3, 
  CheckSquare, 
  Settings,
  BookOpen,
  LogOut,
  HelpCircle
} from 'lucide-react';
import './Sidebar.css';

const Sidebar = () => {
  return (
    <div className="sidebar glass">
      <div className="logo-section">
        <BookOpen size={28} color="var(--amber-gold)" />
        <span className="logo-text">Kitabooks</span>
      </div>

      <nav className="nav-group">
        <p className="nav-label">Quản lý</p>
        <NavLink to="/" className={({ isActive }) => `nav-item ${isActive ? 'active' : ''}`}>
          <LayoutDashboard size={20} strokeWidth={1.5} />
          <span>Dashboard</span>
        </NavLink>
        <NavLink to="/customers" className={({ isActive }) => `nav-item ${isActive ? 'active' : ''}`}>
          <Users size={20} strokeWidth={1.5} />
          <span>Khách hàng</span>
        </NavLink>
        <NavLink to="/leads" className={({ isActive }) => `nav-item ${isActive ? 'active' : ''}`}>
          <Kanban size={20} strokeWidth={1.5} />
          <span>Leads Kanban</span>
        </NavLink>
      </nav>

      <nav className="nav-group">
        <p className="nav-label">Hệ thống</p>
        <NavLink to="/reports" className={({ isActive }) => `nav-item ${isActive ? 'active' : ''}`}>
          <BarChart3 size={20} strokeWidth={1.5} />
          <span>Báo cáo</span>
        </NavLink>
        <NavLink to="/tasks" className={({ isActive }) => `nav-item ${isActive ? 'active' : ''}`}>
          <CheckSquare size={20} strokeWidth={1.5} />
          <span>Nhắc việc</span>
        </NavLink>
      </nav>

      <div className="sidebar-footer">
        <NavLink to="/help" className="nav-item">
          <HelpCircle size={20} strokeWidth={1.5} />
          <span>Hỗ trợ</span>
        </NavLink>
        <NavLink to="/logout" className="nav-item">
          <LogOut size={20} strokeWidth={1.5} />
          <span>Đăng xuất</span>
        </NavLink>
      </div>
    </div>
  );
};

export default Sidebar;
