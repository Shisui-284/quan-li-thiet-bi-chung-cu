package com.example.demo.controller;

import com.example.demo.entity.PhieuBaoHong;
import com.example.demo.service.TicketService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/tickets")
@CrossOrigin(origins = "*") // Mở cửa cho React cổng 5173 gọi sang không bị lỗi CORS
public class TicketController {

    @Autowired
    private TicketService ticketService;

    // 1. API lấy danh sách phiếu cho Admin Dashboard
    @GetMapping
    public ResponseEntity<List<PhieuBaoHong>> getAllTickets() {
        List<PhieuBaoHong> danhSach = ticketService.getTicketGrid();
        return ResponseEntity.ok(danhSach);
    }

    // 2. API tạo phiếu báo hỏng mới (Dành cho Lễ tân/Cư dân)
    @PostMapping("/public")
    public ResponseEntity<?> createTicket(
            @RequestParam Long thietBiId,
            @RequestParam String tieuDe,
            @RequestParam String moTaLoi,
            @RequestParam String mucDoUuTien) {
        try {
            PhieuBaoHong phieuMoi = ticketService.createPublicTicket(thietBiId, tieuDe, moTaLoi, mucDoUuTien);
            return ResponseEntity.ok(phieuMoi);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    // 3. API phân công thợ kỹ thuật
    @PutMapping("/{ticketId}/assign")
    public ResponseEntity<?> assignTicket(
            @PathVariable Long ticketId,
            @RequestParam Long techId) {
        try {
            PhieuBaoHong phieuDaGiao = ticketService.assignTicket(ticketId, techId);
            return ResponseEntity.ok(phieuDaGiao);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }
}