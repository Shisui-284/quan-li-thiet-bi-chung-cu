package com.example.demo.controller;

import com.example.demo.entity.NguoiDung;
import com.example.demo.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;
import java.util.List;
import java.time.LocalDateTime;

@RestController
@RequestMapping("/api/technicians")
@CrossOrigin(origins = "*")
public class AdminTechnicianController {

    @Autowired private UserRepository userRepository;
    @Autowired private PasswordEncoder passwordEncoder;

    @GetMapping
    public ResponseEntity<List<NguoiDung>> getAllTechnicians() {
        return ResponseEntity.ok(userRepository.findByVaiTro("KY_THUAT"));
    }

    @PostMapping
    public ResponseEntity<NguoiDung> createTechnician(@RequestBody NguoiDung technician) {
        technician.setVaiTro("KY_THUAT");
        technician.setMatKhau(passwordEncoder.encode(technician.getMatKhau()));
        if (technician.getTrangThai() == null)
            technician.setTrangThai("HOAT_DONG");
        technician.setNgayTao(LocalDateTime.now());
        return ResponseEntity.ok(userRepository.save(technician));
    }

    @PutMapping("/{id}")
    public ResponseEntity<?> updateTechnician(@PathVariable Long id, @RequestBody NguoiDung updated) {
        return userRepository.findById(id).map(t -> {
            t.setHoTen(updated.getHoTen());
            t.setSoDienThoai(updated.getSoDienThoai());
            t.setTrangThai(updated.getTrangThai());
            // Đổi mật khẩu nếu có truyền vào
            if (updated.getMatKhau() != null && !updated.getMatKhau().isBlank()) {
                t.setMatKhau(passwordEncoder.encode(updated.getMatKhau()));
            }
            return ResponseEntity.ok(userRepository.save(t));
        }).orElse(ResponseEntity.notFound().build());
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> deleteTechnician(@PathVariable Long id) {
        if (!userRepository.existsById(id)) return ResponseEntity.notFound().build();
        userRepository.deleteById(id);
        return ResponseEntity.ok().build();
    }
}
