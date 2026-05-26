import { useNavigate } from 'react-router-dom';

export default function Topbar({ title, user }) {
    const navigate = useNavigate();

    const handleLogout = () => {
        localStorage.removeItem('user');
        navigate('/'); // Đuổi về trang đăng nhập
    };

    return (
        <nav className="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">
            <h1 className="h4 mb-0 text-gray-800 font-weight-bold">{title}</h1>
            <ul className="navbar-nav ml-auto">
                <li className="nav-item d-flex align-items-center">
                    <span className="mr-3 d-none d-lg-inline text-gray-600 small">
                        Xin chào, <b>{user?.tenDangNhap}</b>
                    </span>
                    <button onClick={handleLogout} className="btn btn-sm btn-danger font-weight-bold">
                        <i className="fas fa-sign-out-alt"></i> Đăng xuất
                    </button>
                </li>
            </ul>
        </nav>
    );
}