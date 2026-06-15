package com.example.demo.service;

import com.example.demo.DTO.CompleteTicketRequest;
import com.example.demo.DTO.CreateTicketRequest;
import com.example.demo.entity.NguoiDung;
import com.example.demo.entity.PhieuBaoHong;
import com.example.demo.repository.TicketRepository;
import com.example.demo.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class TicketService {

    @Autowired 
    private TicketRepository ticketRepository;
    
    @Autowired 
    private UserRepository userRepository;

    // 1. Lấy tất cả phiếu cho Admin
    public List<PhieuBaoHong> getTicketGrid() {
        return ticketRepository.findTicketManagementGrid();
    }

    @Autowired 
    private com.example.demo.repository.DeviceRepository deviceRepository;

    // 2. Tạo phiếu mới (Dành cho Lễ tân/Cư dân)
    public PhieuBaoHong createPublicTicket(Long maThietBi, String tieuDe, String moTaLoi, String mucDoUuTien) {
        PhieuBaoHong phieu = new PhieuBaoHong();
        phieu.setTieuDe(tieuDe);
        phieu.setMoTaLoi(moTaLoi);
        phieu.setMucDoUuTien(mucDoUuTien);
        phieu.setNgayTao(LocalDateTime.now());
        phieu.setTrangThai("CHO_PHAN_CONG"); // Trạng thái mặc định
        if (maThietBi != null) {
            deviceRepository.findById(maThietBi).ifPresent(phieu::setThietBi);
        }
        return ticketRepository.save(phieu);
    }

    // 3. Phân công thợ
    @Transactional
    public PhieuBaoHong assignTicket(Long ticketId, Long techId) {
        PhieuBaoHong phieu = ticketRepository.findById(ticketId)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy phiếu ID: " + ticketId));
        NguoiDung tech = userRepository.findById(techId)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy thợ ID: " + techId));
        phieu.setNguoiXuLy(tech);
        phieu.setTrangThai("DA_PHAN_CONG");
        return ticketRepository.save(phieu);
    }

    // 4. Lấy phiếu của thợ theo Username
    public List<PhieuBaoHong> getMyTicketsByUsername(String username) {
        NguoiDung user = userRepository.findByTenDangNhap(username)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy người dùng: " + username));
        // Giả sử repository có hàm findMyTickets(Long userId)
        return ticketRepository.findMyTickets(user.getMaNguoiDung());
    }

    // 5. Lấy lịch sử phiếu của thợ
    public List<PhieuBaoHong> getHistoryByUsername(String username) {
        NguoiDung user = userRepository.findByTenDangNhap(username)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy người dùng: " + username));
        return ticketRepository.findHistory(user.getMaNguoiDung());
    }

    // 6. Xem chi tiết (dùng custom query JOIN FETCH để tránh LazyInit)
    public PhieuBaoHong getDetail(Long ticketId) {
        PhieuBaoHong p = ticketRepository.findDetail(ticketId);
        if (p == null) throw new RuntimeException("Không tìm thấy phiếu");
        return p;
    }

    // 7. Hoàn thành phiếu
    @Transactional
    public PhieuBaoHong completeTicket(Long ticketId, CompleteTicketRequest request) {
        PhieuBaoHong ticket = ticketRepository.findById(ticketId)
                .orElseThrow(() -> new RuntimeException("Phiếu không tồn tại"));
        ticket.setTrangThai("HOAN_THANH");
        ticket.setNgayHoanThanh(LocalDateTime.now());
        ticket.setGhiChuKetQua(request.getGhiChuKetQua());
        return ticketRepository.save(ticket);
    }

    // 8. Báo cáo nhanh (Kỹ thuật viên tự báo khi tuần tra)
    public PhieuBaoHong createQuickReport(CreateTicketRequest request) {
        PhieuBaoHong phieu = new PhieuBaoHong();
        phieu.setTieuDe(request.getTieuDe());
        phieu.setMoTaLoi(request.getMoTaLoi());
        phieu.setMucDoUuTien(request.getMucDoUuTien());
        phieu.setNgayTao(LocalDateTime.now());
        phieu.setTrangThai("CHO_PHAN_CONG");
        if (request.getMaThietBi() != null) {
            deviceRepository.findById(request.getMaThietBi()).ifPresent(phieu::setThietBi);
        }
        return ticketRepository.save(phieu);
    }

    // 9. Xóa phiếu
    @Transactional
    public void deleteTicket(Long ticketId) {
        if (!ticketRepository.existsById(ticketId))
            throw new RuntimeException("Không tìm thấy phiếu ID: " + ticketId);
        ticketRepository.deleteById(ticketId);
    }
}