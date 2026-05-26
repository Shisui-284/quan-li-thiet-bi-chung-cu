package com.example.demo.repository;

import com.example.demo.entity.ThietBi;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface DeviceRepository extends JpaRepository<ThietBi, Long> {
    // Kế thừa JpaRepository đã có sẵn các hàm cơ bản như findAll(), findById(),
    // save(), deleteById()
}