import { useEffect, useState } from 'react';
import axios from 'axios';
import { useNavigate } from 'react-router-dom';
import Sidebar from '../components/Sidebar';
import Topbar from '../components/Topbar';

const TICKETS_API = 'http://localhost:8080/api/tickets';
const PLANS_API = 'http://localhost:8080/api/maintenance-plans';

export default function DashboardPage() {
    const navigate = useNavigate();
    const [user, setUser] = useState(null);
    const [stats, setStats] = useState({ totalDevices: 0, pendingTickets: 0, processingTickets: 0, completedTickets: 0 });
    const [warnings, setWarnings] = useState([]);

    useEffect(() => {
        const userData = localStorage.getItem('user');
        if (!userData) {
            navigate('/');
            return;
        }
        setUser(JSON.parse(userData));

        const fetchData = async () => {
            try {
                // Fetch stats from backend endpoint (still available for total devices)
                const statRes = await axios.get('http://localhost:8080/api/dashboard/stats');
                
                // Fetch tickets to calculate counts by status
                const ticketRes = await axios.get(TICKETS_API);
                const tickets = ticketRes.data;
                const pending = tickets.filter(t => t.trangThai === 'CHO_PHAN_CONG').length;
                const processing = tickets.filter(t => t.trangThai === 'DA_PHAN_CONG' || t.trangThai === 'DANG_XU_LY').length;
                const completed = tickets.filter(t => t.trangThai === 'HOAN_THANH').length;

                setStats({
                    totalDevices: statRes.data.totalDevices || 0,
                    pendingTickets: pending,
                    processingTickets: processing,
                    completedTickets: completed,
                    totalTickets: tickets.length
                });

                // Fetch maintenance plan alerts
                const alertRes = await axios.get(`${PLANS_API}/alerts`);
                const alerts = alertRes.data;
                
                const calculatedWarnings = alerts
                    .map(p => ({
                        id: p.id,
                        tenThietBi: p.thietBi?.tenThietBi || 'Thiết bị không xác định',
                        days: p.daysRemaining,
                        isOverdue: p.alertStatus === 'DANGER',
                        alertStatus: p.alertStatus,
                        statusBadge: p.statusBadge,
                        date: p.ngayBaoTriTiepTheo ? new Date(p.ngayBaoTriTiepTheo).toLocaleDateString('vi-VN') : 'N/A'
                    }))
                    .sort((a, b) => a.days - b.days);

                setWarnings(calculatedWarnings);
            } catch (err) {
                console.error("Lỗi lấy dữ liệu dashboard:", err);
            }
        };

        fetchData();
    }, [navigate]);

    if (!user) return null;

    return (
        <div id="wrapper">
            <Sidebar />

            <div id="content-wrapper" className="d-flex flex-column" style={{ minHeight: '100vh', width: '100%' }}>
                <div id="content">
                    <Topbar title="BẢNG ĐIỀU KHIỂN TRUNG TÂM" user={user} />

                    <div className="container-fluid">
                        {/* Khu vực Cảnh Báo */}
                        <div className="alert alert-danger shadow mb-4 border-left-danger" role="alert">
                            <h5 className="alert-heading font-weight-bold">
                                <i className="fas fa-exclamation-triangle"></i> HẠNG MỤC YÊU CẦU BẢO TRÌ
                            </h5>
                            <hr />
                            {warnings.length === 0 ? (
                                <p className="mb-0 font-weight-bold text-success"><i className="fas fa-check-circle"></i> Không có thiết bị nào quá hạn hoặc sắp đến hạn bảo trì.</p>
                            ) : (
                                <ul className="mb-0 font-weight-bold" style={{ fontSize: '0.95rem', listStyleType: 'none', paddingLeft: 0 }}>
                                    {warnings.map((w, idx) => {
                                        let badgeClass = 'badge-success';
                                        if (w.alertStatus === 'DANGER') {
                                            badgeClass = 'badge-danger';
                                        } else if (w.alertStatus === 'WARNING') {
                                            badgeClass = 'badge-warning text-dark';
                                        }
                                        
                                        return (
                                            <li key={idx} className="mb-2">
                                                • <b>{w.tenThietBi}</b> - {' '}
                                                <span className={`badge ${badgeClass}`}>
                                                    {w.statusBadge} ({w.date})
                                                </span>
                                            </li>
                                        );
                                    })}
                                </ul>
                            )}
                        </div>

                        {/* Thống kê Tổng Quan */}
                        <div className="row">
                            <div className="col-xl-3 col-md-6 mb-4">
                                <div className="card border-left-primary shadow h-100 py-2">
                                    <div className="card-body">
                                        <div className="row no-gutters align-items-center">
                                            <div className="col mr-2">
                                                <div className="text-xs font-weight-bold text-primary text-uppercase mb-1">Thiết Bị Đang Quản Lý</div>
                                                <div className="h5 mb-0 font-weight-bold text-gray-800">{stats.totalDevices} Thiết bị</div>
                                            </div>
                                            <div className="col-auto"><i className="fas fa-tools fa-2x text-gray-300"></i></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <div className="col-xl-3 col-md-6 mb-4">
                                <div className="card border-left-danger shadow h-100 py-2">
                                    <div className="card-body">
                                        <div className="row no-gutters align-items-center">
                                            <div className="col mr-2">
                                                <div className="text-xs font-weight-bold text-danger text-uppercase mb-1">Phiếu Đang Chờ (Chưa Giao)</div>
                                                <div className="h5 mb-0 font-weight-bold text-gray-800">{stats.pendingTickets} Phiếu</div>
                                            </div>
                                            <div className="col-auto"><i className="fas fa-exclamation-circle fa-2x text-gray-300"></i></div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div className="col-xl-3 col-md-6 mb-4">
                                <div className="card border-left-warning shadow h-100 py-2">
                                    <div className="card-body">
                                        <div className="row no-gutters align-items-center">
                                            <div className="col mr-2">
                                                <div className="text-xs font-weight-bold text-warning text-uppercase mb-1">Đang Xử Lý</div>
                                                <div className="h5 mb-0 font-weight-bold text-gray-800">{stats.processingTickets} Phiếu</div>
                                            </div>
                                            <div className="col-auto"><i className="fas fa-spinner fa-2x text-gray-300"></i></div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div className="col-xl-3 col-md-6 mb-4">
                                <div className="card border-left-success shadow h-100 py-2">
                                    <div className="card-body">
                                        <div className="row no-gutters align-items-center">
                                            <div className="col mr-2">
                                                <div className="text-xs font-weight-bold text-success text-uppercase mb-1">Đã Hoàn Thành</div>
                                                <div className="h5 mb-0 font-weight-bold text-gray-800">{stats.completedTickets} Phiếu</div>
                                            </div>
                                            <div className="col-auto"><i className="fas fa-check-circle fa-2x text-gray-300"></i></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    );
}