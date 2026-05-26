package com.example.demo.service;

import com.example.demo.entity.NguoiDung;
import com.example.demo.entity.PhieuBaoHong;
import com.example.demo.entity.ThietBi;
import com.example.demo.repository.DeviceRepository;
import com.example.demo.repository.TicketRepository;
import com.example.demo.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class TicketService {

    @Autowired
    private TicketRepository ticketRepository;
    @Autowired
    private DeviceRepository deviceRepository;
    @Autowired
    private UserRepository userRepository;

    public List<PhieuBaoHong> getTicketGrid() {
        return ticketRepository.findTicketManagementGrid();
    }

    @Transactional
    public PhieuBaoHong createPublicTicket(Long thietBiId, String tieuDe, String moTaLoi, String mucDoUuTien) {
        // Thêm chốt chặn null
        if (thietBiId == null)
            throw new IllegalArgumentException("Mã thiết bị không được để trống!");

        ThietBi thietBi = deviceRepository.findById(thietBiId)
                .orElseThrow(() -> new RuntimeException("Thiết bị không tồn tại!"));

        PhieuBaoHong phieu = new PhieuBaoHong();
        phieu.setTieuDe(tieuDe);
        phieu.setMoTaLoi(moTaLoi);
        phieu.setThietBi(thietBi);
        phieu.setMucDoUuTien(mucDoUuTien);
        phieu.setTrangThai("CHO_PHAN_CONG");
        phieu.setNgayTao(java.time.LocalDateTime.now());

        return ticketRepository.save(phieu);
    }

    @Transactional
    public PhieuBaoHong assignTicket(Long ticketId, Long techId) {
        // Thêm chốt chặn null
        if (ticketId == null || techId == null)
            throw new IllegalArgumentException("Mã phiếu và mã thợ không được trống!");

        PhieuBaoHong phieu = ticketRepository.findById(ticketId)
                .orElseThrow(() -> new RuntimeException("Phiếu báo hỏng không tồn tại!"));

        NguoiDung thoKyThuat = userRepository.findById(techId)
                .orElseThrow(() -> new RuntimeException("Nhân viên kỹ thuật không tồn tại!"));

        phieu.setNguoiXuLy(thoKyThuat);
        phieu.setTrangThai("DANG_SUA");

        return ticketRepository.save(phieu);
    }
}