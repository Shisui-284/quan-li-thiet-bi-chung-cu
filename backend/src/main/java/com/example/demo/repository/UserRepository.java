package com.example.demo.repository;

import com.example.demo.entity.NguoiDung;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.Optional;

@Repository
public interface UserRepository extends JpaRepository<NguoiDung, Long> {
    // Hàm tìm kiếm người dùng bằng tên đăng nhập phục vụ cho logic Login
    Optional<NguoiDung> findByTenDangNhap(String tenDangNhap);
}