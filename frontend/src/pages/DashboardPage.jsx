import { useNavigate } from 'react-router-dom';
import { useEffect, useState } from 'react';
import Sidebar from '../components/Sidebar';
import Topbar from '../components/Topbar';

export default function DashboardPage() {
    const navigate = useNavigate();
    const [user, setUser] = useState(null);

    useEffect(() => {
        const userData = localStorage.getItem('user');
        if (!userData) {
            navigate('/');
        } else {
            setUser(JSON.parse(userData));
        }
    }, [navigate]);

    if (!user) return null;

    return (
        <div id="wrapper">
            <Sidebar /> {/* Gọi Sidebar chỉ bằng 1 dòng */}

            <div id="content-wrapper" className="d-flex flex-column" style={{ minHeight: '100vh', width: '100%' }}>
                <div id="content">
                    {/* Gọi Topbar bằng 1 dòng và truyền tiêu đề vào */}
                    <Topbar title="BẢNG ĐIỀU KHIỂN TRUNG TÂM" user={user} />

                    <div className="container-fluid">
                        <div className="alert alert-danger shadow mb-4 border-left-danger" role="alert">
                            <h5 className="alert-heading font-weight-bold">
                                <i className="fas fa-exclamation-triangle"></i> HẠNG MỤC YÊU CẦU BẢO TRÌ TRONG NGÀY
                            </h5>
                            <p className="mb-0 font-weight-bold" style={{ fontSize: '0.95rem' }}>
                                • <b>Thang máy Otis Block A1</b> - <span className="badge badge-danger">QUÁ HẠN 1 NGÀY</span><br />
                                • <b>Máy phát điện dự phòng Cummins 250kVA</b> - <span className="badge badge-warning text-dark">CÒN 2 NGÀY ĐẾN HẠN</span>
                            </p>
                        </div>

                        <div className="row">
                            <div className="col-xl-3 col-md-6 mb-4">
                                <div className="card border-left-danger shadow h-100 py-2">
                                    <div className="card-body">
                                        <div className="row no-gutters align-items-center">
                                            <div className="col mr-2">
                                                <div className="text-xs font-weight-bold text-danger text-uppercase mb-1">Cảnh báo bảo trì</div>
                                                <div className="h5 mb-0 font-weight-bold text-gray-800">02 Thiết bị</div>
                                            </div>
                                            <div className="col-auto"><i className="fas fa-tools fa-2x text-gray-300"></i></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div className="col-xl-3 col-md-6 mb-4">
                                <div className="card border-left-warning shadow h-100 py-2">
                                    <div className="card-body">
                                        <div className="row no-gutters align-items-center">
                                            <div className="col mr-2">
                                                <div className="text-xs font-weight-bold text-warning text-uppercase mb-1">Phiếu Chờ Xử Lý</div>
                                                <div className="h5 mb-0 font-weight-bold text-gray-800">05 Phiếu</div>
                                            </div>
                                            <div className="col-auto"><i className="fas fa-clipboard-list fa-2x text-gray-300"></i></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    );
}