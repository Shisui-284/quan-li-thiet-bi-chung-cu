package com.example.demo.controller;

import com.example.demo.DTO.CompleteTicketRequest;
import com.example.demo.DTO.CreateTicketRequest;
import com.example.demo.service.TicketService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/tech")
@CrossOrigin(origins = "*")
public class TechnicianController {

    @Autowired
    private TicketService ticketService;

    @GetMapping("/my-tickets")
    public ResponseEntity<?> myTickets(@RequestParam String username) {
        return ResponseEntity.ok(ticketService.getMyTicketsByUsername(username));
    }

    @GetMapping("/history")
    public ResponseEntity<?> history(@RequestParam String username) {
        return ResponseEntity.ok(ticketService.getHistoryByUsername(username));
    }

    @GetMapping("/ticket/{id}")
    public ResponseEntity<?> detail(@PathVariable Long id) {
        return ResponseEntity.ok(ticketService.getDetail(id));
    }

    @PutMapping("/ticket/{id}/complete")
    public ResponseEntity<?> complete(@PathVariable Long id, @RequestBody CompleteTicketRequest request) {
        return ResponseEntity.ok(ticketService.completeTicket(id, request));
    }

    @PostMapping("/report")
    public ResponseEntity<?> report(@RequestBody CreateTicketRequest request) {
        return ResponseEntity.ok(ticketService.createQuickReport(request));
    }
}