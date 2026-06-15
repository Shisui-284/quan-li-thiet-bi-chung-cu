package com.example.demo.controller;

import com.example.demo.DTO.CreateTicketRequest;
import com.example.demo.entity.PhieuBaoHong;
import com.example.demo.service.TicketService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/tickets")
@CrossOrigin(origins = "*")
public class TicketController {
    @Autowired private TicketService ticketService;

    @GetMapping
    public ResponseEntity<List<PhieuBaoHong>> getAllTickets() {
        return ResponseEntity.ok(ticketService.getTicketGrid());
    }

    @PostMapping("/public")
public ResponseEntity<?> createTicket(@RequestBody CreateTicketRequest request) {
    try {
        // Truyền tham số từ DTO vào service
        PhieuBaoHong phieuMoi = ticketService.createPublicTicket(
            request.getMaThietBi(), 
            request.getTieuDe(), 
            request.getMoTaLoi(), 
            request.getMucDoUuTien()
        );
        return ResponseEntity.ok(phieuMoi);
    } catch (Exception e) {
        return ResponseEntity.badRequest().body(e.getMessage());
    }
}
}