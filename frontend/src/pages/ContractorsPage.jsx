import { useState, useEffect } from 'react';
import axios from 'axios';
import Sidebar from '../components/Sidebar';
import Topbar from '../components/Topbar';

const API = 'http://localhost:8080/api/contractors';

const emptyForm = { tenDonVi: '', nguoiLienHe: '', soDienThoai: '', ghiChu: '', trangThai: 'HOP_TAC' };

export default function ContractorsPage() {
    const [contractors, setContractors] = useState([]);
    const [user] = useState(JSON.parse(localStorage.getItem('user')));
    const [showModal, setShowModal] = useState(false);
    const [editId, setEditId] = useState(null);
    const [form, setForm] = useState(emptyForm);
    const [search, setSearch] = useState('');
    const [loading, setLoading] = useState(false);
    const [msg, setMsg] = useState('');

    const fetchData = () => axios.get(API).then(r => setContractors(r.data)).catch(console.error);
    useEffect(() => { fetchData(); }, []);

    const openAdd = () => { setEditId(null); setForm(emptyForm); setShowModal(true); };
    const openEdit = (c) => {
        setEditId(c.id);
        setForm({ tenDonVi: c.tenDonVi, nguoiLienHe: c.nguoiLienHe || '', soDienThoai: c.soDienThoai || '', ghiChu: c.ghiChu || '', trangThai: c.trangThai || 'HOP_TAC' });
        setShowModal(true);
    };

    const handleSubmit = async (e) => {
        e.preventDefault();
        setLoading(true);
        try {
            if (editId) await axios.put(`${API}/${editId}`, form);
            else await axios.post(API, form);
            setMsg(editId ? '✅ Cập nhật nhà thầu thành công!' : '✅ Thêm nhà thầu thành công!');
            setShowModal(false);
            fetchData();
        } catch (err) {
            setMsg('❌ Có lỗi xảy ra!');
        }
        setLoading(false);
        setTimeout(() => setMsg(''), 4000);
    };

    const handleDelete = async (id, name) => {
        if (!window.confirm(`Xác nhận xóa nhà thầu "${name}"?`)) return;
        try {
            await axios.delete(`${API}/${id}`);
            setMsg('✅ Đã xóa nhà thầu!');
            fetchData();
        } catch { setMsg('❌ Không thể xóa (có thể đang liên kết với bảo trì)!'); }
        setTimeout(() => setMsg(''), 4000);
    };

    const filtered = contractors.filter(c =>
        c.tenDonVi?.toLowerCase().includes(search.toLowerCase()) ||
        c.nguoiLienHe?.toLowerCase().includes(search.toLowerCase())
    );

    return (
        <div id="wrapper">
            <Sidebar />
            <div id="content-wrapper" className="d-flex flex-column" style={{ minHeight: '100vh', width: '100%' }}>
                <div id="content">
                    <Topbar title="ĐƠN VỊ BẢO TRÌ" user={user} />
                    <div className="container-fluid">
                        {msg && <div className={`alert ${msg.startsWith('✅') ? 'alert-success' : 'alert-danger'}`}>{msg}</div>}
                        <div className="card shadow mb-4">
                            <div className="card-header py-3 d-flex justify-content-between align-items-center">
                                <h6 className="m-0 font-weight-bold text-primary">🤝 Đối Tác / Nhà Thầu</h6>
                                <div className="d-flex">
                                    <input className="form-control form-control-sm mr-2" placeholder="🔍 Tìm kiếm..." value={search} onChange={e => setSearch(e.target.value)} style={{ width: 200 }} />
                                    <button className="btn btn-primary btn-sm" onClick={openAdd}><i className="fas fa-plus"></i> Thêm Nhà Thầu</button>
                                </div>
                            </div>
                            <div className="card-body">
                                <div className="table-responsive">
                                    <table className="table table-bordered table-hover">
                                        <thead className="thead-dark">
                                            <tr>
                                                <th>Mã Đối Tác</th>
                                                <th>Tên Đơn Vị</th>
                                                <th>Người Liên Hệ</th>
                                                <th>Số Điện Thoại</th>
                                                <th>Ghi Chú</th>
                                                <th>Trạng Thái</th>
                                                <th className="text-center">Thao Tác</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            {filtered.length === 0 && <tr><td colSpan={7} className="text-center text-muted py-4">Chưa có nhà thầu nào</td></tr>}
                                            {filtered.map(c => (
                                                <tr key={c.id}>
                                                    <td className="font-weight-bold text-primary">#{c.id}</td>
                                                    <td className="font-weight-bold">{c.tenDonVi}</td>
                                                    <td>{c.nguoiLienHe}</td>
                                                    <td>{c.soDienThoai}</td>
                                                    <td>{c.ghiChu}</td>
                                                    <td>
                                                        <span className={`badge ${c.trangThai === 'HOP_TAC' ? 'badge-success' : 'badge-secondary'}`}>
                                                            {c.trangThai === 'HOP_TAC' ? 'Đang Hợp Tác' : 'Ngừng Hợp Tác'}
                                                        </span>
                                                    </td>
                                                    <td className="text-center">
                                                        <button className="btn btn-warning btn-sm mr-1" onClick={() => openEdit(c)} title="Sửa"><i className="fas fa-edit"></i></button>
                                                        <button className="btn btn-danger btn-sm" onClick={() => handleDelete(c.id, c.tenDonVi)} title="Xóa"><i className="fas fa-trash"></i></button>
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

            {showModal && (
                <div className="modal fade show d-block" style={{ background: 'rgba(0,0,0,0.5)' }}>
                    <div className="modal-dialog modal-dialog-centered">
                        <div className="modal-content">
                            <div className="modal-header bg-primary text-white">
                                <h5 className="modal-title">{editId ? '✏️ Sửa Nhà Thầu' : '➕ Thêm Nhà Thầu'}</h5>
                                <button className="close text-white" onClick={() => setShowModal(false)}><span>&times;</span></button>
                            </div>
                            <form onSubmit={handleSubmit}>
                                <div className="modal-body">
                                    <div className="form-group">
                                        <label className="font-weight-bold">Tên Đơn Vị <span className="text-danger">*</span></label>
                                        <input className="form-control" required value={form.tenDonVi} onChange={e => setForm({ ...form, tenDonVi: e.target.value })} />
                                    </div>
                                    <div className="form-group">
                                        <label className="font-weight-bold">Người Liên Hệ</label>
                                        <input className="form-control" value={form.nguoiLienHe} onChange={e => setForm({ ...form, nguoiLienHe: e.target.value })} />
                                    </div>
                                    <div className="form-group">
                                        <label className="font-weight-bold">Số Điện Thoại</label>
                                        <input className="form-control" value={form.soDienThoai} onChange={e => setForm({ ...form, soDienThoai: e.target.value })} />
                                    </div>
                                    <div className="form-group">
                                        <label className="font-weight-bold">Ghi Chú</label>
                                        <textarea className="form-control" rows="2" value={form.ghiChu} onChange={e => setForm({ ...form, ghiChu: e.target.value })}></textarea>
                                    </div>
                                    <div className="form-group mb-0">
                                        <label className="font-weight-bold">Trạng Thái</label>
                                        <select className="form-control" value={form.trangThai} onChange={e => setForm({ ...form, trangThai: e.target.value })}>
                                            <option value="HOP_TAC">Đang Hợp Tác</option>
                                            <option value="NGUNG_HOP_TAC">Ngừng Hợp Tác</option>
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
