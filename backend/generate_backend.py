import os

base_dir = "src/main/java/com/example/demo"
entity_dir = f"{base_dir}/entity"
repo_dir = f"{base_dir}/repository"
controller_dir = f"{base_dir}/controller"

def write_file(path, content):
    with open(path, "w", encoding="utf-8") as f:
        f.write(content)

don_vi_bao_tri = """package com.example.demo.entity;
import jakarta.persistence.*;

@Entity
@Table(name = "don_vi_bao_tri")
public class DonViBaoTri {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ma_don_vi")
    private Long id;

    @Column(name = "ten_don_vi", columnDefinition = "nvarchar(150)")
    private String tenDonVi;

    @Column(name = "nguoi_lien_he", columnDefinition = "nvarchar(100)")
    private String nguoiLienHe;

    @Column(name = "so_dien_thoai")
    private String soDienThoai;

    @Column(name = "ghi_chu", columnDefinition = "nvarchar(500)")
    private String ghiChu;

    @Column(name = "trang_thai")
    private String trangThai;

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getTenDonVi() { return tenDonVi; }
    public void setTenDonVi(String tenDonVi) { this.tenDonVi = tenDonVi; }
    public String getNguoiLienHe() { return nguoiLienHe; }
    public void setNguoiLienHe(String nguoiLienHe) { this.nguoiLienHe = nguoiLienHe; }
    public String getSoDienThoai() { return soDienThoai; }
    public void setSoDienThoai(String soDienThoai) { this.soDienThoai = soDienThoai; }
    public String getGhiChu() { return ghiChu; }
    public void setGhiChu(String ghiChu) { this.ghiChu = ghiChu; }
    public String getTrangThai() { return trangThai; }
    public void setTrangThai(String trangThai) { this.trangThai = trangThai; }
}
"""

lich_bao_tri = """package com.example.demo.entity;
import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "lich_bao_tri")
public class LichBaoTri {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ma_lich")
    private Long id;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "ma_thiet_bi")
    private ThietBi thietBi;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "ma_don_vi")
    private DonViBaoTri donVi;

    @Column(name = "chu_ky_ngay")
    private Integer chuKyNgay;

    @Column(name = "ngay_bao_tri_gan_nhat")
    private LocalDateTime ngayBaoTriGanNhat;

    @Column(name = "ngay_bao_tri_tiep_theo")
    private LocalDateTime ngayBaoTriTiepTheo;

    @Column(name = "trang_thai")
    private String trangThai;

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public ThietBi getThietBi() { return thietBi; }
    public void setThietBi(ThietBi thietBi) { this.thietBi = thietBi; }
    public DonViBaoTri getDonVi() { return donVi; }
    public void setDonVi(DonViBaoTri donVi) { this.donVi = donVi; }
    public Integer getChuKyNgay() { return chuKyNgay; }
    public void setChuKyNgay(Integer chuKyNgay) { this.chuKyNgay = chuKyNgay; }
    public LocalDateTime getNgayBaoTriGanNhat() { return ngayBaoTriGanNhat; }
    public void setNgayBaoTriGanNhat(LocalDateTime ngayBaoTriGanNhat) { this.ngayBaoTriGanNhat = ngayBaoTriGanNhat; }
    public LocalDateTime getNgayBaoTriTiepTheo() { return ngayBaoTriTiepTheo; }
    public void setNgayBaoTriTiepTheo(LocalDateTime ngayBaoTriTiepTheo) { this.ngayBaoTriTiepTheo = ngayBaoTriTiepTheo; }
    public String getTrangThai() { return trangThai; }
    public void setTrangThai(String trangThai) { this.trangThai = trangThai; }
}
"""

