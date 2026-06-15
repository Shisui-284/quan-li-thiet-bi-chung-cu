import { useState } from 'react';
import axios from 'axios';
import { useNavigate } from 'react-router-dom';

export default function LoginPage() {
    const [username, setUsername] = useState('');
    const [password, setPassword] = useState('');
    const [error, setError] = useState('');
    const [loading, setLoading] = useState(false);
    const navigate = useNavigate();

    const handleLogin = async (e) => {
        e.preventDefault();
        setError('');
        setLoading(true);

        try {
            const response = await axios.post('http://localhost:8080/api/auth/login', { username, password });
            const user = response.data;

            // Lưu thông tin vào localStorage để nhận diện người dùng
            localStorage.setItem('user', JSON.stringify(user));
            localStorage.setItem('userId', user.maNguoiDung);
            localStorage.setItem('role', user.vaiTro);

            const role = user.vaiTro ? user.vaiTro.toString().toUpperCase().trim() : "";

            if (role === 'ADMIN') {
                navigate('/dashboard');
            } else if (role === 'KY_THUAT') {
                navigate('/tech-mobile');
            } else {
                setError('Tài khoản không có quyền truy cập hệ thống.');
            }
        } catch (err) {
            setError('Tài khoản hoặc mật khẩu không chính xác!');
        } finally {
            setLoading(false);
        }
    };

    return (
        <div className="bg-gradient-primary d-flex align-items-center" style={{ minHeight: '100vh', width: '100vw' }}>
            <div className="container">
                <div className="row justify-content-center">
                    <div className="col-xl-5 col-lg-6 col-md-9">
                        <div className="card o-hidden border-0 shadow-lg my-5">
                            <div className="card-body p-0">
                                <div className="p-5">
                                    <div className="text-center mb-4">
                                        <h1 className="h3 text-gray-900 font-weight-bold">BMS APARTMENT</h1>
                                    </div>

                                    {error && <div className="alert alert-danger text-center small fw-bold">{error}</div>}

                                    <form className="user" onSubmit={handleLogin}>
                                        <div className="form-group">
                                            <label className="font-weight-bold text-dark small">Tên đăng nhập</label>
                                            <input
                                                type="text"
                                                className="form-control form-control-user"
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
                                                value={password}
                                                onChange={(e) => setPassword(e.target.value)}
                                                required
                                            />
                                        </div>
                                        <button
                                            type="submit"
                                            className="btn btn-primary btn-user btn-block font-weight-bold"
                                            disabled={loading}
                                        >
                                            {loading ? 'ĐANG ĐĂNG NHẬP...' : 'ĐĂNG NHẬP'}
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