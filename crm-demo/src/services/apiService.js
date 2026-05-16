import { mockLeads, mockTasks, mockStats } from './mockData';

// Giả lập độ trễ mạng để bản demo trông thật hơn
const delay = (ms) => new Promise(resolve => setTimeout(resolve, ms));

export const apiService = {
  getLeads: async () => {
    await delay(500);
    return mockLeads;
  },
  
  getLeadById: async (id) => {
    await delay(300);
    return mockLeads.find(l => l.id === id);
  },
  
  getTasks: async () => {
    await delay(400);
    return mockTasks;
  },
  
  getStats: async () => {
    await delay(600);
    return mockStats;
  },
  
  createLead: async (leadData) => {
    await delay(800);
    const newLead = { ...leadData, id: Math.random().toString(36).substr(2, 9) };
    mockLeads.unshift(newLead);
    return newLead;
  }
};
