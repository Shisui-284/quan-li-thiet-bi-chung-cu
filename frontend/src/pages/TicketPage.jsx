import { useEffect, useState } from 'react';
import axios from 'axios';
import { useNavigate } from 'react-router-dom';
import Sidebar from '../components/Sidebar';
import Topbar from '../components/Topbar';

export default function TicketPage() {
    const [tickets, setTickets] = useState([]);
    const [user] = useState(JSON.parse(localStorage.getItem('user')));
    const navigate = useNavigate();

    // Hàm tải danh sách phiếu
    const fetchTickets = () => {
        axios.get('http://localhost:8080/api/tickets')
            .then(res => setTickets(res.data))
            .catch(err => console.error("Lỗi lấy danh sách phiếu:", err));
    };

    useEffect(() => {
        fetchTickets();
    }, []);

    // Hàm gọi API giao việc cho thợ (Sử dụng ID thợ mặc định là 2 - kythuat01)
    const handleAssign = async (ticketId) => {
        if (window.confirm("Bạn muốn giao phiếu này cho nhân viên kỹ thuật [kythuat01]?")) {
            try {
                // Mã thợ (techId) đang được gán cứng là 2 dựa trên file DataInitializer
                await axios.put(`http://localhost:8080/api/tickets/${ticketId}/assign?techId=2`);
                alert("Đã phân công thành công!");
                fetchTickets(); // Tải lại bảng để cập nhật trạng thái
            } catch (error) {
                alert("Lỗi khi phân công: " + (error.response?.data || error.message));
            }
        }
    };

    return (
        <div id="wrapper">
            <Sidebar />
            <div id="content-wrapper" className="d-flex flex-column">
                <div id="content">
                    <Topbar title="QUẢN LÝ SỰ CỐ (TICKETS)" user={user} />

                    <div className="container-fluid">
                        <div className="card shadow mb-4">
                            <div className="card-header py-3 bg-light d-flex justify-content-between align-items-center">
                                <h6 className="m-0 font-weight-bold text-primary">Danh sách phiếu báo hỏng</h6>
                                <button onClick={() => navigate('/tickets/new')} className="btn btn-sm btn-success font-weight-bold">
                                    <i className="fas fa-plus"></i> Tạo Phiếu Mới
                                </button>
                            </div>

                            <div className="card-body">
                                <table className="table table-bordered text-dark">
                                    <thead className="bg-primary text-white text-center">
                                        <tr>
                                            <th>Mã Phiếu</th>
                                            <th>Tiêu Đề</th>
                                            <th>Thiết Bị Lỗi</th>
                                            <th>Trạng Thái</th>
                                            <th>Thao Tác</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        {tickets.map(t => (
                                            <tr key={t.id}>
                                                <td className="text-center font-weight-bold">#TK-{t.id}</td>
                                                <td>
                                                    {t.tieuDe}
                                                    <div className="small text-danger font-weight-bold mt-1">Mức độ: {t.mucDoUuTien}</div>
                                                </td>
                                                <td>{t.thietBi?.tenThietBi}</td>
                                                <td className="text-center align-middle">
                                                    <span className={`badge p-2 ${t.trangThai === 'CHO_PHAN_CONG' ? 'badge-warning text-dark' : 'badge-primary'}`}>
                                                        {t.trangThai}
                                                    </span>
                                                </td>
                                                <td className="text-center align-middle">
                                                    {/* Chỉ hiện nút Giao việc nếu phiếu đang chờ */}
                                                    {t.trangThai === 'CHO_PHAN_CONG' ? (
                                                        <button onClick={() => handleAssign(t.id)} className="btn btn-sm btn-primary font-weight-bold">
                                                            <i className="fas fa-user-plus"></i> Giao việc
                                                        </button>
                                                    ) : (
                                                        <span className="text-success font-weight-bold small"><i className="fas fa-check"></i> Đã giao</span>
                                                    )}
                                                </td>
                                            </tr>
                                        ))}
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    );
}