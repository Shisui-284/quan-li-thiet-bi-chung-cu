package com.example.demo.entity;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "phieu_bao_hong")
public class PhieuBaoHong {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ma_phieu")
    private Long id;

    @Column(name = "tieu_de", columnDefinition = "nvarchar(255)")
    private String tieuDe;

    @Column(name = "mo_ta_loi", columnDefinition = "nvarchar(MAX)")
    private String moTaLoi;

    @Column(name = "muc_do_uu_tien")
    private String mucDoUuTien;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "nguoi_xu_ly_id")
    private NguoiDung nguoiXuLy;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "nguoi_tao_id")
    private NguoiDung nguoiTao;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "ma_thiet_bi")
    private ThietBi thietBi;

    @Column(name = "trang_thai")
    private String trangThai;

    @Column(name = "ngay_tao")
    private LocalDateTime ngayTao;



    @Column(name = "ghi_chu_ket_qua", columnDefinition = "nvarchar(MAX)")
    private String ghiChuKetQua;

    @Column(name = "anh_nghiem_thu")
    private String anhNghiemThu;

    @Column(name = "ngay_hoan_thanh")
    private LocalDateTime ngayHoanThanh;
    public String getGhiChuKetQua() {
        return ghiChuKetQua;
        }

    public void setGhiChuKetQua(String ghiChuKetQua) {
        this.ghiChuKetQua = ghiChuKetQua;
        }

    public String getAnhNghiemThu() {
        return anhNghiemThu;
        }

    public void setAnhNghiemThu(String anhNghiemThu) {
        this.anhNghiemThu = anhNghiemThu;
        }

    public LocalDateTime getNgayHoanThanh() {
        return ngayHoanThanh;
        }

    public void setNgayHoanThanh(LocalDateTime ngayHoanThanh) {
        this.ngayHoanThanh = ngayHoanThanh;
        }






















    public PhieuBaoHong() {
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getTieuDe() {
        return tieuDe;
    }

    public void setTieuDe(String tieuDe) {
        this.tieuDe = tieuDe;
    }

    public String getMoTaLoi() {
        return moTaLoi;
    }

    public void setMoTaLoi(String moTaLoi) {
        this.moTaLoi = moTaLoi;
    }

    public String getMucDoUuTien() {
        return mucDoUuTien;
    }

    public void setMucDoUuTien(String mucDoUuTien) {
        this.mucDoUuTien = mucDoUuTien;
    }

    public NguoiDung getNguoiXuLy() {
        return nguoiXuLy;
    }

    public void setNguoiXuLy(NguoiDung nguoiXuLy) {
        this.nguoiXuLy = nguoiXuLy;
    }

    public NguoiDung getNguoiTao() {
        return nguoiTao;
    }

    public void setNguoiTao(NguoiDung nguoiTao) {
        this.nguoiTao = nguoiTao;
    }

    public ThietBi getThietBi() {
        return thietBi;
    }

    public void setThietBi(ThietBi thietBi) {
        this.thietBi = thietBi;
    }

    public String getTrangThai() {
        return trangThai;
    }

    public void setTrangThai(String trangThai) {
        this.trangThai = trangThai;
    }

    public LocalDateTime getNgayTao() {
        return ngayTao;
    }

    public void setNgayTao(LocalDateTime ngayTao) {
        this.ngayTao = ngayTao;
    }
}
