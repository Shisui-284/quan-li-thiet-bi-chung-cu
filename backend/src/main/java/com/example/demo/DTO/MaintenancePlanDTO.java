package com.example.demo.DTO;

import com.example.demo.entity.DonViBaoTri;
import com.example.demo.entity.ThietBi;
import java.time.LocalDateTime;

/**
 * DTO cho Lịch Bảo Trì với thông tin cảnh báo
 */
public class MaintenancePlanDTO {
    private Long id;
    private ThietBi thietBi;
    private DonViBaoTri donVi;
    private Integer chuKyNgay;
    private LocalDateTime ngayBaoTriGanNhat;
    private LocalDateTime ngayBaoTriTiepTheo;
    private String trangThai;
    
    // Thông tin cảnh báo
    private String alertStatus;  // DANGER, WARNING, SAFE
    private Long daysRemaining;  // Số ngày còn lại
    private String statusBadge;  // Tiêu đề hiển thị

    public MaintenancePlanDTO() {
    }

    public MaintenancePlanDTO(Long id, ThietBi thietBi, DonViBaoTri donVi, 
                             Integer chuKyNgay, LocalDateTime ngayBaoTriGanNhat,
                             LocalDateTime ngayBaoTriTiepTheo, String trangThai,
                             String alertStatus, Long daysRemaining) {
        this.id = id;
        this.thietBi = thietBi;
        this.donVi = donVi;
        this.chuKyNgay = chuKyNgay;
        this.ngayBaoTriGanNhat = ngayBaoTriGanNhat;
        this.ngayBaoTriTiepTheo = ngayBaoTriTiepTheo;
        this.trangThai = trangThai;
        this.alertStatus = alertStatus;
        this.daysRemaining = daysRemaining;
        this.statusBadge = generateStatusBadge(alertStatus, daysRemaining);
    }

    private String generateStatusBadge(String status, Long days) {
        if ("DANGER".equals(status)) {
            if (days < 0) {
                return "QUÁ HẠN " + Math.abs(days) + " NGÀY";
            } else if (days == 0) {
                return "HẾT HẠN HÔM NAY";
            }
        } else if ("WARNING".equals(status)) {
            return "CÒN " + days + " NGÀY";
        }
        return "SAFE";
    }

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

    public String getAlertStatus() { return alertStatus; }
    public void setAlertStatus(String alertStatus) { this.alertStatus = alertStatus; }

    public Long getDaysRemaining() { return daysRemaining; }
    public void setDaysRemaining(Long daysRemaining) { this.daysRemaining = daysRemaining; }

    public String getStatusBadge() { return statusBadge; }
    public void setStatusBadge(String statusBadge) { this.statusBadge = statusBadge; }
}
