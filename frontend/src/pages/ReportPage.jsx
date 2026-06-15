import React, { useEffect, useState } from "react";
import { Link, useNavigate } from "react-router-dom";
import axios from "axios";

export default function ReportPage() {
    const [devices, setDevices] = useState([]);
    const [formData, setFormData] = useState({ maThietBi: "", tieuDe: "", moTaLoi: "", mucDoUuTien: "TRUNG_BINH" });
    const [loading, setLoading] = useState(false);
    const navigate = useNavigate();

    useEffect(() => {
        // Fetch danh sách thiết bị
        axios.get("http://localhost:8080/tech/devices")
            .then(res => {
                setDevices(res.data);
                if (res.data.length > 0) {
                    setFormData(prev => ({ ...prev, maThietBi: res.data[0].id }));
                }
            })
            .catch(err => console.error("Lỗi lấy danh sách thiết bị:", err));
    }, []);

    const handleSubmit = async (e) => {
        e.preventDefault();
        setLoading(true);
        try {
            await axios.post("http://localhost:8080/tech/report", formData);
            alert("✅ Báo hỏng nhanh thành công! Lễ tân/Admin sẽ điều phối sau.");
            navigate("/tech-mobile");
        } catch (err) {
            alert("❌ Có lỗi xảy ra khi báo cáo.");
        } finally {
            setLoading(false);
        }
    };

    return (
        <div style={{ backgroundColor: '#f8f9fa', minHeight: '100vh', paddingBottom: '70px' }}>
            <div className="bg-warning text-dark p-3 shadow-sm text-center">
                <h5 className="m-0 fw-bold"><i className="fas fa-bolt"></i> Báo Hỏng Nhanh</h5>
            </div>
            
            <div className="container mt-3">
                <div className="card shadow-sm border-0 border-top-warning" style={{ borderTop: '4px solid #f6c23e' }}>
                    <div className="card-body">
                        <p className="text-muted small mb-4">Sử dụng tính năng này khi bạn phát hiện sự cố ngoài luồng trong quá trình đi tuần tra tòa nhà.</p>
                        
                        <form onSubmit={handleSubmit}>
                            <div className="form-group mb-3">
                                <label className="fw-bold small text-dark">Tiêu đề sự cố <span className="text-danger">*</span></label>
                                <input 
                                    className="form-control bg-light" 
                                    required 
                                    placeholder="VD: Rò rỉ ống nước..."
                                    value={formData.tieuDe}
                                    onChange={e => setFormData({...formData, tieuDe: e.target.value})} 
                                />
                            </div>

                            <div className="form-group mb-3">
                                <label className="fw-bold small text-dark">Thiết bị / Khu vực <span className="text-danger">*</span></label>
                                <select 
                                    className="form-control bg-light" 
                                    required
                                    value={formData.maThietBi}
                                    onChange={e => setFormData({...formData, maThietBi: e.target.value})}
                                >
                                    {devices.map(d => (
                                        <option key={d.id} value={d.id}>{d.tenThietBi} - {d.viTri}</option>
                                    ))}
                                </select>
                            </div>

                            <div className="form-group mb-3">
                                <label className="fw-bold small text-dark">Mức độ ưu tiên</label>
                                <select 
                                    className="form-control bg-light text-danger fw-bold" 
                                    value={formData.mucDoUuTien}
                                    onChange={e => setFormData({...formData, mucDoUuTien: e.target.value})}
                                >
                                    <option value="THAP" className="text-dark">Thấp (Xử lý trong 48h)</option>
                                    <option value="TRUNG_BINH" className="text-warning">Trung Bình (Xử lý trong 24h)</option>
                                    <option value="CAO" className="text-danger">Khẩn Cấp (Xử lý ngay)</option>
                                </select>
                            </div>

                            <div className="form-group mb-4">
                                <label className="fw-bold small text-dark">Mô tả chi tiết</label>
                                <textarea 
                                    className="form-control bg-light" 
                                    rows="3" 
                                    placeholder="Tình trạng hỏng hóc thực tế..."
                                    value={formData.moTaLoi}
                                    onChange={e => setFormData({...formData, moTaLoi: e.target.value})} 
                                />
                            </div>

                            <button type="submit" className="btn btn-warning w-100 fw-bold py-3 shadow text-dark" disabled={loading}>
                                {loading ? "ĐANG GỬI..." : <><i className="fas fa-paper-plane"></i> GỬI BÁO CÁO SỰ CỐ</>}
                            </button>
                        </form>
                    </div>
                </div>
            </div>

            {/* Bottom Navigation */}
            <div className="bg-white border-top shadow-lg" style={{ position: 'fixed', bottom: 0, left: 0, width: '100%', display: 'flex', zIndex: 1000 }}>
                <Link to="/tech-mobile" className="btn text-secondary flex-fill py-3 border-right">
                    <i className="fas fa-clipboard-list d-block fa-lg mb-1 text-primary"></i> Nhiệm vụ
                </Link>
                <Link to="/tech-mobile/report" className="btn text-warning flex-fill py-3 border-right fw-bold" style={{ backgroundColor: '#fff9e6' }}>
                    <i className="fas fa-exclamation-triangle d-block fa-lg mb-1 text-warning"></i> Báo hỏng
                </Link>
                <Link to="/tech-mobile/history" className="btn text-secondary flex-fill py-3">
                    <i className="fas fa-history d-block fa-lg mb-1 text-success"></i> Lịch sử
                </Link>
            </div>
        </div>
    );
}