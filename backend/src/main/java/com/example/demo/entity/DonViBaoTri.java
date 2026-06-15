package com.example.demo.entity;
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
