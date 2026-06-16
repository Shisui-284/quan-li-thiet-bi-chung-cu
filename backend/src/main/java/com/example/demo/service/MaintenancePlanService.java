package com.example.demo.service;

import com.example.demo.entity.LichBaoTri;
import com.example.demo.repository.LichBaoTriRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class MaintenancePlanService {

    @Autowired
    private LichBaoTriRepository lichBaoTriRepository;

    /**
     * Tính toán ngayBaoTriTiepTheo = ngayBaoTriGanNhat + chuKyNgay
     */
    public LocalDateTime calculateNextMaintenanceDate(LocalDateTime lastDate, Integer cycleDays) {
        if (lastDate == null || cycleDays == null || cycleDays <= 0) {
            return null;
        }
        return lastDate.plusDays(cycleDays);
    }

    /**
     * Phân loại mức độ cảnh báo dựa trên số ngày còn lại
     * DANGER: quá hạn (< 0 ngày) - Thẻ Đỏ
     * WARNING: ≤ 3 ngày - Thẻ Vàng
     * SAFE: > 3 ngày - Thẻ Xanh
     */
    public String calculateAlertStatus(LocalDateTime nextMaintenanceDate) {
        if (nextMaintenanceDate == null) {
            return "UNKNOWN";
        }

        LocalDateTime now = LocalDateTime.now();
        long daysRemaining = ChronoUnit.DAYS.between(now, nextMaintenanceDate);

        if (daysRemaining < 0) {
            return "DANGER"; // Quá hạn
        } else if (daysRemaining <= 3) {
            return "WARNING"; // Sắp hết hạn (≤ 3 ngày)
        } else {
            return "SAFE"; // Còn lâu
        }
    }

    /**
     * Tính số ngày còn lại
     */
    public Long calculateDaysRemaining(LocalDateTime nextMaintenanceDate) {
        if (nextMaintenanceDate == null) {
            return null;
        }
        LocalDateTime now = LocalDateTime.now();
        return ChronoUnit.DAYS.between(now, nextMaintenanceDate);
    }

    /**
     * Lấy tất cả kế hoạch bảo trì với trạng thái cảnh báo
     */
    public List<LichBaoTri> getAllMaintenancePlansWithStatus() {
        return lichBaoTriRepository.findAll();
    }

    /**
     * Cập nhật và tính toán ngayBaoTriTiepTheo khi lưu kế hoạch
     */
    public LichBaoTri createOrUpdateMaintenancePlan(LichBaoTri plan) {
        // Nếu chưa có ngayBaoTriGanNhat, lấy ngày hiện tại
        if (plan.getNgayBaoTriGanNhat() == null) {
            plan.setNgayBaoTriGanNhat(LocalDateTime.now());
        }

        // Tính ngayBaoTriTiepTheo nếu chưa có
        if (plan.getNgayBaoTriTiepTheo() == null && plan.getChuKyNgay() != null) {
            LocalDateTime nextDate = calculateNextMaintenanceDate(plan.getNgayBaoTriGanNhat(), plan.getChuKyNgay());
            plan.setNgayBaoTriTiepTheo(nextDate);
        }

        return lichBaoTriRepository.save(plan);
    }

    /**
     * Lấy danh sách kế hoạch cảnh báo (DANGER hoặc WARNING)
     */
    public List<LichBaoTri> getAlertMaintenancePlans() {
        return getAllMaintenancePlansWithStatus().stream()
                .filter(plan -> {
                    String status = calculateAlertStatus(plan.getNgayBaoTriTiepTheo());
                    return "DANGER".equals(status) || "WARNING".equals(status);
                })
                .collect(Collectors.toList());
    }

    /**
     * Lấy thông tin chi tiết kế hoạch với trạng thái
     */
    public LichBaoTri getMaintenancePlanWithStatus(Long id) {
        return lichBaoTriRepository.findById(id).orElse(null);
    }
}
