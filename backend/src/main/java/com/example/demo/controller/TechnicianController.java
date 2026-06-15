package com.example.demo.controller;

import com.example.demo.DTO.CompleteTicketRequest;
import com.example.demo.DTO.CreateTicketRequest;
import com.example.demo.entity.ThietBi;
import com.example.demo.repository.DeviceRepository;
import com.example.demo.service.TicketService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/tech")
@CrossOrigin(origins = "*")
public class TechnicianController {

    @Autowired private TicketService ticketService;
    @Autowired private DeviceRepository deviceRepository;

    @GetMapping("/my-tickets")
    public ResponseEntity<?> myTickets(@RequestParam String username) {
        try {
            return ResponseEntity.ok(ticketService.getMyTicketsByUsername(username));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    @GetMapping("/history")
    public ResponseEntity<?> history(@RequestParam String username) {
        try {
            return ResponseEntity.ok(ticketService.getHistoryByUsername(username));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    @GetMapping("/ticket/{id}")
    public ResponseEntity<?> detail(@PathVariable Long id) {
        try {
            return ResponseEntity.ok(ticketService.getDetail(id));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    @PutMapping("/ticket/{id}/complete")
    public ResponseEntity<?> complete(@PathVariable Long id, @RequestBody CompleteTicketRequest request) {
        try {
            ticketService.completeTicket(id, request);
            return ResponseEntity.ok().build();
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    @PostMapping("/report")
    public ResponseEntity<?> report(@RequestBody CreateTicketRequest request) {
        try {
            ticketService.createQuickReport(request);
            return ResponseEntity.ok().build();
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    // Danh sách thiết bị cho form báo hỏng nhanh
    @GetMapping("/devices")
    public ResponseEntity<List<ThietBi>> getDevices() {
        return ResponseEntity.ok(deviceRepository.findAll());
    }
}