lich_su_bao_tri = """package com.example.demo.entity;
import jakarta.persistence.*;
import java.time.LocalDateTime;
import java.math.BigDecimal;

@Entity
@Table(name = "lich_su_bao_tri")
public class LichSuBaoTri {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ma_lich_su")
    private Long id;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "ma_thiet_bi")
    private ThietBi thietBi;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "ma_don_vi")
    private DonViBaoTri donVi;

    @Column(name = "ngay_thuc_hien")
    private LocalDateTime ngayThucHien;

    @Column(name = "chi_phi")
    private BigDecimal chiPhi;

    @Column(name = "mo_ta_cong_viec", columnDefinition = "nvarchar(MAX)")
    private String moTaCongViec;

    @Column(name = "anh_bien_ban")
    private String anhBienBan;

    @Column(name = "ngay_tao")
    private LocalDateTime ngayTao;

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public ThietBi getThietBi() { return thietBi; }
    public void setThietBi(ThietBi thietBi) { this.thietBi = thietBi; }
    public DonViBaoTri getDonVi() { return donVi; }
    public void setDonVi(DonViBaoTri donVi) { this.donVi = donVi; }
    public LocalDateTime getNgayThucHien() { return ngayThucHien; }
    public void setNgayThucHien(LocalDateTime ngayThucHien) { this.ngayThucHien = ngayThucHien; }
    public BigDecimal getChiPhi() { return chiPhi; }
    public void setChiPhi(BigDecimal chiPhi) { this.chiPhi = chiPhi; }
    public String getMoTaCongViec() { return moTaCongViec; }
    public void setMoTaCongViec(String moTaCongViec) { this.moTaCongViec = moTaCongViec; }
    public String getAnhBienBan() { return anhBienBan; }
    public void setAnhBienBan(String anhBienBan) { this.anhBienBan = anhBienBan; }
    public LocalDateTime getNgayTao() { return ngayTao; }
    public void setNgayTao(LocalDateTime ngayTao) { this.ngayTao = ngayTao; }
}
"""

repo_don_vi = """package com.example.demo.repository;
import com.example.demo.entity.DonViBaoTri;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface DonViBaoTriRepository extends JpaRepository<DonViBaoTri, Long> {}
"""

repo_lich = """package com.example.demo.repository;
import com.example.demo.entity.LichBaoTri;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface LichBaoTriRepository extends JpaRepository<LichBaoTri, Long> {}
"""

repo_lich_su = """package com.example.demo.repository;
import com.example.demo.entity.LichSuBaoTri;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface LichSuBaoTriRepository extends JpaRepository<LichSuBaoTri, Long> {}
"""

ctrl_don_vi = """package com.example.demo.controller;
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
        if(contractor.getTrangThai() == null) contractor.setTrangThai("HOP_TAC");
        return ResponseEntity.ok(repo.save(contractor));
    }
}
"""

ctrl_lich = """package com.example.demo.controller;
import com.example.demo.entity.LichBaoTri;
import com.example.demo.repository.LichBaoTriRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/api/maintenance-plans")
@CrossOrigin(origins = "*")
public class MaintenancePlanController {
    @Autowired
    private LichBaoTriRepository repo;

    @GetMapping
    public ResponseEntity<List<LichBaoTri>> getAll() {
        return ResponseEntity.ok(repo.findAll());
    }

    @PostMapping
    public ResponseEntity<LichBaoTri> create(@RequestBody LichBaoTri plan) {
        if(plan.getTrangThai() == null) plan.setTrangThai("DANG_THEO_DOI");
        return ResponseEntity.ok(repo.save(plan));
    }
}
"""

ctrl_dash = """package com.example.demo.controller;
import com.example.demo.repository.DeviceRepository;
import com.example.demo.repository.TicketRepository;
import com.example.demo.repository.LichBaoTriRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/api/dashboard")
@CrossOrigin(origins = "*")
public class DashboardController {
    @Autowired private DeviceRepository deviceRepo;
    @Autowired private TicketRepository ticketRepo;
    @Autowired private LichBaoTriRepository planRepo;

    @GetMapping("/stats")
    public ResponseEntity<Map<String, Object>> getStats() {
        Map<String, Object> stats = new HashMap<>();
        stats.put("totalDevices", deviceRepo.count());
        stats.put("totalTickets", ticketRepo.count());
        stats.put("totalPlans", planRepo.count());
        // More sophisticated stats can be added later
        return ResponseEntity.ok(stats);
    }
}
"""

write_file(f"{entity_dir}/DonViBaoTri.java", don_vi_bao_tri)
write_file(f"{entity_dir}/LichBaoTri.java", lich_bao_tri)
write_file(f"{entity_dir}/LichSuBaoTri.java", lich_su_bao_tri)

write_file(f"{repo_dir}/DonViBaoTriRepository.java", repo_don_vi)
write_file(f"{repo_dir}/LichBaoTriRepository.java", repo_lich)
write_file(f"{repo_dir}/LichSuBaoTriRepository.java", repo_lich_su)

write_file(f"{controller_dir}/ContractorController.java", ctrl_don_vi)
write_file(f"{controller_dir}/MaintenancePlanController.java", ctrl_lich)
write_file(f"{controller_dir}/DashboardController.java", ctrl_dash)

print("Backend scaffolding completed.")
