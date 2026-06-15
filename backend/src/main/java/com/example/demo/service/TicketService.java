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
        return ticketRepository.findAll();
    }

    // 2. Tạo phiếu mới (Dành cho Lễ tân/Cư dân)
    public PhieuBaoHong createPublicTicket(Long maThietBi, String tieuDe, String moTaLoi, String mucDoUuTien) {
        PhieuBaoHong phieu = new PhieuBaoHong();
        phieu.setTieuDe(tieuDe);
        phieu.setMoTaLoi(moTaLoi);
        phieu.setMucDoUuTien(mucDoUuTien);
        phieu.setNgayTao(LocalDateTime.now());
        phieu.setTrangThai("CHO_PHAN_CONG"); // Trạng thái mặc định
        // phieu.setThietBiId(maThietBi); // Bỏ comment dòng này nếu bạn có field này trong Entity
        return ticketRepository.save(phieu);
    }

    // 3. Phân công thợ
    @Transactional
    public PhieuBaoHong assignTicket(Long ticketId, Long techId) {
        PhieuBaoHong phieu = ticketRepository.findById(ticketId)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy phiếu ID: " + ticketId));
        // phieu.setNguoiThucHienId(techId); // Cập nhật ID thợ
        phieu.setTrangThai("DANG_XU_LY");
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

    // 6. Xem chi tiết
    public PhieuBaoHong getDetail(Long ticketId) {
        return ticketRepository.findById(ticketId)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy phiếu"));
    }

    // 7. Hoàn thành phiếu
    @Transactional
    public PhieuBaoHong completeTicket(Long ticketId, CompleteTicketRequest request) {
        PhieuBaoHong ticket = ticketRepository.findById(ticketId)
                .orElseThrow(() -> new RuntimeException("Phiếu không tồn tại"));
        ticket.setTrangThai("HOAN_THANH");
        ticket.setNgayHoanThanh(LocalDateTime.now());
        // ticket.setGhiChuKetQua(request.getGhiChuKetQua());
        return ticketRepository.save(ticket);
    }

    // 8. Báo cáo nhanh
    public PhieuBaoHong createQuickReport(CreateTicketRequest request) {
        PhieuBaoHong phieu = new PhieuBaoHong();
        phieu.setTieuDe(request.getTieuDe());
        phieu.setMoTaLoi(request.getMoTaLoi());
        phieu.setNgayTao(LocalDateTime.now());
        phieu.setTrangThai("MOI");
        return ticketRepository.save(phieu);
    }
}