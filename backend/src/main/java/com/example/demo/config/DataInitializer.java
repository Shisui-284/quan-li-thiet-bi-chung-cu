package com.example.demo.config;

import com.example.demo.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;

@Component
public class DataInitializer implements CommandLineRunner {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Override
    public void run(String... args) throws Exception {

        // 1. ÉP cập nhật mật khẩu cho Admin
        userRepository.findByTenDangNhap("admin").ifPresent(admin -> {
            admin.setMatKhau(passwordEncoder.encode("Admin@123"));
            userRepository.save(admin);
            System.out.println("---> THÀNH CÔNG: Đã băm mật khẩu thật cho Admin!");
        });

        // 2. ÉP cập nhật mật khẩu cho Thợ Kỹ Thuật
        userRepository.findByTenDangNhap("kythuat01").ifPresent(tech -> {
            tech.setMatKhau(passwordEncoder.encode("Admin@123"));
            userRepository.save(tech);
            System.out.println("---> THÀNH CÔNG: Đã băm mật khẩu thật cho Kỹ Thuật!");
        });
    }
}
