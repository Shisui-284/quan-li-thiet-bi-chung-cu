import { useEffect, useState } from "react";
import { useParams, useNavigate } from "react-router-dom";
import axios from "axios";

export default function TicketDetailPage() {
    const { id } = useParams();
    const [ticket, setTicket] = useState(null);
    const [ghiChu, setGhiChu] = useState("");
    const navigate = useNavigate();

    useEffect(() => {
        axios.get(`http://localhost:8080/tech/ticket/${id}`).then(res => setTicket(res.data));
    }, [id]);

    const handleComplete = async () => {
        await axios.put(`http://localhost:8080/tech/ticket/${id}/complete`, { ghiChu });
        alert("Đã hoàn thành công việc!");
        navigate("/tech-mobile");
    };

    if (!ticket) return <div>Đang tải...</div>;

    return (
        <div className="container p-3">
            <h3>{ticket.tieuDe}</h3>
            <p>Vị trí: {ticket.thietBi?.viTri}</p>
            <textarea className="form-control mb-3" placeholder="Nhập ghi chú sửa chữa..." 
                      onChange={(e) => setGhiChu(e.target.value)} />
            <button className="btn btn-success w-100" onClick={handleComplete}>HOÀN THÀNH CÔNG VIỆC</button>
        </div>
    );
}