import React, { useEffect, useState } from "react";
import { Link, useNavigate } from "react-router-dom";
import axios from "axios";

export default function TechMyTicketsPage() {
    const [tickets, setTickets] = useState([]);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState(null);
    const [user, setUser] = useState(null);
    const navigate = useNavigate();

    useEffect(() => {
        const userJson = localStorage.getItem("user");
        if (!userJson) {
            navigate("/login");
            return;
        }

        const parsedUser = JSON.parse(userJson);
        setUser(parsedUser);
        const username = parsedUser.tenDangNhap;

        const fetchTickets = async () => {
            try {
                setLoading(true);
                const response = await axios.get(`http://localhost:8080/tech/my-tickets?username=${username}`);
                // Chỉ hiển thị các phiếu chưa hoàn thành (Chờ xử lý hoặc Đang xử lý)
                const pendingTickets = response.data.filter(t => t.trangThai !== 'HOAN_THANH');
                setTickets(pendingTickets);
            } catch (err) {
                console.error("Lỗi lấy dữ liệu:", err);
                setError("Không thể tải danh sách phiếu. Vui lòng thử lại sau.");
            } finally {
                setLoading(false);
            }
        };

        fetchTickets();
    }, [navigate]);

    const handleLogout = () => {
        localStorage.clear();
        navigate('/login');
    };

    return (
        <div style={{ backgroundColor: '#f8f9fa', minHeight: '100vh', paddingBottom: '70px' }}>
            <div className="bg-primary text-white p-3 shadow-sm d-flex justify-content-between align-items-center">
                <h5 className="m-0 fw-bold">📋 Nhiệm vụ của tôi</h5>
                <div className="d-flex align-items-center">
                    <span className="small mr-3"><i className="fas fa-user-circle"></i> {user?.hoTen || user?.tenDangNhap}</span>
                    <button onClick={handleLogout} className="btn btn-sm btn-danger fw-bold"><i className="fas fa-sign-out-alt"></i></button>
                </div>
            </div>
            
            <div className="container mt-3">
                {error && <div className="alert alert-danger">{error}</div>}
                {loading && <div className="text-center mt-5 text-primary"><i className="fas fa-spinner fa-spin fa-2x"></i></div>}

                {!loading && tickets.length === 0 ? (
                    <div className="text-center text-muted mt-5 pt-5">
                        <i className="fas fa-check-circle fa-4x mb-3 text-success"></i>
                        <h5>Tuyệt vời!</h5>
                        <p>Bạn không có nhiệm vụ nào đang chờ xử lý.</p>
                    </div>
                ) : (
                    tickets.map((t) => (
                        <div key={t.id} className="card mb-3 shadow-sm border-0 border-left-primary" style={{ borderLeft: '4px solid #4e73df' }}>
                            <div className="card-body">
                                <div className="d-flex justify-content-between">
                                    <span className="badge badge-warning text-dark mb-2">{t.trangThai === 'CHO_PHAN_CONG' ? 'Chờ Phân Công' : t.trangThai === 'DA_PHAN_CONG' ? 'Đã Giao' : t.trangThai}</span>
                                    <span className="small text-danger fw-bold">{t.mucDoUuTien}</span>
                                </div>
                                <h6 className="fw-bold text-dark text-uppercase">{t.tieuDe}</h6>
                                <p className="small text-muted mb-2"><i className="fas fa-map-marker-alt text-danger"></i> {t.thietBi?.viTri || "Vị trí không xác định"} ({t.thietBi?.tenThietBi})</p>
                                <Link to={`/tech-mobile/ticket/${t.id}`} className="btn btn-primary btn-sm w-100 fw-bold mt-2">
                                    <i className="fas fa-wrench"></i> XỬ LÝ NGAY
                                </Link>
                            </div>
                        </div>
                    ))
                )}
            </div>

            {/* Bottom Navigation */}
            <div className="bg-white border-top shadow-lg" style={{ position: 'fixed', bottom: 0, left: 0, width: '100%', display: 'flex', zIndex: 1000 }}>
                <Link to="/tech-mobile" className="btn text-primary flex-fill py-3 fw-bold border-right" style={{ backgroundColor: '#f0f4ff' }}>
                    <i className="fas fa-clipboard-list d-block fa-lg mb-1"></i> Nhiệm vụ
                </Link>
                <Link to="/tech-mobile/report" className="btn text-secondary flex-fill py-3 border-right">
                    <i className="fas fa-exclamation-triangle d-block fa-lg mb-1 text-warning"></i> Báo hỏng
                </Link>
                <Link to="/tech-mobile/history" className="btn text-secondary flex-fill py-3">
                    <i className="fas fa-history d-block fa-lg mb-1 text-success"></i> Lịch sử
                </Link>
            </div>
        </div>
    );
}