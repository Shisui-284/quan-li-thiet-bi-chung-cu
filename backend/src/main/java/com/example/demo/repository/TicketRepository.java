package com.example.demo.repository;

import com.example.demo.entity.PhieuBaoHong;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface TicketRepository extends JpaRepository<PhieuBaoHong, Long> {

    // Tối ưu hóa cho giao diện Thợ kỹ thuật: Lấy danh sách phiếu được giao theo
    // trạng thái công việc
    @Query("SELECT p FROM PhieuBaoHong p WHERE p.nguoiXuLy.maNguoiDung = :techId AND p.trangThai = :status")
    List<PhieuBaoHong> findByNguoiXuLyAndTrangThai(@Param("techId") Long techId, @Param("status") String status);

    // Sử dụng LEFT JOIN FETCH để gom dữ liệu từ nhiều bảng (Thiết bị, Người tạo,
    // Người xử lý)
    // Giúp hiển thị toàn bộ danh sách phiếu trên màn hình Admin Dashboard mà không
    // bị sót dữ liệu
    @Query("SELECT p FROM PhieuBaoHong p " +
            "LEFT JOIN FETCH p.thietBi " +
            "LEFT JOIN FETCH p.nguoiTao " +
            "LEFT JOIN FETCH p.nguoiXuLy " +
            "ORDER BY p.ngayTao DESC")
    List<PhieuBaoHong> findTicketManagementGrid();
}