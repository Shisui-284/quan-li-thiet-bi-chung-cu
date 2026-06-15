import React, { useEffect, useState } from 'react';
import axios from 'axios';

export default function CreateTicketPage() {
    const [devices, setDevices] = useState([]);
    const [formData, setFormData] = useState({
        tieuDe: '',
        maThietBi: '',
        mucDoUuTien: 'TRUNG_BINH',
        moTaLoi: ''
    });
    const [loading, setLoading] = useState(false);
    const [success, setSuccess] = useState(false);

    useEffect(() => {
        // Lấy danh sách thiết bị
        axios.get('http://localhost:8080/api/devices')
            .then(res => setDevices(res.data))
            .catch(err => console.error("Lỗi lấy danh sách thiết bị:", err));
    }, []);

    const handleSubmit = async (e) => {
        e.preventDefault();
        setLoading(true);

        try {
            await axios.post('http://localhost:8080/api/tickets/public', {
                maThietBi: formData.maThietBi,
                tieuDe: formData.tieuDe,
                moTaLoi: formData.moTaLoi,
                mucDoUuTien: formData.mucDoUuTien
            });
            setSuccess(true);
            setFormData({ tieuDe: '', maThietBi: '', mucDoUuTien: 'TRUNG_BINH', moTaLoi: '' });
        } catch (error) {
            alert("❌ Lỗi kết nối với máy chủ! Vui lòng thử lại sau.");
        } finally {
            setLoading(false);
        }
    };

    if (success) {
        return (
            <div className="d-flex align-items-center justify-content-center" style={{ minHeight: '100vh', backgroundColor: '#f4f6f9' }}>
                <div className="card shadow-lg border-0 rounded-lg p-5 text-center" style={{ maxWidth: '500px' }}>
                    <i className="fas fa-check-circle fa-5x text-success mb-4"></i>
                    <h3 className="font-weight-bold text-dark">Gửi Yêu Cầu Thành Công!</h3>
                    <p className="text-muted mt-2">Cảm ơn bạn đã thông báo. Bộ phận kỹ thuật sẽ tiếp nhận và xử lý sự cố trong thời gian sớm nhất.</p>
                    <button onClick={() => setSuccess(false)} className="btn btn-primary btn-block mt-4 fw-bold p-3">
                        GỬI THÊM YÊU CẦU KHÁC
                    </button>
                </div>
            </div>
        );
    }

    return (
        <div className="d-flex align-items-center justify-content-center" style={{ minHeight: '100vh', backgroundColor: '#e9ecef' }}>
            <div className="container">
                <div className="row justify-content-center">
                    <div className="col-lg-7 col-md-9">
                        <div className="card shadow-lg border-0 rounded-lg mt-5 mb-5">
                            <div className="card-header bg-primary text-white text-center py-4">
                                <h3 className="font-weight-light my-2 fw-bold">
                                    <i className="fas fa-headset mr-2"></i> CỔNG TIẾP NHẬN SỰ CỐ
                                </h3>
                                <p className="m-0 small">Dành cho Cư dân & Lễ tân tòa nhà</p>
                            </div>
                            <div className="card-body p-5">
                                <form onSubmit={handleSubmit}>
                                    <div className="form-group mb-4">
                                        <label className="font-weight-bold text-dark mb-2">Tiêu đề sự cố <span className="text-danger">*</span></label>
                                        <input
                                            type="text"
                                            className="form-control form-control-lg bg-light"
                                            placeholder="Ví dụ: Rò rỉ nước ở hành lang tầng 3..."
                                            required
                                            value={formData.tieuDe}
                                            onChange={(e) => setFormData({ ...formData, tieuDe: e.target.value })}
                                        />
                                    </div>
                                    
                                    <div className="form-group mb-4">
                                        <label className="font-weight-bold text-dark mb-2">Thiết bị / Khu vực <span className="text-danger">*</span></label>
                                        <select
                                            className="form-control form-control-lg bg-light"
                                            required
                                            value={formData.maThietBi}
                                            onChange={(e) => setFormData({ ...formData, maThietBi: e.target.value })}
                                        >
                                            <option value="" disabled>-- Hãy chọn khu vực gặp sự cố --</option>
                                            {devices.map(d => (
                                                <option key={d.id} value={d.id}>{d.tenThietBi} - {d.viTri}</option>
                                            ))}
                                        </select>
                                    </div>

                                    <div className="form-group mb-4">
                                        <label className="font-weight-bold text-dark mb-2">Mức độ khẩn cấp <span className="text-danger">*</span></label>
                                        <select
                                            className="form-control form-control-lg bg-light text-danger fw-bold"
                                            value={formData.mucDoUuTien}
                                            onChange={(e) => setFormData({ ...formData, mucDoUuTien: e.target.value })}
                                        >
                                            <option value="CAO" className="text-danger">🔴 Khẩn Cấp (Xử lý ngay lập tức)</option>
                                            <option value="TRUNG_BINH" className="text-warning">🟡 Trung bình (Xử lý trong ngày)</option>
                                            <option value="THAP" className="text-dark">🟢 Thấp (Có thể xử lý sau)</option>
                                        </select>
                                    </div>

                                    <div className="form-group mb-5">
                                        <label className="font-weight-bold text-dark mb-2">Mô tả chi tiết <span className="text-danger">*</span></label>
                                        <textarea
                                            className="form-control bg-light"
                                            rows="4"
                                            required
                                            placeholder="Vui lòng cung cấp thêm thông tin chi tiết về tình trạng hỏng hóc..."
                                            value={formData.moTaLoi}
                                            onChange={(e) => setFormData({ ...formData, moTaLoi: e.target.value })}
                                        ></textarea>
                                    </div>

                                    <div className="form-group text-center mb-0">
                                        <button 
                                            type="submit" 
                                            className="btn btn-primary btn-lg btn-block fw-bold shadow-sm p-3"
                                            disabled={loading}
                                        >
                                            {loading ? <i className="fas fa-spinner fa-spin"></i> : <i className="fas fa-paper-plane mr-2"></i>} 
                                            {loading ? ' ĐANG GỬI...' : ' GỬI YÊU CẦU XỬ LÝ'}
                                        </button>
                                    </div>
                                </form>
                            </div>
                            <div className="card-footer text-center py-3 bg-light">
                                <div className="small text-muted">Ban Quản Lý Tòa Nhà BMS Apartment &copy; 2026</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    );
}