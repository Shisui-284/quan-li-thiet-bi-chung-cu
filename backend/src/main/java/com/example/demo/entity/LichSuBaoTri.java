package com.example.demo.entity;
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
