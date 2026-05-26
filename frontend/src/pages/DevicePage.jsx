import { useEffect, useState } from 'react';
import axios from 'axios';
import Sidebar from '../components/Sidebar';
import Topbar from '../components/Topbar';

export default function DevicePage() {
    const [devices, setDevices] = useState([]);
    const [user] = useState(JSON.parse(localStorage.getItem('user')));

    useEffect(() => {
        // Lấy dữ liệu từ Backend
        axios.get('http://localhost:8080/api/devices')
            .then(res => setDevices(res.data))
            .catch(err => console.error("Lỗi lấy dữ liệu:", err));
    }, []);

    return (
        <div id="wrapper">
            <Sidebar />
            <div id="content-wrapper" className="d-flex flex-column">
                <div id="content">
                    <Topbar title="QUẢN LÝ DANH MỤC THIẾT BỊ" user={user} />
                    <div className="container-fluid">
                        <div className="card shadow mb-4">
                            <div className="card-header py-3 bg-light">
                                <h6 className="m-0 font-weight-bold text-primary">Danh sách tài sản</h6>
                            </div>
                            <div className="card-body">
                                <table className="table table-bordered text-dark">
                                    <thead>
                                        <tr>
                                            <th>Mã số</th>
                                            <th>Tên thiết bị</th>
                                            <th>Chủng loại</th>
                                            <th>Vị trí</th>
                                            <th>Trạng thái</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        {devices.map(d => (
                                            <tr key={d.id}>
                                                <td>{d.id}</td>
                                                <td>{d.tenThietBi}</td>
                                                <td>{d.loaiThietBi}</td>
                                                <td>{d.viTri}</td>
                                                <td><span className="badge badge-success">{d.trangThai}</span></td>
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