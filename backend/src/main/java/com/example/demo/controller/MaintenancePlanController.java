package com.example.demo.controller;

import com.example.demo.entity.LichBaoTri;
import com.example.demo.entity.ThietBi;
import com.example.demo.entity.DonViBaoTri;
import com.example.demo.repository.LichBaoTriRepository;
import com.example.demo.repository.DeviceRepository;
import com.example.demo.repository.DonViBaoTriRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/maintenance-plans")
@CrossOrigin(origins = "*")
public class MaintenancePlanController {
    @Autowired
    private LichBaoTriRepository repo;
    @Autowired
    private DeviceRepository deviceRepo;
    @Autowired
    private DonViBaoTriRepository donViRepo;

    @GetMapping
    public ResponseEntity<List<LichBaoTri>> getAll() {
        return ResponseEntity.ok(repo.findAll());
    }

    @PostMapping
    public ResponseEntity<?> create(@RequestBody Map<String, Object> body) {
        LichBaoTri plan = new LichBaoTri();
        if (body.get("trangThai") == null)
            plan.setTrangThai("DANG_THEO_DOI");
        else
            plan.setTrangThai((String) body.get("trangThai"));
        plan.setChuKyNgay((Integer) body.get("chuKyNgay"));
        if (body.get("ngayBaoTriTiepTheo") != null)
            plan.setNgayBaoTriTiepTheo(java.time.LocalDateTime.parse((String) body.get("ngayBaoTriTiepTheo")));
        if (body.get("ngayBaoTriGanNhat") != null)
            plan.setNgayBaoTriGanNhat(java.time.LocalDateTime.parse((String) body.get("ngayBaoTriGanNhat")));

        Long maThietBi = body.get("maThietBi") != null ? Long.valueOf(body.get("maThietBi").toString()) : null;
        if (maThietBi != null)
            deviceRepo.findById(maThietBi).ifPresent(plan::setThietBi);

        Long maDonVi = body.get("maDonVi") != null ? Long.valueOf(body.get("maDonVi").toString()) : null;
        if (maDonVi != null)
            donViRepo.findById(maDonVi).ifPresent(plan::setDonVi);

        return ResponseEntity.ok(repo.save(plan));
    }

    @PutMapping("/{id}")
    public ResponseEntity<?> update(@PathVariable Long id, @RequestBody Map<String, Object> body) {
        return repo.findById(id).map(p -> {
            if (body.get("trangThai") != null)
                p.setTrangThai((String) body.get("trangThai"));
            if (body.get("chuKyNgay") != null)
                p.setChuKyNgay((Integer) body.get("chuKyNgay"));
            if (body.get("ngayBaoTriTiepTheo") != null)
                p.setNgayBaoTriTiepTheo(java.time.LocalDateTime.parse((String) body.get("ngayBaoTriTiepTheo")));
            Long maThietBi = body.get("maThietBi") != null ? Long.valueOf(body.get("maThietBi").toString()) : null;
            if (maThietBi != null)
                deviceRepo.findById(maThietBi).ifPresent(p::setThietBi);
            Long maDonVi = body.get("maDonVi") != null ? Long.valueOf(body.get("maDonVi").toString()) : null;
            if (maDonVi != null)
                donViRepo.findById(maDonVi).ifPresent(p::setDonVi);
            return ResponseEntity.ok(repo.save(p));
        }).orElse(ResponseEntity.notFound().build());
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> delete(@PathVariable Long id) {
        if (!repo.existsById(id))
            return ResponseEntity.notFound().build();
        repo.deleteById(id);
        return ResponseEntity.ok().build();
    }
}
