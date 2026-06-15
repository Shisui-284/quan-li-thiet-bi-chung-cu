package com.example.demo.DTO;

public class CreateTicketRequest {
    private Long maThietBi; // Lưu ý: React gửi lên phải là 'maThietBi'
    private String tieuDe;
    private String moTaLoi; // Lưu ý: React gửi lên phải là 'moTaLoi'
    private String mucDoUuTien;

    // 1. Constructor không tham số (BẮT BUỘC để Jackson convert JSON)
    public CreateTicketRequest() {}

    // 2. Constructor đầy đủ (Tiện cho việc khởi tạo)
    public CreateTicketRequest(Long maThietBi, String tieuDe, String moTaLoi, String mucDoUuTien) {
        this.maThietBi = maThietBi;
        this.tieuDe = tieuDe;
        this.moTaLoi = moTaLoi;
        this.mucDoUuTien = mucDoUuTien;
    }

    // 3. Getter & Setter
    public Long getMaThietBi() { return maThietBi; }
    public void setMaThietBi(Long maThietBi) { this.maThietBi = maThietBi; }

    public String getTieuDe() { return tieuDe; }
    public void setTieuDe(String tieuDe) { this.tieuDe = tieuDe; }

    public String getMoTaLoi() { return moTaLoi; }
    public void setMoTaLoi(String moTaLoi) { this.moTaLoi = moTaLoi; }

    public String getMucDoUuTien() { return mucDoUuTien; }
    public void setMucDoUuTien(String mucDoUuTien) { this.mucDoUuTien = mucDoUuTien; }

    // 4. toString() để debug dễ hơn
    @Override
    public String toString() {
        return "CreateTicketRequest{maThietBi=" + maThietBi + ", tieuDe='" + tieuDe + "'}";
    }
}