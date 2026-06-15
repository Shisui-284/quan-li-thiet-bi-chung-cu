package com.example.demo.controller;
import com.example.demo.repository.DeviceRepository;
import com.example.demo.repository.TicketRepository;
import com.example.demo.repository.LichBaoTriRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/api/dashboard")
@CrossOrigin(origins = "*")
public class DashboardController {
    @Autowired private DeviceRepository deviceRepo;
    @Autowired private TicketRepository ticketRepo;
    @Autowired private LichBaoTriRepository planRepo;

    @GetMapping("/stats")
    public ResponseEntity<Map<String, Object>> getStats() {
        Map<String, Object> stats = new HashMap<>();
        stats.put("totalDevices", deviceRepo.count());
        stats.put("totalTickets", ticketRepo.count());
        stats.put("totalPlans", planRepo.count());
        // More sophisticated stats can be added later
        return ResponseEntity.ok(stats);
    }
}
