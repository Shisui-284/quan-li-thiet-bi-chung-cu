package com.example.demo.repository;
import com.example.demo.entity.LichBaoTri;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface LichBaoTriRepository extends JpaRepository<LichBaoTri, Long> {}
