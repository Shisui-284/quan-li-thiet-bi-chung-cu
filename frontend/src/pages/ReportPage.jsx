import React, { useState } from "react";
import { useNavigate } from "react-router-dom";
import axios from "axios";

export default function ReportPage() {
    const [formData, setFormData] = useState({ tieuDe: "", viTri: "", moTa: "" });
    const navigate = useNavigate();

    const handleSubmit = async (e) => {
        e.preventDefault();
        try {
            await axios.post("http://localhost:8080/tech/report", formData);
            alert("Báo cáo thành công!");
            navigate("/tech-mobile"); // Quay lại danh sách nhiệm vụ
        } catch (err) {
            alert("Có lỗi xảy ra khi báo cáo.");
        }
    };

    return (
        <div className="container p-3">
            <h4 className="mb-3">➕ Báo hỏng nhanh</h4>
            <form onSubmit={handleSubmit}>
                <div className="mb-3">
                    <label>Tên thiết bị/Sự cố</label>
                    <input className="form-control" required onChange={e => setFormData({...formData, tieuDe: e.target.value})} />
                </div>
                <div className="mb-3">
                    <label>Vị trí</label>
                    <input className="form-control" required onChange={e => setFormData({...formData, viTri: e.target.value})} />
                </div>
                <div className="mb-3">
                    <label>Mô tả chi tiết</label>
                    <textarea className="form-control" rows="3" onChange={e => setFormData({...formData, moTa: e.target.value})} />
                </div>
                <button type="submit" className="btn btn-warning w-100 fw-bold">GỬI BÁO CÁO</button>
            </form>
        </div>
    );
}