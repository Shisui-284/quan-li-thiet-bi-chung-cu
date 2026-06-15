import { useEffect, useState } from 'react';
import axios from 'axios';
import Sidebar from '../components/Sidebar';
import Topbar from '../components/Topbar';

const API = 'http://localhost:8080/api/devices';
const LOAI_OPTIONS = ['THANG_MAY', 'MAY_PHAT', 'DEN_HANH_LANG', 'KHAC'];
const TRANG_THAI_OPTIONS = ['HOAT_DONG', 'DANG_BAO_TRI', 'HONG', 'NGUNG_SU_DUNG'];

const LOAI_LABEL = { THANG_MAY: 'Thang Máy', MAY_PHAT: 'Máy Phát', DEN_HANH_LANG: 'Đèn Hành Lang', KHAC: 'Khác' };
const TRANG_THAI_BADGE = {
    HOAT_DONG: 'badge-success',
    DANG_BAO_TRI: 'badge-warning text-dark',
    HONG: 'badge-danger',
    NGUNG_SU_DUNG: 'badge-secondary',
};
const TRANG_THAI_LABEL = {
    HOAT_DONG: 'Hoạt động',
    DANG_BAO_TRI: 'Đang bảo trì',
    HONG: 'Hỏng',
    NGUNG_SU_DUNG: 'Ngừng sử dụng',
};

const emptyForm = { tenThietBi: '', loaiThietBi: 'THANG_MAY', viTri: '', trangThai: 'HOAT_DONG' };

