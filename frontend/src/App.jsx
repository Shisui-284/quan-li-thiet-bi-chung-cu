import { BrowserRouter, Routes, Route } from 'react-router-dom';
import LoginPage from './pages/LoginPage';
import DashboardPage from './pages/DashboardPage';
import DevicePage from './pages/DevicePage';
import TicketPage from './pages/TicketPage';
import CreateTicketPage from './pages/CreateTicketPage';

import TechMyTicketsPage from './pages/TechMyTicketsPage';
import TechTicketDetailPage from './pages/TechTicketDetailPage';
import TechHistoryPage from './pages/TechHistoryPage';
import ReportPage from './pages/ReportPage';
import TechniciansPage from './pages/TechniciansPage';
import ContractorsPage from './pages/ContractorsPage';
import MaintenancePlansPage from './pages/MaintenancePlansPage';

function App() {
  return (
    <BrowserRouter>
      <Routes>
        {/* Định nghĩa cả '/' và '/login' để tránh lỗi No routes matched */}
        <Route path="/" element={<LoginPage />} />
        <Route path="/login" element={<LoginPage />} />

        {/* Các trang quản trị (Admin) */}
        <Route path="/dashboard" element={<DashboardPage />} />
        <Route path="/devices" element={<DevicePage />} />
        <Route path="/tickets" element={<TicketPage />} />
        <Route path="/tickets/new" element={<CreateTicketPage />} />
        <Route path="/technicians" element={<TechniciansPage />} />
        <Route path="/contractors" element={<ContractorsPage />} />
        <Route path="/maintenance-plans" element={<MaintenancePlansPage />} />

        {/* Các trang dành cho nhân viên kỹ thuật (Mobile View) */}
        <Route path="/tech-mobile" element={<TechMyTicketsPage />} />
        <Route path="/tech-mobile/ticket/:id" element={<TechTicketDetailPage />} />
        <Route path="/tech-mobile/history" element={<TechHistoryPage />} />
        <Route path="/tech-mobile/report" element={<ReportPage />} /> 
      </Routes>
    </BrowserRouter>
  );
}

export default App;