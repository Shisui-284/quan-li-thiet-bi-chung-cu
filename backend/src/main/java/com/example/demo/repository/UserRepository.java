package com.example.demo.repository;

import com.example.demo.entity.NguoiDung;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.Optional;

@Repository
public interface UserRepository extends JpaRepository<NguoiDung, Long> {
    // Phải khớp với field 'tenDangNhap' trong NguoiDung.java
    Optional<NguoiDung> findByTenDangNhap(String tenDangNhap);
    java.util.List<NguoiDung> findByVaiTro(String vaiTro);
}