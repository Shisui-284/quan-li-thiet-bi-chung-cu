package com.example.demo.controller;

import com.example.demo.DTO.LoginRequest;
import com.example.demo.entity.NguoiDung;
import com.example.demo.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;

import java.util.Optional;

@RestController
@RequestMapping("/api/auth")
@CrossOrigin(origins = "*") // Cho phép React gọi API
public class AuthController {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @PostMapping("/login")
    public ResponseEntity<?> login(@RequestBody LoginRequest request) {
        // 1. Tìm người dùng trong Database bằng tên đăng nhập
        Optional<NguoiDung> userOpt = userRepository.findByTenDangNhap(request.getUsername());

        if (userOpt.isPresent()) {
            NguoiDung user = userOpt.get();
            // 2. So sánh mật khẩu người dùng nhập vào với mật khẩu đã băm (BCrypt) trong
            // Database
            if (passwordEncoder.matches(request.getPassword(), user.getMatKhau())) {
                // Nếu đúng, trả về thông tin người dùng (nhưng nhớ giấu mật khẩu đi)
                user.setMatKhau(null);
                return ResponseEntity.ok(user);
            }
        }
        // 3. Nếu sai tài khoản hoặc mật khẩu
        return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Tài khoản hoặc mật khẩu không chính xác!");
    }
}