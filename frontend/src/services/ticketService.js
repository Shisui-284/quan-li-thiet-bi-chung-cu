import axios from "axios";

const API_URL = "http://localhost:8080";

// Tự động thêm Token vào mỗi yêu cầu
const authHeader = () => {
    const token = localStorage.getItem("token"); // Đảm bảo bạn lưu token khi login
    return { headers: { Authorization: `Bearer ${token}` } };
};

export const getMyTickets = () => axios.get(`${API_URL}/tech/my-tickets`, authHeader());
export const getTicketDetail = (id) => axios.get(`${API_URL}/tech/ticket/${id}`, authHeader());
export const getHistory = () => axios.get(`${API_URL}/tech/history`, authHeader());
export const completeTicket = (id, note) => axios.put(`${API_URL}/tech/ticket/${id}/complete`, { ghiChuKetQua: note }, authHeader());
export const createReport = (data) => axios.post(`${API_URL}/tech/report`, data, authHeader());