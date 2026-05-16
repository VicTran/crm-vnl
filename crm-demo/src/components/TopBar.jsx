import React from 'react';
import { Search, Bell, User } from 'lucide-react';
import './TopBar.css';

const TopBar = () => {
  return (
    <div className="topbar">
      <div className="search-container">
        <Search size={18} color="var(--muted-sand)" />
        <input type="text" placeholder="Tìm kiếm trong thư viện..." className="search-input" />
      </div>
      
      <div className="topbar-actions">
        <button className="action-btn">
          <Bell size={20} strokeWidth={1.5} />
          <span className="notification-badge"></span>
        </button>
        <div className="user-profile">
          <div className="user-info">
            <p className="user-name">Minh Trần</p>
            <p className="user-role">Quản trị viên</p>
          </div>
          <div className="avatar">
            <User size={20} />
          </div>
        </div>
      </div>
    </div>
  );
};

export default TopBar;
