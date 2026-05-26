import { Link } from 'react-router-dom';

export default function Sidebar() {
    return (
        <ul className="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">
            {/* Tiêu đề hệ thống */}
            <Link className="sidebar-brand d-flex align-items-center justify-content-center" to="/dashboard">
                <div className="sidebar-brand-icon rotate-n-15">
                    <i className="fas fa-building"></i>
                </div>
                <div className="sidebar-brand-text mx-3">BMS APARTMENT</div>
            </Link>
            <hr className="sidebar-divider my-0" />

            {/* 1. Phân hệ Tổng quan */}
            <li className="nav-item">
                <Link className="nav-link" to="/dashboard">
                    <i className="fas fa-fw fa-tachometer-alt"></i>
                    <span>📊 Tổng quan & Báo cáo</span>
                </Link>
            </li>

            <hr className="sidebar-divider" />

            {/* 2. Quản lý Thiết bị */}
            <li className="nav-item">
                <Link className="nav-link" to="/devices">
                    <i className="fas fa-fw fa-boxes"></i>
                    <span>🏢 Quản lý Thiết bị</span>
                </Link>
            </li>

            {/* 3. Kế hoạch Bảo trì */}
            <li className="nav-item" style={{ opacity: 0.7 }}>
                <a className="nav-link" href="#" onClick={(e) => e.preventDefault()}>
                    <i className="fas fa-fw fa-calendar-check"></i>
                    <span>📅 Kế hoạch Bảo trì</span>
                </a>
            </li>

            {/* 4. Điều phối Sự cố */}
            <li className="nav-item">
                <Link className="nav-link" to="/tickets">
                    <i className="fas fa-fw fa-ticket-alt"></i>
                    <span>🎟️ Điều phối Sự cố</span>
                </Link>
            </li>

            {/* 5. Nhân sự Kỹ thuật */}
            <li className="nav-item" style={{ opacity: 0.7 }}>
                <a className="nav-link" href="#" onClick={(e) => e.preventDefault()}>
                    <i className="fas fa-fw fa-users"></i>
                    <span>👷 Nhân sự Kỹ thuật</span>
                </a>
            </li>

            {/* 6. Đơn vị Bảo trì */}
            <li className="nav-item" style={{ opacity: 0.7 }}>
                <a className="nav-link" href="#" onClick={(e) => e.preventDefault()}>
                    <i className="fas fa-fw fa-handshake"></i>
                    <span>🤝 Đơn vị Bảo trì</span>
                </a>
            </li>
        </ul>
    );
}