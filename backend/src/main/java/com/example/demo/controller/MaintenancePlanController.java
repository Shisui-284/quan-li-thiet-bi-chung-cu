package com.example.demo.controller;

import com.example.demo.DTO.MaintenancePlanDTO;
import com.example.demo.entity.LichBaoTri;
import com.example.demo.entity.ThietBi;
import com.example.demo.entity.DonViBaoTri;
import com.example.demo.repository.LichBaoTriRepository;
import com.example.demo.repository.DeviceRepository;
import com.example.demo.repository.DonViBaoTriRepository;
import com.example.demo.service.MaintenancePlanService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

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
    @Autowired
    private MaintenancePlanService maintenancePlanService;

    @GetMapping
    public ResponseEntity<List<LichBaoTri>> getAll() {
        return ResponseEntity.ok(repo.findAll());
    }

    /**
     * Lấy tất cả kế hoạch bảo trì với thông tin cảnh báo
     */
    @GetMapping("/with-status")
    public ResponseEntity<List<MaintenancePlanDTO>> getAllWithStatus() {
        List<LichBaoTri> plans = maintenancePlanService.getAllMaintenancePlansWithStatus();
        List<MaintenancePlanDTO> dtos = plans.stream().map(plan -> {
            String alertStatus = maintenancePlanService.calculateAlertStatus(plan.getNgayBaoTriTiepTheo());
            Long daysRemaining = maintenancePlanService.calculateDaysRemaining(plan.getNgayBaoTriTiepTheo());
            return new MaintenancePlanDTO(
                    plan.getId(),
                    plan.getThietBi(),
                    plan.getDonVi(),
                    plan.getChuKyNgay(),
                    plan.getNgayBaoTriGanNhat(),
                    plan.getNgayBaoTriTiepTheo(),
                    plan.getTrangThai(),
                    alertStatus,
                    daysRemaining
            );
        }).collect(Collectors.toList());
        return ResponseEntity.ok(dtos);
    }

    /**
     * Lấy danh sách kế hoạch cần cảnh báo (DANGER hoặc WARNING)
     */
    @GetMapping("/alerts")
    public ResponseEntity<List<MaintenancePlanDTO>> getAlerts() {
        List<LichBaoTri> alertPlans = maintenancePlanService.getAlertMaintenancePlans();
        List<MaintenancePlanDTO> dtos = alertPlans.stream().map(plan -> {
            String alertStatus = maintenancePlanService.calculateAlertStatus(plan.getNgayBaoTriTiepTheo());
            Long daysRemaining = maintenancePlanService.calculateDaysRemaining(plan.getNgayBaoTriTiepTheo());
            return new MaintenancePlanDTO(
                    plan.getId(),
                    plan.getThietBi(),
                    plan.getDonVi(),
                    plan.getChuKyNgay(),
                    plan.getNgayBaoTriGanNhat(),
                    plan.getNgayBaoTriTiepTheo(),
                    plan.getTrangThai(),
                    alertStatus,
                    daysRemaining
            );
        }).collect(Collectors.toList());
        return ResponseEntity.ok(dtos);
    }

    @PostMapping
    public ResponseEntity<?> create(@RequestBody Map<String, Object> body) {
        LichBaoTri plan = new LichBaoTri();
        if (body.get("trangThai") == null)
            plan.setTrangThai("DANG_THEO_DOI");
        else
            plan.setTrangThai((String) body.get("trangThai"));
        
        plan.setChuKyNgay((Integer) body.get("chuKyNgay"));
        
        if (body.get("ngayBaoTriGanNhat") != null)
            plan.setNgayBaoTriGanNhat(java.time.LocalDateTime.parse((String) body.get("ngayBaoTriGanNhat")));
        else
            plan.setNgayBaoTriGanNhat(java.time.LocalDateTime.now());
        
        // Tính toán ngayBaoTriTiepTheo nếu không được cung cấp
        if (body.get("ngayBaoTriTiepTheo") != null) {
            plan.setNgayBaoTriTiepTheo(java.time.LocalDateTime.parse((String) body.get("ngayBaoTriTiepTheo")));
        } else if (plan.getChuKyNgay() != null) {
            LocalDateTime nextDate = maintenancePlanService.calculateNextMaintenanceDate(
                    plan.getNgayBaoTriGanNhat(),
                    plan.getChuKyNgay()
            );
            plan.setNgayBaoTriTiepTheo(nextDate);
        }

        Long maThietBi = body.get("maThietBi") != null ? Long.valueOf(body.get("maThietBi").toString()) : null;
        if (maThietBi != null)
            deviceRepo.findById(maThietBi).ifPresent(plan::setThietBi);

        Long maDonVi = body.get("maDonVi") != null ? Long.valueOf(body.get("maDonVi").toString()) : null;
        if (maDonVi != null)
            donViRepo.findById(maDonVi).ifPresent(plan::setDonVi);

        LichBaoTri saved = repo.save(plan);
        
        // Trả về với thông tin cảnh báo
        String alertStatus = maintenancePlanService.calculateAlertStatus(saved.getNgayBaoTriTiepTheo());
        Long daysRemaining = maintenancePlanService.calculateDaysRemaining(saved.getNgayBaoTriTiepTheo());
        
        MaintenancePlanDTO dto = new MaintenancePlanDTO(
                saved.getId(), saved.getThietBi(), saved.getDonVi(),
                saved.getChuKyNgay(), saved.getNgayBaoTriGanNhat(),
                saved.getNgayBaoTriTiepTheo(), saved.getTrangThai(),
                alertStatus, daysRemaining
        );
        
        return ResponseEntity.ok(dto);
    }

    @PutMapping("/{id}")
    public ResponseEntity<?> update(@PathVariable Long id, @RequestBody Map<String, Object> body) {
        return repo.findById(id).map(p -> {
            if (body.get("trangThai") != null)
                p.setTrangThai((String) body.get("trangThai"));
            if (body.get("chuKyNgay") != null)
                p.setChuKyNgay((Integer) body.get("chuKyNgay"));
            
            if (body.get("ngayBaoTriGanNhat") != null) {
                p.setNgayBaoTriGanNhat(java.time.LocalDateTime.parse((String) body.get("ngayBaoTriGanNhat")));
            }
            
            // Cập nhật ngayBaoTriTiepTheo
            if (body.get("ngayBaoTriTiepTheo") != null) {
                p.setNgayBaoTriTiepTheo(java.time.LocalDateTime.parse((String) body.get("ngayBaoTriTiepTheo")));
            } else if (body.get("chuKyNgay") != null && p.getNgayBaoTriGanNhat() != null) {
                // Tính toán lại nếu chu kỳ thay đổi nhưng ngayBaoTriTiepTheo không được cung cấp
                LocalDateTime nextDate = maintenancePlanService.calculateNextMaintenanceDate(
                        p.getNgayBaoTriGanNhat(),
                        p.getChuKyNgay()
                );
                p.setNgayBaoTriTiepTheo(nextDate);
            }
            
            Long maThietBi = body.get("maThietBi") != null ? Long.valueOf(body.get("maThietBi").toString()) : null;
            if (maThietBi != null)
                deviceRepo.findById(maThietBi).ifPresent(p::setThietBi);
            Long maDonVi = body.get("maDonVi") != null ? Long.valueOf(body.get("maDonVi").toString()) : null;
            if (maDonVi != null)
                donViRepo.findById(maDonVi).ifPresent(p::setDonVi);
            
            LichBaoTri saved = repo.save(p);
            
            // Trả về với thông tin cảnh báo
            String alertStatus = maintenancePlanService.calculateAlertStatus(saved.getNgayBaoTriTiepTheo());
            Long daysRemaining = maintenancePlanService.calculateDaysRemaining(saved.getNgayBaoTriTiepTheo());
            
            MaintenancePlanDTO dto = new MaintenancePlanDTO(
                    saved.getId(), saved.getThietBi(), saved.getDonVi(),
                    saved.getChuKyNgay(), saved.getNgayBaoTriGanNhat(),
                    saved.getNgayBaoTriTiepTheo(), saved.getTrangThai(),
                    alertStatus, daysRemaining
            );
            
            return ResponseEntity.ok(dto);
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
