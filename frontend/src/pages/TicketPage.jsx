import { useEffect, useState } from 'react';
import axios from 'axios';
import Sidebar from '../components/Sidebar';
import Topbar from '../components/Topbar';

const API = 'http://localhost:8080/api/tickets';
const TECH_API = 'http://localhost:8080/api/tickets/technicians';
const DEVICES_API = 'http://localhost:8080/api/devices';

const emptyTicketForm = { maThietBi: '', tieuDe: '', moTaLoi: '', mucDoUuTien: 'THAP' };

export default function TicketPage() {
    const [tickets, setTickets] = useState([]);
    const [technicians, setTechnicians] = useState([]);
    const [devices, setDevices] = useState([]);
    const [user] = useState(JSON.parse(localStorage.getItem('user')));

    const [showAssignModal, setShowAssignModal] = useState(false);
    const [showAddModal, setShowAddModal] = useState(false);
    const [selectedTicketId, setSelectedTicketId] = useState(null);
    const [selectedTechId, setSelectedTechId] = useState('');
    const [ticketForm, setTicketForm] = useState(emptyTicketForm);
    const [msg, setMsg] = useState('');

    const fetchTickets = () => axios.get(API).then(res => setTickets(res.data)).catch(console.error);
    const fetchTechnicians = () => axios.get(TECH_API).then(res => setTechnicians(res.data)).catch(console.error);
    const fetchDevices = () => axios.get(DEVICES_API).then(res => setDevices(res.data)).catch(console.error);

    useEffect(() => {
        fetchTickets();
        fetchTechnicians();
        fetchDevices();
    }, []);

    const openAssignModal = (ticketId) => {
        setSelectedTicketId(ticketId);
        setSelectedTechId(technicians[0]?.maNguoiDung || '');
        setShowAssignModal(true);
    };

    const handleAssignSubmit = async (e) => {
        e.preventDefault();
        if (!selectedTechId) return alert('Vui lòng chọn nhân viên kỹ thuật');
        try {
            await axios.put(`${API}/${selectedTicketId}/assign?techId=${selectedTechId}`);
            setMsg('✅ Đã phân công thành công!');
            setShowAssignModal(false);
            fetchTickets();
        } catch (error) {
            setMsg('❌ Lỗi khi phân công!');
        }
        setTimeout(() => setMsg(''), 4000);
    };

    const openAddModal = () => {
        setTicketForm({ ...emptyTicketForm, maThietBi: devices[0]?.id || '' });
        setShowAddModal(true);
    };

    const handleAddSubmit = async (e) => {
        e.preventDefault();
        try {
            await axios.post(`${API}/public`, ticketForm);
            setMsg('✅ Đã tạo phiếu yêu cầu mới thành công!');
            setShowAddModal(false);
            fetchTickets();
        } catch (error) {
            setMsg('❌ Lỗi khi tạo phiếu mới!');
        }
        setTimeout(() => setMsg(''), 4000);
    };

    const handleDelete = async (id) => {
        if (!window.confirm('Xác nhận xóa phiếu yêu cầu này?')) return;
        try {
            await axios.delete(`${API}/${id}`);
            setMsg('✅ Đã xóa phiếu!');
            fetchTickets();
        } catch {
            setMsg('❌ Lỗi khi xóa phiếu!');
        }
        setTimeout(() => setMsg(''), 4000);
    };

    return (
        <div id="wrapper">
            <Sidebar />
            <div id="content-wrapper" className="d-flex flex-column" style={{ minHeight: '100vh', width: '100%' }}>
                <div id="content">
                    <Topbar title="ĐIỀU PHỐI SỰ CỐ" user={user} />
                    <div className="container-fluid">
                        {msg && <div className={`alert ${msg.startsWith('✅') ? 'alert-success' : 'alert-danger'}`}>{msg}</div>}
                        <div className="card shadow mb-4">
                            <div className="card-header py-3 bg-light d-flex justify-content-between align-items-center">
                                <h6 className="m-0 font-weight-bold text-primary">🎟️ Danh sách phiếu yêu cầu xử lý</h6>
                                <button onClick={openAddModal} className="btn btn-sm btn-success font-weight-bold">
                                    <i className="fas fa-plus"></i> Tạo Phiếu Mới
                                </button>
                            </div>

                            <div className="card-body">
                                <div className="table-responsive">
                                    <table className="table table-bordered table-hover text-dark">
                                        <thead className="bg-primary text-white text-center">
                                            <tr>
                                                <th>Mã Phiếu</th>
                                                <th>Tiêu Đề & Mức Độ</th>
                                                <th>Thiết Bị Lỗi</th>
                                                <th>Người Xử Lý</th>
                                                <th>Trạng Thái</th>
                                                <th>Thao Tác</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            {tickets.length === 0 && <tr><td colSpan={6} className="text-center text-muted py-4">Chưa có phiếu yêu cầu nào</td></tr>}
                                            {tickets.map(t => (
                                                <tr key={t.id}>
                                                    <td className="text-center font-weight-bold text-primary">#TK-{t.id}</td>
                                                    <td>
                                                        <div className="font-weight-bold">{t.tieuDe}</div>
                                                        <div className="small text-danger font-weight-bold mt-1">Mức độ: {t.mucDoUuTien}</div>
                                                    </td>
                                                    <td>{t.thietBi?.tenThietBi}</td>
                                                    <td className="text-center">{t.nguoiXuLy?.hoTen || <span className="text-muted">—</span>}</td>
                                                    <td className="text-center align-middle">
                                                        <span className={`badge p-2 ${t.trangThai === 'CHO_PHAN_CONG' ? 'badge-warning text-dark' : (t.trangThai === 'HOAN_THANH' ? 'badge-success' : 'badge-primary')}`}>
                                                            {t.trangThai === 'CHO_PHAN_CONG' ? 'Chờ Phân Công' : t.trangThai === 'DA_PHAN_CONG' ? 'Đã Phân Công' : t.trangThai === 'HOAN_THANH' ? 'Hoàn Thành' : t.trangThai}
                                                        </span>
                                                    </td>
                                                    <td className="text-center align-middle">
                                                        {t.trangThai === 'CHO_PHAN_CONG' ? (
                                                            <button onClick={() => openAssignModal(t.id)} className="btn btn-sm btn-info font-weight-bold mr-1">
                                                                <i className="fas fa-user-plus"></i> Giao việc
                                                            </button>
                                                        ) : (
                                                            <span className="text-success font-weight-bold small mr-2"><i className="fas fa-check"></i> Đã giao</span>
                                                        )}
                                                        <button onClick={() => handleDelete(t.id)} className="btn btn-sm btn-danger"><i className="fas fa-trash"></i></button>
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

            {/* Modal Giao Việc */}
            {showAssignModal && (
                <div className="modal fade show d-block" style={{ background: 'rgba(0,0,0,0.5)' }}>
                    <div className="modal-dialog modal-dialog-centered">
                        <div className="modal-content">
                            <div className="modal-header bg-primary text-white">
                                <h5 className="modal-title">👨‍🔧 Giao Việc Cho Kỹ Thuật Viên</h5>
                                <button className="close text-white" onClick={() => setShowAssignModal(false)}><span>&times;</span></button>
                            </div>
                            <form onSubmit={handleAssignSubmit}>
                                <div className="modal-body">
                                    <div className="form-group">
                                        <label className="font-weight-bold">Chọn Nhân Viên Xử Lý <span className="text-danger">*</span></label>
                                        <select className="form-control" required value={selectedTechId} onChange={e => setSelectedTechId(e.target.value)}>
                                            <option value="">-- Chọn nhân viên --</option>
                                            {technicians.map(tech => (
                                                <option key={tech.maNguoiDung} value={tech.maNguoiDung}>
                                                    {tech.hoTen || tech.tenDangNhap} {tech.soDienThoai ? `(${tech.soDienThoai})` : ''}
                                                </option>
                                            ))}
                                        </select>
                                    </div>
                                </div>
                                <div className="modal-footer">
                                    <button type="button" className="btn btn-secondary" onClick={() => setShowAssignModal(false)}>Hủy</button>
                                    <button type="submit" className="btn btn-primary">Xác Nhận Giao Việc</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            )}

            {/* Modal Tạo Phiếu Mới */}
            {showAddModal && (
                <div className="modal fade show d-block" style={{ background: 'rgba(0,0,0,0.5)' }}>
                    <div className="modal-dialog modal-dialog-centered">
                        <div className="modal-content">
                            <div className="modal-header bg-success text-white">
                                <h5 className="modal-title">➕ Tạo Phiếu Yêu Cầu Mới</h5>
                                <button className="close text-white" onClick={() => setShowAddModal(false)}><span>&times;</span></button>
                            </div>
                            <form onSubmit={handleAddSubmit}>
                                <div className="modal-body">
                                    <div className="form-group">
                                        <label className="font-weight-bold">Tiêu Đề Lỗi <span className="text-danger">*</span></label>
                                        <input type="text" className="form-control" required value={ticketForm.tieuDe} onChange={e => setTicketForm({...ticketForm, tieuDe: e.target.value})} placeholder="VD: Thang máy kêu to" />
                                    </div>
                                    <div className="form-group">
                                        <label className="font-weight-bold">Chọn Thiết Bị Bị Lỗi <span className="text-danger">*</span></label>
                                        <select className="form-control" required value={ticketForm.maThietBi} onChange={e => setTicketForm({...ticketForm, maThietBi: e.target.value})}>
                                            <option value="">-- Chọn thiết bị --</option>
                                            {devices.map(d => (
                                                <option key={d.id} value={d.id}>{d.tenThietBi} ({d.viTri})</option>
                                            ))}
                                        </select>
                                    </div>
                                    <div className="form-group">
                                        <label className="font-weight-bold">Mô Tả Chi Tiết</label>
                                        <textarea className="form-control" rows="3" value={ticketForm.moTaLoi} onChange={e => setTicketForm({...ticketForm, moTaLoi: e.target.value})} placeholder="Mô tả cụ thể biểu hiện lỗi..."></textarea>
                                    </div>
                                    <div className="form-group">
                                        <label className="font-weight-bold">Mức Độ Ưu Tiên</label>
                                        <select className="form-control" value={ticketForm.mucDoUuTien} onChange={e => setTicketForm({...ticketForm, mucDoUuTien: e.target.value})}>
                                            <option value="THAP">Thấp (Khắc phục trong 48h)</option>
                                            <option value="TRUNG_BINH">Trung Bình (Khắc phục trong 24h)</option>
                                            <option value="CAO">Cao (Khẩn cấp xử lý ngay)</option>
                                        </select>
                                    </div>
                                </div>
                                <div className="modal-footer">
                                    <button type="button" className="btn btn-secondary" onClick={() => setShowAddModal(false)}>Hủy</button>
                                    <button type="submit" className="btn btn-success">Lưu Phiếu Yêu Cầu</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            )}
        </div>
    );
}