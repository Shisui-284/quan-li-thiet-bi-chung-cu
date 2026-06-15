import React, { useEffect, useState } from "react";
import { Link, useNavigate } from "react-router-dom";
import axios from "axios";

export default function TechHistoryPage() {
    const [tickets, setTickets] = useState([]);
    const [loading, setLoading] = useState(true);
    const navigate = useNavigate();

    useEffect(() => {
        const userJson = localStorage.getItem("user");
        if (!userJson) {
            navigate("/login");
            return;
        }

        const username = JSON.parse(userJson).tenDangNhap;

        axios.get(`http://localhost:8080/tech/history?username=${username}`)
            .then(res => {
                setTickets(res.data);
            })
            .catch(err => console.error(err))
            .finally(() => setLoading(false));
    }, [navigate]);

    return (
        <div style={{ backgroundColor: '#f8f9fa', minHeight: '100vh', paddingBottom: '70px' }}>
            <div className="bg-success text-white p-3 shadow-sm text-center">
                <h5 className="m-0 fw-bold"><i className="fas fa-history"></i> Lịch sử nghiệm thu</h5>
            </div>
            
            <div className="container mt-3">
                {loading && <div className="text-center mt-5 text-success"><i className="fas fa-spinner fa-spin fa-2x"></i></div>}

                {!loading && tickets.length === 0 ? (
                    <div className="text-center text-muted mt-5 pt-5">
                        <i className="fas fa-folder-open fa-4x mb-3 text-secondary"></i>
                        <h5>Trống</h5>
                        <p>Bạn chưa hoàn thành công việc nào.</p>
                    </div>
                ) : (
                    tickets.map((t) => (
                        <div key={t.id} className="card mb-3 shadow-sm border-0" style={{ borderLeft: '4px solid #1cc88a' }}>
                            <div className="card-body">
                                <div className="d-flex justify-content-between">
                                    <span className="small text-muted">{new Date(t.ngayHoanThanh).toLocaleDateString('vi-VN')}</span>
                                    <span className="badge badge-success"><i className="fas fa-check"></i> Hoàn thành</span>
                                </div>
                                <h6 className="fw-bold text-dark mt-2">{t.tieuDe}</h6>
                                <p className="small text-muted mb-2"><i className="fas fa-tools"></i> {t.thietBi?.tenThietBi} - {t.thietBi?.viTri}</p>
                                <div className="p-2 bg-light rounded text-dark small font-italic">
                                    <i className="fas fa-quote-left text-success mr-1"></i> {t.ghiChuKetQua || "Không có ghi chú kết quả."}
                                </div>
                            </div>
                        </div>
                    ))
                )}
            </div>

            {/* Bottom Navigation */}
            <div className="bg-white border-top shadow-lg" style={{ position: 'fixed', bottom: 0, left: 0, width: '100%', display: 'flex', zIndex: 1000 }}>
                <Link to="/tech-mobile" className="btn text-secondary flex-fill py-3 border-right">
                    <i className="fas fa-clipboard-list d-block fa-lg mb-1 text-primary"></i> Nhiệm vụ
                </Link>
                <Link to="/tech-mobile/report" className="btn text-secondary flex-fill py-3 border-right">
                    <i className="fas fa-exclamation-triangle d-block fa-lg mb-1 text-warning"></i> Báo hỏng
                </Link>
                <Link to="/tech-mobile/history" className="btn text-success flex-fill py-3 fw-bold" style={{ backgroundColor: '#eafff5' }}>
                    <i className="fas fa-history d-block fa-lg mb-1"></i> Lịch sử
                </Link>
            </div>
        </div>
    );
}