import { useState } from 'react';
import axios from 'axios';
import { useNavigate } from 'react-router-dom'; // Bổ sung import này

export default function LoginPage() {
    const [username, setUsername] = useState('');
    const [password, setPassword] = useState('');
    const [error, setError] = useState('');
    const navigate = useNavigate(); // Khởi tạo công cụ chuyển trang

    const handleLogin = async (e) => {
        e.preventDefault();
        try {
            const response = await axios.post('http://localhost:8080/api/auth/login', {
                username: username,
                password: password
            });

            // Xóa dòng alert cũ đi, thay bằng 2 dòng này:
            localStorage.setItem('user', JSON.stringify(response.data)); // Lưu thông tin người dùng
            navigate('/dashboard'); // Chuyển thẳng tới trang Dashboard

        } catch (err) {
            setError('Tài khoản hoặc mật khẩu không chính xác!');
        }
    };


    return (
        <div className="bg-gradient-primary d-flex align-items-center" style={{ minHeight: '100vh', width: '100vw' }}>
            <div className="container">
                <div className="row justify-content-center">
                    <div className="col-xl-5 col-lg-6 col-md-9">
                        <div className="card o-hidden border-0 shadow-lg my-5">
                            <div class="card-body p-0">
                                <div className="p-5">
                                    <div className="text-center mb-4">
                                        <h1 className="h3 text-gray-900 font-weight-bold">
                                            <i className="fas fa-building text-primary"></i> BMS APARTMENT
                                        </h1>
                                        <p className="text-muted small">
                                            Hệ thống Quản lý Bảo trì & Vận hành Kỹ thuật
                                        </p>
                                    </div>

                                    {/* Hiển thị lỗi nếu đăng nhập sai */}
                                    {error && <div className="alert alert-danger p-2 text-center small fw-bold">{error}</div>}

                                    <form className="user" onSubmit={handleLogin}>
                                        <div className="form-group">
                                            <label className="font-weight-bold text-dark small">Tên đăng nhập / Email</label>
                                            <input
                                                type="text"
                                                className="form-control form-control-user"
                                                placeholder="Nhập tài khoản (vd: admin)..."
                                                value={username}
                                                onChange={(e) => setUsername(e.target.value)}
                                                required
                                            />
                                        </div>
                                        <div className="form-group">
                                            <label className="font-weight-bold text-dark small">Mật khẩu</label>
                                            <input
                                                type="password"
                                                className="form-control form-control-user"
                                                placeholder="••••••••••••"
                                                value={password}
                                                onChange={(e) => setPassword(e.target.value)}
                                                required
                                            />
                                        </div>
                                        <div className="form-group text-right">
                                            <a className="small font-weight-bold" href="#">Quên mật khẩu?</a>
                                        </div>
                                        <button
                                            type="submit"
                                            className="btn btn-primary btn-user btn-block font-weight-bold"
                                            style={{ fontSize: '1rem' }}
                                        >
                                            ĐĂNG NHẬP
                                        </button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    );
}