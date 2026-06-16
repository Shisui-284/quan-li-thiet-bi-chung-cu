import { useState, useEffect } from 'react';
import axios from 'axios';
import Sidebar from '../components/Sidebar';
import Topbar from '../components/Topbar';

const API = 'http://localhost:8080/api/maintenance-plans';
const DEVICE_API = 'http://localhost:8080/api/devices';
const CONTRACTOR_API = 'http://localhost:8080/api/contractors';

const emptyForm = { maThietBi: '', maDonVi: '', chuKyNgay: 30, ngayBaoTriGanNhat: '', ngayBaoTriTiepTheo: '', trangThai: 'DANG_THEO_DOI' };

export default function MaintenancePlansPage() {
    const [plans, setPlans] = useState([]);
    const [devices, setDevices] = useState([]);
    const [contractors, setContractors] = useState([]);
    const [user] = useState(JSON.parse(localStorage.getItem('user')));
    
    const [showModal, setShowModal] = useState(false);
    const [editId, setEditId] = useState(null);
    const [form, setForm] = useState(emptyForm);
    const [loading, setLoading] = useState(false);
    const [msg, setMsg] = useState('');

    const fetchData = async () => {
        try {
            const [pRes, dRes, cRes] = await Promise.all([
                axios.get(`${API}/with-status`),
                axios.get(DEVICE_API),
                axios.get(CONTRACTOR_API)
            ]);
            setPlans(pRes.data);
            setDevices(dRes.data);
            setContractors(cRes.data);
        } catch (e) { console.error(e); }
    };

    useEffect(() => { fetchData(); }, []);

    const openAdd = () => { 
        setEditId(null); 
        setForm({ ...emptyForm, maThietBi: devices[0]?.id || '', maDonVi: contractors[0]?.id || '' }); 
        setShowModal(true); 
    };

    const openEdit = (p) => {
        setEditId(p.id);
        setForm({ 
            maThietBi: p.thietBi?.id || '', 
            maDonVi: p.donVi?.id || '', 
            chuKyNgay: p.chuKyNgay, 
            ngayBaoTriGanNhat: p.ngayBaoTriGanNhat ? p.ngayBaoTriGanNhat.substring(0, 16) : '', 
            ngayBaoTriTiepTheo: p.ngayBaoTriTiepTheo ? p.ngayBaoTriTiepTheo.substring(0, 16) : '', 
            trangThai: p.trangThai || 'DANG_THEO_DOI' 
        });
        setShowModal(true);
    };

    const handleSubmit = async (e) => {
        e.preventDefault();
        setLoading(true);
        // Format dates if provided
        const payload = { ...form };
        if (payload.ngayBaoTriGanNhat) payload.ngayBaoTriGanNhat = payload.ngayBaoTriGanNhat + ':00';
        if (payload.ngayBaoTriTiepTheo) payload.ngayBaoTriTiepTheo = payload.ngayBaoTriTiepTheo + ':00';
        
        try {
            if (editId) await axios.put(`${API}/${editId}`, payload);
            else await axios.post(API, payload);
            setMsg(editId ? '✅ Cập nhật lịch thành công!' : '✅ Tạo lịch bảo trì thành công!');
            setShowModal(false);
            fetchData();
        } catch (err) {
            setMsg('❌ Có lỗi xảy ra!');
        }
        setLoading(false);
        setTimeout(() => setMsg(''), 4000);
    };

    const handleDelete = async (id) => {
        if (!window.confirm(`Xác nhận xóa kế hoạch bảo trì này?`)) return;
        try {
            await axios.delete(`${API}/${id}`);
            setMsg('✅ Đã xóa kế hoạch!');
            fetchData();
        } catch { setMsg('❌ Không thể xóa kế hoạch!'); }
        setTimeout(() => setMsg(''), 4000);
    };

    return (
        <div id="wrapper">
            <Sidebar />
            <div id="content-wrapper" className="d-flex flex-column" style={{ minHeight: '100vh', width: '100%' }}>
                <div id="content">
                    <Topbar title="KẾ HOẠCH BẢO TRÌ" user={user} />
                    <div className="container-fluid">
                        {msg && <div className={`alert ${msg.startsWith('✅') ? 'alert-success' : 'alert-danger'}`}>{msg}</div>}
                        <div className="card shadow mb-4">
                            <div className="card-header py-3 d-flex justify-content-between align-items-center">
                                <h6 className="m-0 font-weight-bold text-primary">📅 Lịch Bảo Trì Định Kỳ</h6>
                                <button className="btn btn-primary btn-sm" onClick={openAdd}><i className="fas fa-plus"></i> Tạo Lịch Mới</button>
                            </div>
                            <div className="card-body">
                                <div className="table-responsive">
                                    <table className="table table-bordered table-hover">
                                        <thead className="thead-dark">
                                            <tr>
                                                <th>Mã Lịch</th>
                                                <th>Thiết Bị</th>
                                                <th>Đơn Vị Bảo Trì</th>
                                                <th>Chu Kỳ</th>
                                                <th>Lần Cuối</th>
                                                <th>Lần Tới</th>
                                                <th>Trạng Thái</th>
                                                <th className="text-center">Thao Tác</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            {plans.length === 0 && <tr><td colSpan={8} className="text-center text-muted py-4">Chưa có lịch bảo trì nào</td></tr>}
                                            {plans.map(p => {
                                                let alertBgColor = '#d4edda'; // SAFE - Xanh
                                                let alertTextColor = '#155724';
                                                if (p.alertStatus === 'DANGER') {
                                                    alertBgColor = '#f8d7da'; // DANGER - Đỏ
                                                    alertTextColor = '#721c24';
                                                } else if (p.alertStatus === 'WARNING') {
                                                    alertBgColor = '#fff3cd'; // WARNING - Vàng
                                                    alertTextColor = '#856404';
                                                }
                                                
                                                return (
                                                    <tr key={p.id} style={{ backgroundColor: alertBgColor }}>
                                                        <td className="font-weight-bold text-primary">#{p.id}</td>
                                                        <td className="font-weight-bold">{p.thietBi?.tenThietBi}</td>
                                                        <td>{p.donVi?.tenDonVi || 'Nội bộ'}</td>
                                                        <td>{p.chuKyNgay} ngày</td>
                                                        <td>{p.ngayBaoTriGanNhat ? new Date(p.ngayBaoTriGanNhat).toLocaleString('vi-VN') : '—'}</td>
                                                        <td style={{ color: alertTextColor }} className="font-weight-bold">
                                                            {p.ngayBaoTriTiepTheo ? new Date(p.ngayBaoTriTiepTheo).toLocaleString('vi-VN') : '—'}
                                                        </td>
                                                        <td>
                                                            <span className={`badge ${
                                                                p.alertStatus === 'DANGER' ? 'badge-danger' :
                                                                p.alertStatus === 'WARNING' ? 'badge-warning text-dark' :
                                                                'badge-success'
                                                            }`}>
                                                                {p.statusBadge}
                                                            </span>
                                                        </td>
                                                        <td className="text-center">
                                                            <button className="btn btn-warning btn-sm mr-1" onClick={() => openEdit(p)} title="Sửa"><i className="fas fa-edit"></i></button>
                                                            <button className="btn btn-danger btn-sm" onClick={() => handleDelete(p.id)} title="Xóa"><i className="fas fa-trash"></i></button>
                                                        </td>
                                                    </tr>
                                                );
                                            })}
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            {showModal && (
                <div className="modal fade show d-block" style={{ background: 'rgba(0,0,0,0.5)' }}>
                    <div className="modal-dialog modal-dialog-centered">
                        <div className="modal-content">
                            <div className="modal-header bg-primary text-white">
                                <h5 className="modal-title">{editId ? '✏️ Sửa Kế Hoạch' : '➕ Tạo Kế Hoạch Mới'}</h5>
                                <button className="close text-white" onClick={() => setShowModal(false)}><span>&times;</span></button>
                            </div>
                            <form onSubmit={handleSubmit}>
                                <div className="modal-body">
                                    <div className="form-group">
                                        <label className="font-weight-bold">Thiết Bị <span className="text-danger">*</span></label>
                                        <select className="form-control" required value={form.maThietBi} onChange={e => setForm({ ...form, maThietBi: e.target.value })}>
                                            <option value="">-- Chọn Thiết Bị --</option>
                                            {devices.map(d => <option key={d.id} value={d.id}>{d.tenThietBi}</option>)}
                                        </select>
                                    </div>
                                    <div className="form-group">
                                        <label className="font-weight-bold">Đơn Vị Bảo Trì</label>
                                        <select className="form-control" value={form.maDonVi} onChange={e => setForm({ ...form, maDonVi: e.target.value })}>
                                            <option value="">-- Nội Bộ --</option>
                                            {contractors.map(c => <option key={c.id} value={c.id}>{c.tenDonVi}</option>)}
                                        </select>
                                    </div>
                                    <div className="form-group">
                                        <label className="font-weight-bold">Chu Kỳ (Ngày) <span className="text-danger">*</span></label>
                                        <input type="number" className="form-control" required value={form.chuKyNgay} onChange={e => setForm({ ...form, chuKyNgay: parseInt(e.target.value) })} min="1" />
                                    </div>
                                    <div className="form-group">
                                        <label className="font-weight-bold">Ngày Bảo Trì Cuối</label>
                                        <input type="datetime-local" className="form-control" value={form.ngayBaoTriGanNhat} onChange={e => setForm({ ...form, ngayBaoTriGanNhat: e.target.value })} />
                                    </div>
                                    <div className="form-group">
                                        <label className="font-weight-bold">Ngày Bảo Trì Tới</label>
                                        <input type="datetime-local" className="form-control" value={form.ngayBaoTriTiepTheo} onChange={e => setForm({ ...form, ngayBaoTriTiepTheo: e.target.value })} />
                                    </div>
                                    <div className="form-group mb-0">
                                        <label className="font-weight-bold">Trạng Thái</label>
                                        <select className="form-control" value={form.trangThai} onChange={e => setForm({ ...form, trangThai: e.target.value })}>
                                            <option value="DANG_THEO_DOI">Đang Theo Dõi</option>
                                            <option value="TAM_DUNG">Tạm Dừng</option>
                                        </select>
                                    </div>
                                </div>
                                <div className="modal-footer">
                                    <button type="button" className="btn btn-secondary" onClick={() => setShowModal(false)}>Hủy</button>
                                    <button type="submit" className="btn btn-primary" disabled={loading}>{loading ? 'Đang lưu...' : (editId ? 'Cập Nhật' : 'Tạo Lịch')}</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            )}
        </div>
    );
}
