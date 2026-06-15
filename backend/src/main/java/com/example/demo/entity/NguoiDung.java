package com.example.demo.entity;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import jakarta.persistence.*;

@Entity
@Table(name = "nguoi_dung")
@JsonIgnoreProperties({ "hibernateLazyInitializer", "handler" })
public class NguoiDung {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long maNguoiDung;

    @Column(name = "ten_dang_nhap")
    private String tenDangNhap;

    @Column(name = "mat_khau")
    private String matKhau;



    @Column(name = "vai_tro")
    private String vaiTro;

    @Column(name = "ho_ten", columnDefinition = "nvarchar(100)")
    private String hoTen;

    @Column(name = "so_dien_thoai")
    private String soDienThoai;

    @Column(name = "trang_thai")
    private String trangThai;

    @Column(name = "ngay_tao")
    private java.time.LocalDateTime ngayTao;
    public String getVaiTro() {
    return vaiTro;
}

    public void setVaiTro(String vaiTro) {
        this.vaiTro = vaiTro;
}



    public NguoiDung() {
    }

    public Long getMaNguoiDung() {
        return maNguoiDung;
    }

    public void setMaNguoiDung(Long maNguoiDung) {
        this.maNguoiDung = maNguoiDung;
    }

    public String getTenDangNhap() {
        return tenDangNhap;
    }

    public void setTenDangNhap(String tenDangNhap) {
        this.tenDangNhap = tenDangNhap;
    }

    public String getMatKhau() {
        return matKhau;
    }

    public void setMatKhau(String matKhau) {
        this.matKhau = matKhau;
    }

    public String getHoTen() {
        return hoTen;
    }

    public void setHoTen(String hoTen) {
        this.hoTen = hoTen;
    }

    public String getSoDienThoai() {
        return soDienThoai;
    }

    public void setSoDienThoai(String soDienThoai) {
        this.soDienThoai = soDienThoai;
    }

    public String getTrangThai() {
        return trangThai;
    }

    public void setTrangThai(String trangThai) {
        this.trangThai = trangThai;
    }

    public java.time.LocalDateTime getNgayTao() {
        return ngayTao;
    }

    public void setNgayTao(java.time.LocalDateTime ngayTao) {
        this.ngayTao = ngayTao;
    }
}
