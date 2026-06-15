package com.example.demo.repository;
import com.example.demo.entity.DonViBaoTri;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface DonViBaoTriRepository extends JpaRepository<DonViBaoTri, Long> {}
