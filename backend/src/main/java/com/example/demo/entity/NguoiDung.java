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
}
