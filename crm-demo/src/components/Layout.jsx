import React from 'react';
import { Outlet } from 'react-router-dom';
import Sidebar from './Sidebar';
import TopBar from './TopBar';
import './Layout.css';

const Layout = () => {
  return (
    <div className="app-layout">
      <Sidebar />
      <div className="main-container">
        <TopBar />
        <main className="content">
          <Outlet />
        </main>
      </div>
    </div>
  );
};

export default Layout;
