import React, { useEffect, useState } from "react";
import { Link, useNavigate } from "react-router-dom";
import axios from "axios";

function TechMyTicketsPage() {
    const [tickets, setTickets] = useState([]);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState(null);
    const navigate = useNavigate();

    useEffect(() => {
        // 1. Kiểm tra xác thực: Nếu không có user, đá về login
        const userJson = localStorage.getItem("user");
        if (!userJson) {
            navigate("/login");
            return;
        }

        const user = JSON.parse(userJson);
        const username = user.tenDangNhap; // Đảm bảo key này khớp với dữ liệu lúc login

        // 2. Gọi API lấy danh sách nhiệm vụ
        const fetchTickets = async () => {
            try {
                setLoading(true);
                const response = await axios.get(`http://localhost:8080/tech/my-tickets?username=${username}`);
                setTickets(response.data);
            } catch (err) {
                console.error("Lỗi lấy dữ liệu:", err);
                setError("Không thể tải danh sách phiếu. Vui lòng thử lại sau.");
            } finally {
                setLoading(false);
            }
        };

        fetchTickets();
    }, [navigate]);

    // Giao diện loading
    if (loading) return <div className="text-center mt-5">Đang tải nhiệm vụ...</div>;

    return (
        <div className="container pb-5 mb-5 p-3">
            <h4 className="mb-4">📋 Nhiệm vụ của tôi</h4>
            
            {error && <div className="alert alert-danger">{error}</div>}

            {tickets.length === 0 ? (
                <div className="text-center text-muted mt-5">Không có nhiệm vụ nào cần xử lý.</div>
            ) : (
                tickets.map((t) => (
                    <div key={t.id} className="card mb-3 shadow-sm border-0">
                        <div className="card-body">
                            <h6 className="fw-bold text-primary">{t.tieuDe}</h6>
                            <p className="small text-muted mb-2">📍 {t.thietBi?.viTri || "Vị trí không xác định"}</p>
                            <Link to={`/tech-mobile/ticket/${t.id}`} className="btn btn-primary btn-sm w-100">
                                XỬ LÝ PHIẾU
                            </Link>
                        </div>
                    </div>
                ))
            )}

            {/* Thanh điều hướng dưới cùng (Bottom Navigation) */}
            <div style={{
                position: 'fixed',
                bottom: 0,
                left: 0,
                width: '100%',
                backgroundColor: '#f8f9fa',
                borderTop: '1px solid #dee2e6',
                display: 'flex',
                justifyContent: 'space-around',
                padding: '10px 0',
                zIndex: 1000
            }}>
                <Link to="/tech-mobile" className="text-decoration-none text-primary fw-bold">📋 Nhiệm vụ</Link>
                <Link to="/tech-mobile/report" className="text-decoration-none text-warning fw-bold">➕ Báo hỏng</Link>
                <Link to="/tech-mobile/history" className="text-decoration-none text-success fw-bold">📜 Lịch sử</Link>
            </div>
        </div>
    );
}

export default TechMyTicketsPage;