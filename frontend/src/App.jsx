import { BrowserRouter, Routes, Route } from 'react-router-dom';
import LoginPage from './pages/LoginPage';
import DashboardPage from './pages/DashboardPage';
import DevicePage from './pages/DevicePage';
import TicketPage from './pages/TicketPage';
import CreateTicketPage from './pages/CreateTicketPage';

function App() {
  return (
    <BrowserRouter>
      <Routes>
        {/* Đường dẫn gốc '/' sẽ trỏ ngay đến trang Đăng Nhập */}
        <Route path="/" element={<LoginPage />} />
        <Route path="/dashboard" element={<DashboardPage />} />
        <Route path="/devices" element={<DevicePage />} />
        <Route path="/tickets" element={<TicketPage />} />
        <Route path="/tickets/new" element={<CreateTicketPage />} />
      </Routes>
    </BrowserRouter>
  );
}

export default App;