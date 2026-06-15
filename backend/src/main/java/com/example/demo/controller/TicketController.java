package com.example.demo.controller;

import com.example.demo.DTO.CreateTicketRequest;
import com.example.demo.entity.NguoiDung;
import com.example.demo.entity.PhieuBaoHong;
import com.example.demo.repository.UserRepository;
import com.example.demo.service.TicketService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/api/tickets")
@CrossOrigin(origins = "*")
public class TicketController {
    @Autowired private TicketService ticketService;
    @Autowired private UserRepository userRepository;

    @GetMapping
    public ResponseEntity<List<PhieuBaoHong>> getAllTickets() {
        return ResponseEntity.ok(ticketService.getTicketGrid());
    }

    @PostMapping("/public")
    public ResponseEntity<?> createTicket(@RequestBody CreateTicketRequest request) {
        try {
            ticketService.createPublicTicket(
                request.getMaThietBi(),
                request.getTieuDe(),
                request.getMoTaLoi(),
                request.getMucDoUuTien()
            );
            return ResponseEntity.ok().build();
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    // Lấy danh sách thợ để hiển thị khi giao việc
    @GetMapping("/technicians")
    public ResponseEntity<List<NguoiDung>> getTechnicians() {
        return ResponseEntity.ok(userRepository.findByVaiTro("KY_THUAT"));
    }

    // Giao việc cho một người thợ cụ thể
    @PutMapping("/{id}/assign")
    public ResponseEntity<?> assignTicket(@PathVariable Long id, @RequestParam Long techId) {
        try {
            ticketService.assignTicket(id, techId);
            return ResponseEntity.ok().build();
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> deleteTicket(@PathVariable Long id) {
        try {
            ticketService.deleteTicket(id);
            return ResponseEntity.ok().build();
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }
}