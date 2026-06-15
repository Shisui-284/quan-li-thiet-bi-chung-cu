package com.example.demo.controller;

import com.example.demo.entity.ThietBi;
import com.example.demo.repository.DeviceRepository;
import com.example.demo.service.DeviceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.List;

@RestController
@RequestMapping("/api/devices")
@CrossOrigin(origins = "*")
public class DeviceController {

    @Autowired private DeviceService deviceService;
    @Autowired private DeviceRepository deviceRepository;

    @GetMapping
    public ResponseEntity<List<ThietBi>> getAllDevices() {
        return ResponseEntity.ok(deviceService.getAllDevices());
    }

    @PostMapping
    public ResponseEntity<ThietBi> createDevice(@RequestBody ThietBi device) {
        if (device.getTrangThai() == null) device.setTrangThai("HOAT_DONG");
        device.setNgayTao(LocalDateTime.now());
        return ResponseEntity.ok(deviceRepository.save(device));
    }

    @PutMapping("/{id}")
    public ResponseEntity<?> updateDevice(@PathVariable Long id, @RequestBody ThietBi updated) {
        return deviceRepository.findById(id).map(d -> {
            d.setTenThietBi(updated.getTenThietBi());
            d.setLoaiThietBi(updated.getLoaiThietBi());
            d.setViTri(updated.getViTri());
            d.setTrangThai(updated.getTrangThai());
            return ResponseEntity.ok(deviceRepository.save(d));
        }).orElse(ResponseEntity.notFound().build());
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> deleteDevice(@PathVariable Long id) {
        if (!deviceRepository.existsById(id)) return ResponseEntity.notFound().build();
        deviceRepository.deleteById(id);
        return ResponseEntity.ok().build();
    }
}