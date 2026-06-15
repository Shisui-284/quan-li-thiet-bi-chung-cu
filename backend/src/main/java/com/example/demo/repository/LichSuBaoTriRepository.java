package com.example.demo.repository;
import com.example.demo.entity.LichSuBaoTri;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface LichSuBaoTriRepository extends JpaRepository<LichSuBaoTri, Long> {}
