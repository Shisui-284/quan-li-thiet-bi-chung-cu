package com.example.demo.controller;

import com.example.demo.entity.ThietBi;
import com.example.demo.service.DeviceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/devices")
@CrossOrigin(origins = "*")
public class DeviceController {

    @Autowired
    private DeviceService deviceService;

    // API lấy toàn bộ danh mục thiết bị
    @GetMapping
    public ResponseEntity<List<ThietBi>> getAllDevices() {
        return ResponseEntity.ok(deviceService.getAllDevices());
    }
}