import { useState, useEffect } from 'react';
import axios from 'axios';
import Sidebar from '../components/Sidebar';
import Topbar from '../components/Topbar';

const API = 'http://localhost:8080/api/technicians';
const CHUYEN_MON_OPTIONS = ['Điện', 'Nước', 'Thang máy', 'Cơ khí', 'Khác'];

const emptyForm = { tenDangNhap: '', matKhau: '', hoTen: '', soDienThoai: '', chuyenMon: 'Điện', trangThai: 'HOAT_DONG' };

export default function TechniciansPage() {
    const [technicians, setTechnicians] = useState([]);
    const [user] = useState(JSON.parse(localStorage.getItem('user')));
    const [showModal, setShowModal] = useState(false);
    const [editId, setEditId] = useState(null);
    const [form, setForm] = useState(emptyForm);
    const [search, setSearch] = useState('');
    const [loading, setLoading] = useState(false);
    const [msg, setMsg] = useState('');

    const fetchData = () => axios.get(API).then(r => setTechnicians(r.data)).catch(console.error);
    useEffect(() => { fetchData(); }, []);

    const openAdd = () => { setEditId(null); setForm(emptyForm); setShowModal(true); };
    const openEdit = (t) => {
        setEditId(t.maNguoiDung);
        setForm({ tenDangNhap: t.tenDangNhap, matKhau: '', hoTen: t.hoTen || '', soDienThoai: t.soDienThoai || '', trangThai: t.trangThai || 'HOAT_DONG' });
        setShowModal(true);
    };

    const handleSubmit = async (e) => {
        e.preventDefault();
        setLoading(true);
        try {
            if (editId) await axios.put(`${API}/${editId}`, form);
            else await axios.post(API, form);
            setMsg(editId ? '✅ Cập nhật thành công!' : '✅ Tạo tài khoản thành công!');
            setShowModal(false);
            fetchData();
        } catch (err) {
            setMsg('❌ ' + (err.response?.data || 'Có lỗi xảy ra!'));
        }
        setLoading(false);
        setTimeout(() => setMsg(''), 4000);
    };

    const handleDelete = async (id, name) => {
        if (!window.confirm(`Xác nhận xóa nhân viên "${name}"?\nThao tác này không thể hoàn tác.`)) return;
        try {
            await axios.delete(`${API}/${id}`);
            setMsg('✅ Đã xóa nhân viên!');
            fetchData();
        } catch { setMsg('❌ Không thể xóa nhân viên!'); }
        setTimeout(() => setMsg(''), 4000);
    };

    const filtered = technicians.filter(t =>
        t.hoTen?.toLowerCase().includes(search.toLowerCase()) ||
        t.tenDangNhap?.toLowerCase().includes(search.toLowerCase())
    );

    return (
        <div id="wrapper">
            <Sidebar />
            <div id="content-wrapper" className="d-flex flex-column" style={{ minHeight: '100vh', width: '100%' }}>
                <div id="content">
                    <Topbar title="NHÂN SỰ KỸ THUẬT" user={user} />
                    <div className="container-fluid">
                        {msg && <div className={`alert ${msg.startsWith('✅') ? 'alert-success' : 'alert-danger'}`}>{msg}</div>}
                        <div className="card shadow mb-4">
                            <div className="card-header py-3 d-flex justify-content-between align-items-center">
                                <h6 className="m-0 font-weight-bold text-primary">👷 Đội Ngũ Kỹ Thuật Viên</h6>
                                <div className="d-flex">
                                    <input className="form-control form-control-sm mr-2" placeholder="🔍 Tìm kiếm..." value={search} onChange={e => setSearch(e.target.value)} style={{ width: 200 }} />
                                    <button className="btn btn-primary btn-sm" onClick={openAdd}><i className="fas fa-user-plus"></i> Thêm Kỹ Thuật Viên</button>
                                </div>
                            </div>
                            <div className="card-body">
                                <div className="table-responsive">
                                    <table className="table table-bordered table-hover">
                                        <thead className="thead-dark">
                                            <tr>
                                                <th>Mã NV</th>
                                                <th>Tên Đăng Nhập</th>
                                                <th>Họ Tên</th>
                                                <th>Số Điện Thoại</th>
                                                <th>Trạng Thái</th>
                                                <th className="text-center">Thao Tác</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            {filtered.length === 0 && <tr><td colSpan={6} className="text-center text-muted py-4">Chưa có nhân viên nào</td></tr>}
                                            {filtered.map(t => (
                                                <tr key={t.maNguoiDung}>
                                                    <td className="font-weight-bold text-primary">#{t.maNguoiDung}</td>
                                                    <td><i className="fas fa-user mr-1 text-info"></i>{t.tenDangNhap}</td>
                                                    <td className="font-weight-bold">{t.hoTen || <span className="text-muted">Chưa cập nhật</span>}</td>
                                                    <td>{t.soDienThoai || <span className="text-muted">—</span>}</td>
                                                    <td>
                                                        <span className={`badge ${t.trangThai === 'HOAT_DONG' ? 'badge-success' : 'badge-danger'}`}>
                                                            {t.trangThai === 'HOAT_DONG' ? '🟢 Đang làm việc' : '🔴 Đã nghỉ'}
                                                        </span>
                                                    </td>
                                                    <td className="text-center">
                                                        <button className="btn btn-warning btn-sm mr-1" onClick={() => openEdit(t)} title="Sửa thông tin"><i className="fas fa-edit"></i></button>
                                                        <button className="btn btn-danger btn-sm" onClick={() => handleDelete(t.maNguoiDung, t.hoTen || t.tenDangNhap)} title="Xóa tài khoản"><i className="fas fa-trash"></i></button>
                                                    </td>
                                                </tr>
                                            ))}
                                        </tbody>
                                    </table>
                                </div>
                                <small className="text-muted">Tổng: {filtered.length} nhân viên kỹ thuật</small>
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
                                <h5 className="modal-title">{editId ? '✏️ Sửa Thông Tin Nhân Viên' : '➕ Thêm Kỹ Thuật Viên Mới'}</h5>
                                <button className="close text-white" onClick={() => setShowModal(false)}><span>&times;</span></button>
                            </div>
                            <form onSubmit={handleSubmit}>
                                <div className="modal-body">
                                    {!editId && (
                                        <div className="form-group">
                                            <label className="font-weight-bold">Tên Đăng Nhập <span className="text-danger">*</span></label>
                                            <input className="form-control" required value={form.tenDangNhap} onChange={e => setForm({ ...form, tenDangNhap: e.target.value })} placeholder="VD: kythuat02" />
                                        </div>
                                    )}
                                    <div className="form-group">
                                        <label className="font-weight-bold">{editId ? 'Mật Khẩu Mới (để trống nếu không đổi)' : 'Mật Khẩu *'}</label>
                                        <input className="form-control" type="password" required={!editId} value={form.matKhau} onChange={e => setForm({ ...form, matKhau: e.target.value })} placeholder="Nhập mật khẩu..." />
                                    </div>
                                    <div className="form-group">
                                        <label className="font-weight-bold">Họ và Tên <span className="text-danger">*</span></label>
                                        <input className="form-control" required value={form.hoTen} onChange={e => setForm({ ...form, hoTen: e.target.value })} placeholder="VD: Nguyễn Văn A" />
                                    </div>
                                    <div className="form-group">
                                        <label className="font-weight-bold">Số Điện Thoại</label>
                                        <input className="form-control" value={form.soDienThoai} onChange={e => setForm({ ...form, soDienThoai: e.target.value })} placeholder="VD: 0901234567" />
                                    </div>
                                    <div className="form-group mb-0">
                                        <label className="font-weight-bold">Trạng Thái</label>
                                        <select className="form-control" value={form.trangThai} onChange={e => setForm({ ...form, trangThai: e.target.value })}>
                                            <option value="HOAT_DONG">🟢 Đang làm việc</option>
                                            <option value="KHOA">🔴 Đã nghỉ / Khóa</option>
                                        </select>
                                    </div>
                                </div>
                                <div className="modal-footer">
                                    <button type="button" className="btn btn-secondary" onClick={() => setShowModal(false)}>Hủy</button>
                                    <button type="submit" className="btn btn-primary" disabled={loading}>{loading ? 'Đang lưu...' : (editId ? 'Cập Nhật' : 'Tạo Tài Khoản')}</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            )}
        </div>
    );
}
