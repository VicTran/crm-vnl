import React from 'react';
import { Routes, Route } from 'react-router-dom';
import Layout from './components/Layout';
import Dashboard from './pages/Dashboard';
import CustomerList from './pages/CustomerList';
import LeadKanban from './pages/LeadKanban';

function App() {
  return (
    <Routes>
      <Route path="/" element={<Layout />}>
        <Route index element={<Dashboard />} />
        <Route path="customers" element={<CustomerList />} />
        <Route path="leads" element={<LeadKanban />} />
        <Route path="reports" element={<div className="card">Màn hình Báo cáo đang được xây dựng...</div>} />
        <Route path="tasks" element={<div className="card">Danh sách Nhắc việc đang được xây dựng...</div>} />
      </Route>
    </Routes>
  );
}

export default App;

// Autonomous sync test by Antigravity Agent
