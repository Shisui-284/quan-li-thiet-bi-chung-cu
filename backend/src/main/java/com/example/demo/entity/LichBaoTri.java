package com.example.demo.entity;
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
