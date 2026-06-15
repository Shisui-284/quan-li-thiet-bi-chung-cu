package com.example.demo.controller;
import com.example.demo.entity.DonViBaoTri;
import com.example.demo.repository.DonViBaoTriRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/api/contractors")
@CrossOrigin(origins = "*")
public class ContractorController {
    @Autowired
    private DonViBaoTriRepository repo;

    @GetMapping
    public ResponseEntity<List<DonViBaoTri>> getAll() {
        return ResponseEntity.ok(repo.findAll());
    }

    @PostMapping
    public ResponseEntity<DonViBaoTri> create(@RequestBody DonViBaoTri contractor) {
        if (contractor.getTrangThai() == null) contractor.setTrangThai("HOP_TAC");
        return ResponseEntity.ok(repo.save(contractor));
    }

    @PutMapping("/{id}")
    public ResponseEntity<?> update(@PathVariable Long id, @RequestBody DonViBaoTri updated) {
        return repo.findById(id).map(c -> {
            c.setTenDonVi(updated.getTenDonVi());
            c.setNguoiLienHe(updated.getNguoiLienHe());
            c.setSoDienThoai(updated.getSoDienThoai());
            c.setGhiChu(updated.getGhiChu());
            c.setTrangThai(updated.getTrangThai());
            return ResponseEntity.ok(repo.save(c));
        }).orElse(ResponseEntity.notFound().build());
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> delete(@PathVariable Long id) {
        if (!repo.existsById(id)) return ResponseEntity.notFound().build();
        repo.deleteById(id);
        return ResponseEntity.ok().build();
    }
}
