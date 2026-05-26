package com.example.demo.service;

import com.example.demo.entity.ThietBi;
import com.example.demo.repository.DeviceRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class DeviceService {

    @Autowired
    private DeviceRepository deviceRepository;

    public List<ThietBi> getAllDevices() {
        return deviceRepository.findAll();
    }

    public ThietBi getDeviceById(Long id) {
        // Thêm dòng kiểm tra an toàn này để hết cảnh báo vàng
        if (id == null)
            throw new IllegalArgumentException("ID không được để trống");

        return deviceRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Lỗi: Không tìm thấy thiết bị có mã " + id));
    }
}