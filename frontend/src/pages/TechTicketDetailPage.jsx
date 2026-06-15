import { useEffect, useState } from "react";
import { useParams, useNavigate, Link } from "react-router-dom";
import axios from "axios";

export default function TechTicketDetailPage() {
    const { id } = useParams();
    const [ticket, setTicket] = useState(null);
    const [ghiChu, setGhiChu] = useState("");
    const [loading, setLoading] = useState(false);
    const navigate = useNavigate();

    useEffect(() => {
        axios.get(`http://localhost:8080/tech/ticket/${id}`)
            .then(res => setTicket(res.data))
            .catch(err => {
                console.error(err);
                alert("Lỗi tải chi tiết phiếu!");
            });
    }, [id]);

    const handleComplete = async () => {
        if (!ghiChu.trim()) {
            alert("Vui lòng nhập ghi chú kết quả sửa chữa!");
            return;
        }
        setLoading(true);
        try {
            await axios.put(`http://localhost:8080/tech/ticket/${id}/complete`, { ghiChuKetQua: ghiChu });
            alert("✅ Đã cập nhật trạng thái Hoàn thành!");
            navigate("/tech-mobile");
        } catch (err) {
            alert("❌ Lỗi khi cập nhật!");
        } finally {
            setLoading(false);
        }
    };

    if (!ticket) return <div className="text-center mt-5"><i className="fas fa-spinner fa-spin fa-2x text-primary"></i></div>;

    return (
        <div style={{ backgroundColor: '#f8f9fa', minHeight: '100vh', paddingBottom: '70px' }}>
            <div className="bg-primary text-white p-3 shadow-sm d-flex align-items-center">
                <button className="btn btn-link text-white p-0 mr-3" onClick={() => navigate(-1)}>
                    <i className="fas fa-arrow-left fa-lg"></i>
                </button>
                <h5 className="m-0 fw-bold">Chi tiết công việc</h5>
            </div>

            <div className="container mt-3">
                <div className="card shadow-sm border-0 mb-3">
                    <div className="card-body">
                        <span className="badge badge-danger mb-2">ƯU TIÊN: {ticket.mucDoUuTien}</span>
                        <h5 className="fw-bold text-dark">{ticket.tieuDe}</h5>
                        
                        <hr />
                        
                        <p className="mb-1"><i className="fas fa-tools text-secondary"></i> <strong>Thiết bị:</strong> {ticket.thietBi?.tenThietBi}</p>
                        <p className="mb-1"><i className="fas fa-map-marker-alt text-danger"></i> <strong>Vị trí:</strong> {ticket.thietBi?.viTri}</p>
                        <p className="mb-1"><i className="fas fa-clock text-info"></i> <strong>Thời gian tạo:</strong> {new Date(ticket.ngayTao).toLocaleString('vi-VN')}</p>
                        
                        <hr />
                        
                        <p className="mb-1 fw-bold">Mô tả sự cố:</p>
                        <div className="p-2 bg-light rounded text-dark" style={{ minHeight: '80px' }}>
                            {ticket.moTaLoi || "Không có mô tả chi tiết."}
                        </div>
                    </div>
                </div>

                <div className="card shadow-sm border-0 border-left-success" style={{ borderLeft: '4px solid #1cc88a' }}>
                    <div className="card-body">
                        <h6 className="fw-bold text-success mb-3"><i className="fas fa-clipboard-check"></i> Báo cáo kết quả</h6>
                        <textarea 
                            className="form-control mb-3" 
                            rows="4" 
                            placeholder="Nhập ghi chú sửa chữa, linh kiện đã thay thế (Bắt buộc)..." 
                            value={ghiChu}
                            onChange={(e) => setGhiChu(e.target.value)} 
                        />
                        <button 
                            className="btn btn-success w-100 fw-bold py-2 shadow-sm" 
                            onClick={handleComplete}
                            disabled={loading}
                        >
                            {loading ? "ĐANG XỬ LÝ..." : <><i className="fas fa-check-circle"></i> HOÀN THÀNH CÔNG VIỆC</>}
                        </button>
                    </div>
                </div>
            </div>
        </div>
    );
}