export default function DevicePage() {
    const [devices, setDevices] = useState([]);
    const [user] = useState(JSON.parse(localStorage.getItem('user')));
    const [showModal, setShowModal] = useState(false);
    const [editId, setEditId] = useState(null);
    const [form, setForm] = useState(emptyForm);
    const [search, setSearch] = useState('');
    const [loading, setLoading] = useState(false);
    const [msg, setMsg] = useState('');

    const fetch = () => axios.get(API).then(r => setDevices(r.data)).catch(console.error);
    useEffect(() => { fetch(); }, []);

    const openAdd = () => { setEditId(null); setForm(emptyForm); setShowModal(true); };
    const openEdit = (d) => { setEditId(d.id); setForm({ tenThietBi: d.tenThietBi, loaiThietBi: d.loaiThietBi, viTri: d.viTri, trangThai: d.trangThai }); setShowModal(true); };

    const handleSubmit = async (e) => {
        e.preventDefault();
        setLoading(true);
        try {
            if (editId) await axios.put(`${API}/${editId}`, form);
            else await axios.post(API, form);
            setMsg(editId ? '✅ Cập nhật thành công!' : '✅ Thêm thiết bị thành công!');
            setShowModal(false);
            fetch();
        } catch { setMsg('❌ Có lỗi xảy ra!'); }
        setLoading(false);
        setTimeout(() => setMsg(''), 3000);
    };

    const handleDelete = async (id, name) => {
        if (!window.confirm(`Xác nhận xóa thiết bị: "${name}"?`)) return;
        try {
            await axios.delete(`${API}/${id}`);
            setMsg('✅ Đã xóa thiết bị!');
            fetch();
        } catch { setMsg('❌ Không thể xóa (có thể đang liên kết với bảo trì/phiếu sự cố)!'); }
        setTimeout(() => setMsg(''), 4000);
    };

    const filtered = devices.filter(d =>
        d.tenThietBi?.toLowerCase().includes(search.toLowerCase()) ||
        d.viTri?.toLowerCase().includes(search.toLowerCase())
    );

    return (
        <div id="wrapper">
            <Sidebar />
            <div id="content-wrapper" className="d-flex flex-column" style={{ minHeight: '100vh', width: '100%' }}>
                <div id="content">
                    <Topbar title="QUẢN LÝ THIẾT BỊ" user={user} />
                    <div className="container-fluid">
                        {msg && <div className={`alert ${msg.startsWith('✅') ? 'alert-success' : 'alert-danger'} alert-dismissible`}>{msg}</div>}
                        <div className="card shadow mb-4">
                            <div className="card-header py-3 d-flex justify-content-between align-items-center">
                                <h6 className="m-0 font-weight-bold text-primary">🏢 Danh Sách Tài Sản Thiết Bị</h6>
                                <div className="d-flex gap-2">
                                    <input className="form-control form-control-sm mr-2" placeholder="🔍 Tìm kiếm..." value={search} onChange={e => setSearch(e.target.value)} style={{ width: 200 }} />
                                    <button className="btn btn-primary btn-sm" onClick={openAdd}><i className="fas fa-plus"></i> Thêm Thiết Bị</button>
                                </div>
                            </div>
                            <div className="card-body">
                                <div className="table-responsive">
                                    <table className="table table-bordered table-hover">
                                        <thead className="thead-dark">
                                            <tr>
                                                <th style={{ width: 60 }}>Mã</th>
                                                <th>Tên Thiết Bị</th>
                                                <th>Chủng Loại</th>
                                                <th>Vị Trí</th>
                                                <th style={{ width: 140 }}>Trạng Thái</th>
                                                <th style={{ width: 120 }} className="text-center">Thao Tác</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            {filtered.length === 0 && (
                                                <tr><td colSpan={6} className="text-center text-muted py-4">Chưa có thiết bị nào</td></tr>
                                            )}
                                            {filtered.map(d => (
                                                <tr key={d.id}>
                                                    <td className="font-weight-bold text-primary">#{d.id}</td>
                                                    <td className="font-weight-bold">{d.tenThietBi}</td>
                                                    <td><span className="badge badge-info">{LOAI_LABEL[d.loaiThietBi] || d.loaiThietBi}</span></td>
                                                    <td>{d.viTri}</td>
                                                    <td><span className={`badge ${TRANG_THAI_BADGE[d.trangThai] || 'badge-secondary'}`}>{TRANG_THAI_LABEL[d.trangThai] || d.trangThai}</span></td>
                                                    <td className="text-center">
                                                        <button className="btn btn-warning btn-sm mr-1" onClick={() => openEdit(d)} title="Sửa"><i className="fas fa-edit"></i></button>
                                                        <button className="btn btn-danger btn-sm" onClick={() => handleDelete(d.id, d.tenThietBi)} title="Xóa"><i className="fas fa-trash"></i></button>
                                                    </td>
                                                </tr>
                                            ))}
                                        </tbody>
                                    </table>
                                </div>
                                <small className="text-muted">Tổng: {filtered.length} thiết bị</small>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            {/* Modal Thêm / Sửa */}
            {showModal && (
                <div className="modal fade show d-block" style={{ background: 'rgba(0,0,0,0.5)' }}>
                    <div className="modal-dialog modal-dialog-centered">
                        <div className="modal-content">
                            <div className="modal-header bg-primary text-white">
                                <h5 className="modal-title">{editId ? '✏️ Sửa Thiết Bị' : '➕ Thêm Thiết Bị Mới'}</h5>
                                <button className="close text-white" onClick={() => setShowModal(false)}><span>&times;</span></button>
                            </div>
                            <form onSubmit={handleSubmit}>
                                <div className="modal-body">
                                    <div className="form-group">
                                        <label className="font-weight-bold">Tên Thiết Bị <span className="text-danger">*</span></label>
                                        <input className="form-control" required value={form.tenThietBi} onChange={e => setForm({ ...form, tenThietBi: e.target.value })} placeholder="VD: Thang máy Otis Block A" />
                                    </div>
                                    <div className="form-group">
                                        <label className="font-weight-bold">Chủng Loại <span className="text-danger">*</span></label>
                                        <select className="form-control" value={form.loaiThietBi} onChange={e => setForm({ ...form, loaiThietBi: e.target.value })}>
                                            {LOAI_OPTIONS.map(l => <option key={l} value={l}>{LOAI_LABEL[l]}</option>)}
                                        </select>
                                    </div>
                                    <div className="form-group">
                                        <label className="font-weight-bold">Vị Trí Lắp Đặt <span className="text-danger">*</span></label>
                                        <input className="form-control" required value={form.viTri} onChange={e => setForm({ ...form, viTri: e.target.value })} placeholder="VD: Trục kỹ thuật Block A1, Tầng hầm..." />
                                    </div>
                                    <div className="form-group mb-0">
                                        <label className="font-weight-bold">Trạng Thái</label>
                                        <select className="form-control" value={form.trangThai} onChange={e => setForm({ ...form, trangThai: e.target.value })}>
                                            {TRANG_THAI_OPTIONS.map(t => <option key={t} value={t}>{TRANG_THAI_LABEL[t]}</option>)}
                                        </select>
                                    </div>
                                </div>
                                <div className="modal-footer">
                                    <button type="button" className="btn btn-secondary" onClick={() => setShowModal(false)}>Hủy</button>
                                    <button type="submit" className="btn btn-primary" disabled={loading}>{loading ? 'Đang lưu...' : (editId ? 'Cập Nhật' : 'Thêm Mới')}</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            )}
        </div>
    );
}