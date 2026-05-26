import { useEffect, useState } from 'react';
import axios from 'axios';
import { useNavigate } from 'react-router-dom';
import Sidebar from '../components/Sidebar';
import Topbar from '../components/Topbar';

export default function CreateTicketPage() {
    const navigate = useNavigate();
    const [user] = useState(JSON.parse(localStorage.getItem('user')));
    const [devices, setDevices] = useState([]);

    // Khởi tạo state lưu trữ dữ liệu form
    const [formData, setFormData] = useState({
        tieuDe: '',
        thietBiId: '',
        mucDoUuTien: 'CAO',
        moTaLoi: ''
    });

    // Vừa vào trang là lấy ngay danh sách thiết bị để đổ vào Dropdown
    useEffect(() => {
        axios.get('http://localhost:8080/api/devices')
            .then(res => setDevices(res.data))
            .catch(err => console.error("Lỗi lấy danh sách thiết bị:", err));
    }, []);

    const handleSubmit = async (e) => {
        e.preventDefault(); // Ngăn trình duyệt tự động tải lại trang

        // 1. Kiểm tra thủ công (Bypass lỗi bong bóng của HTML5)
        if (!formData.tieuDe || !formData.thietBiId || !formData.moTaLoi) {
            alert("⚠️ Vui lòng điền đầy đủ thông tin vào các ô có dấu * (Tiêu đề, Thiết bị, Mô tả).");
            return;
        }

        try {
            // 2. Bắn dữ liệu xuống Spring Boot
            await axios.post('http://localhost:8080/api/tickets/public', null, {
                params: {
                    thietBiId: formData.thietBiId,
                    tieuDe: formData.tieuDe,
                    moTaLoi: formData.moTaLoi,
                    mucDoUuTien: formData.mucDoUuTien
                }
            });
            alert("✅ Tạo phiếu báo sự cố thành công!");
            navigate('/tickets'); // Tự động quay về trang danh sách
        } catch (error) {
            console.error("Chi tiết lỗi:", error);
            alert("❌ Lỗi kết nối với Backend! Hãy nhấn F12 chuyển sang tab Console để xem chi tiết.");
        }
    };

    return (
        <div id="wrapper">
            <Sidebar />
            <div id="content-wrapper" className="d-flex flex-column">
                <div id="content">
                    <Topbar title="QUẦY LỄ TÂN - TIẾP NHẬN BÁO HỎNG" user={user} />
                    <div className="container-fluid d-flex justify-content-center">
                        <div className="card shadow mb-4" style={{ width: '800px' }}>
                            <div className="card-header py-3 bg-primary text-white">
                                <h6 className="m-0 font-weight-bold">
                                    <i className="fas fa-edit"></i> Khởi tạo phiếu báo sự cố kỹ thuật (Ticket)
                                </h6>
                            </div>
                            <div className="card-body text-dark">
                                <form onSubmit={handleSubmit}>
                                    <div className="form-group">
                                        <label className="font-weight-bold">Tiêu đề sự cố *</label>
                                        <input
                                            type="text"
                                            className="form-control"
                                            placeholder="Vd: Cháy bóng đèn hành lang..."
                                            required
                                            value={formData.tieuDe}
                                            onChange={(e) => setFormData({ ...formData, tieuDe: e.target.value })}
                                        />
                                    </div>
                                    <div className="row">
                                        <div className="col-md-6 form-group">
                                            <label className="font-weight-bold">Thiết bị liên quan *</label>
                                            <select
                                                className="form-control"
                                                required
                                                value={formData.thietBiId}
                                                onChange={(e) => setFormData({ ...formData, thietBiId: e.target.value })}
                                            >
                                                <option value="">-- Chọn thiết bị đang lỗi --</option>
                                                {devices.map(d => (
                                                    <option key={d.id} value={d.id}>{d.tenThietBi} ({d.viTri})</option>
                                                ))}
                                            </select>
                                        </div>
                                        <div className="col-md-6 form-group">
                                            <label className="font-weight-bold">Mức độ ưu tiên *</label>
                                            <select
                                                className="form-control text-danger font-weight-bold"
                                                value={formData.mucDoUuTien}
                                                onChange={(e) => setFormData({ ...formData, mucDoUuTien: e.target.value })}
                                            >
                                                <option value="CAO">Cao (High Alert)</option>
                                                <option className="text-warning" value="TRUNG BINH">Trung bình</option>
                                                <option className="text-secondary" value="THAP">Thấp</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div className="form-group">
                                        <label className="font-weight-bold">Mô tả hiện trạng lỗi chi tiết *</label>
                                        <textarea
                                            className="form-control"
                                            rows="4"
                                            required
                                            placeholder="Mô tả chi tiết để thợ mang đúng đồ nghề..."
                                            value={formData.moTaLoi}
                                            onChange={(e) => setFormData({ ...formData, moTaLoi: e.target.value })}
                                        ></textarea>
                                    </div>
                                    <div className="text-right">
                                        <button type="button" onClick={() => navigate('/tickets')} className="btn btn-secondary mr-2 font-weight-bold">Hủy bỏ</button>
                                        <button type="submit" className="btn btn-primary font-weight-bold">Xác Nhận Tạo Ticket</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    );
}