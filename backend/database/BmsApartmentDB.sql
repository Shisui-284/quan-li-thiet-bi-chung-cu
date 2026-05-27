USE [master]
GO

IF DB_ID('BmsApartmentDB') IS NOT NULL
BEGIN
    ALTER DATABASE [BmsApartmentDB] SET SINGLE_USER WITH ROLLBACK IMMEDIATE
    DROP DATABASE [BmsApartmentDB]
END
GO

CREATE DATABASE [BmsApartmentDB]
GO

USE [BmsApartmentDB]
GO

/* =========================
   TABLE: nguoi_dung
========================= */
CREATE TABLE nguoi_dung (
    ma_nguoi_dung INT IDENTITY(1,1) PRIMARY KEY,
    ten_dang_nhap VARCHAR(50) NOT NULL UNIQUE,
    mat_khau VARCHAR(255) NOT NULL,
    ho_ten NVARCHAR(100) NOT NULL,
    so_dien_thoai VARCHAR(20),
    vai_tro VARCHAR(30) NOT NULL,
    trang_thai VARCHAR(30) NOT NULL DEFAULT 'HOAT_DONG',
    ngay_tao DATETIME NOT NULL DEFAULT GETDATE(),

    CONSTRAINT chk_vai_tro
    CHECK (vai_tro IN ('ADMIN', 'KY_THUAT', 'LE_TAN')),

    CONSTRAINT chk_trang_thai_nd
    CHECK (trang_thai IN ('HOAT_DONG', 'KHOA'))
)
GO

/* =========================
   TABLE: thiet_bi
========================= */
CREATE TABLE thiet_bi (
    ma_thiet_bi INT IDENTITY(1,1) PRIMARY KEY,
    ten_thiet_bi NVARCHAR(255),
    loai_thiet_bi VARCHAR(50) NOT NULL,
    vi_tri NVARCHAR(255) NOT NULL,
    trang_thai VARCHAR(30) NOT NULL DEFAULT 'HOAT_DONG',
    ngay_tao DATETIME NOT NULL DEFAULT GETDATE(),

    CONSTRAINT chk_loai_tb
    CHECK (loai_thiet_bi IN (
        'THANG_MAY',
        'MAY_PHAT',
        'DEN_HANH_LANG',
        'KHAC'
    )),

    CONSTRAINT chk_trang_thai_tb
    CHECK (trang_thai IN (
        'HOAT_DONG',
        'DANG_BAO_TRI',
        'HONG',
        'NGUNG_SU_DUNG'
    ))
)
GO

/* =========================
   TABLE: don_vi_bao_tri
========================= */
CREATE TABLE don_vi_bao_tri (
    ma_don_vi INT IDENTITY(1,1) PRIMARY KEY,
    ten_don_vi NVARCHAR(150) NOT NULL,
    nguoi_lien_he NVARCHAR(100),
    so_dien_thoai VARCHAR(20) NOT NULL,
    ghi_chu NVARCHAR(500),
    trang_thai VARCHAR(30) NOT NULL DEFAULT 'HOP_TAC',

    CONSTRAINT chk_trang_thai_dv
    CHECK (trang_thai IN ('HOP_TAC', 'NGUNG_HOP_TAC'))
)
GO

/* =========================
   TABLE: lich_bao_tri
========================= */
CREATE TABLE lich_bao_tri (
    ma_lich INT IDENTITY(1,1) PRIMARY KEY,
    ma_thiet_bi INT NOT NULL,
    ma_don_vi INT NULL,
    chu_ky_ngay INT NOT NULL DEFAULT 30,
    ngay_bao_tri_gan_nhat DATETIME,
    ngay_bao_tri_tiep_theo DATETIME NOT NULL,
    trang_thai VARCHAR(30) NOT NULL DEFAULT 'DANG_THEO_DOI',

    CONSTRAINT fk_lbt_thiet_bi
    FOREIGN KEY (ma_thiet_bi)
    REFERENCES thiet_bi(ma_thiet_bi),

    CONSTRAINT fk_lbt_don_vi
    FOREIGN KEY (ma_don_vi)
    REFERENCES don_vi_bao_tri(ma_don_vi),

    CONSTRAINT chk_chu_ky
    CHECK (chu_ky_ngay > 0),

    CONSTRAINT chk_trang_thai_lbt
    CHECK (trang_thai IN ('DANG_THEO_DOI', 'TAM_DUNG'))
)
GO

/* =========================
   TABLE: lich_su_bao_tri
========================= */
CREATE TABLE lich_su_bao_tri (
    ma_lich_su INT IDENTITY(1,1) PRIMARY KEY,
    ma_thiet_bi INT NOT NULL,
    ma_don_vi INT NOT NULL,
    ngay_thuc_hien DATETIME NOT NULL,
    chi_phi DECIMAL(18,2) DEFAULT 0,
    mo_ta_cong_viec NVARCHAR(MAX),
    anh_bien_ban VARCHAR(500),
    ngay_tao DATETIME NOT NULL DEFAULT GETDATE(),

    CONSTRAINT fk_ls_thiet_bi
    FOREIGN KEY (ma_thiet_bi)
    REFERENCES thiet_bi(ma_thiet_bi),

    CONSTRAINT fk_ls_don_vi
    FOREIGN KEY (ma_don_vi)
    REFERENCES don_vi_bao_tri(ma_don_vi),

    CONSTRAINT chk_chi_phi
    CHECK (chi_phi >= 0)
)
GO

/* =========================
   TABLE: phieu_bao_hong
========================= */
CREATE TABLE phieu_bao_hong (
    ma_phieu INT IDENTITY(1,1) PRIMARY KEY,
    tieu_de NVARCHAR(255),
    mo_ta_loi NVARCHAR(MAX),
    ma_thiet_bi INT NOT NULL,
    muc_do_uu_tien VARCHAR(20) NOT NULL DEFAULT 'TRUNG_BINH',
    trang_thai VARCHAR(30) NOT NULL DEFAULT 'CHO_PHAN_CONG',
    nguoi_tao_id INT NULL,
    nguoi_xu_ly_id INT NULL,
    ghi_chu_ket_qua NVARCHAR(MAX),
    anh_nghiem_thu VARCHAR(500),
    ngay_tao DATETIME NOT NULL DEFAULT GETDATE(),
    ngay_hoan_thanh DATETIME NULL,

    CONSTRAINT fk_pbh_thiet_bi
    FOREIGN KEY (ma_thiet_bi)
    REFERENCES thiet_bi(ma_thiet_bi),

    CONSTRAINT fk_pbh_nguoi_tao
    FOREIGN KEY (nguoi_tao_id)
    REFERENCES nguoi_dung(ma_nguoi_dung),

    CONSTRAINT fk_pbh_nguoi_xu_ly
    FOREIGN KEY (nguoi_xu_ly_id)
    REFERENCES nguoi_dung(ma_nguoi_dung),

    CONSTRAINT chk_muc_do
    CHECK (muc_do_uu_tien IN (
        'THAP',
        'TRUNG_BINH',
        'CAO',
        'KHAN_CAP'
    )),

    CONSTRAINT chk_trang_thai_pbh
    CHECK (trang_thai IN (
        'CHO_PHAN_CONG',
        'DA_PHAN_CONG',
        'DANG_SUA',
        'HOAN_THANH'
    ))
)
GO

/* =========================
   INDEX
========================= */
CREATE INDEX idx_fk_lich_thiet_bi
ON lich_bao_tri(ma_thiet_bi)
GO

CREATE INDEX idx_lich_ngay_tiep_theo
ON lich_bao_tri(ngay_bao_tri_tiep_theo)
GO

CREATE INDEX idx_fk_lichsu_thiet_bi
ON lich_su_bao_tri(ma_thiet_bi)
GO

CREATE INDEX idx_fk_lichsu_don_vi
ON lich_su_bao_tri(ma_don_vi)
GO

CREATE INDEX idx_fk_phieu_thiet_bi
ON phieu_bao_hong(ma_thiet_bi)
GO

CREATE INDEX idx_phieu_ky_thuat
ON phieu_bao_hong(nguoi_xu_ly_id)
GO

CREATE INDEX idx_phieu_trang_thai
ON phieu_bao_hong(trang_thai)
GO

/* =========================
   DỮ LIỆU MẪU
========================= */

INSERT INTO nguoi_dung (
    ten_dang_nhap,
    mat_khau,
    ho_ten,
    so_dien_thoai,
    vai_tro
)
VALUES
(
    'admin',
    '$2a$10$W6S8gb9lXB/ZlxCLezVC.ev.rtmx4HRyjq3A9l2UGgbGn0pr2r9Oq',
    N'Quản Trị Viên Hệ Thống',
    '0901234567',
    'ADMIN'
),
(
    'kythuat01',
    '$2a$10$k4mDtr54hHijCcvXllBKCOmouwnQmVZaV/WHwKNvuDTwu1DTp4DsS',
    N'Trần Văn Chung',
    '0988111222',
    'KY_THUAT'
)
GO

INSERT INTO thiet_bi (
    ten_thiet_bi,
    loai_thiet_bi,
    vi_tri
)
VALUES
(
    N'Thang máy Otis tải trọng 1000kg',
    'THANG_MAY',
    N'Trục kỹ thuật Block A1'
),
(
    N'Máy phát Cummins dự phòng 250kVA',
    'MAY_PHAT',
    N'Phòng kỹ thuật tầng hầm'
),
(
    N'Hệ thống đèn sảnh chính',
    'DEN_HANH_LANG',
    N'Sảnh tầng 1 Block A'
)
GO

INSERT INTO don_vi_bao_tri (
    ten_don_vi,
    nguoi_lien_he,
    so_dien_thoai,
    ghi_chu
)
VALUES
(
    N'Công ty Thang máy Otis VN',
    N'Nguyễn Văn A - Kỹ sư trưởng',
    '19001111',
    N'Hợp đồng bảo trì trọn gói 2026'
),
(
    N'Điện lực Tân Bình',
    N'Hotline Sự Cố',
    '19002222',
    N'Liên hệ khi mất điện lưới'
)
GO

INSERT INTO lich_bao_tri (
    ma_thiet_bi,
    ma_don_vi,
    chu_ky_ngay,
    ngay_bao_tri_gan_nhat,
    ngay_bao_tri_tiep_theo
)
VALUES
(
    1,
    1,
    30,
    '2026-05-01',
    '2026-05-31'
),
(
    2,
    NULL,
    90,
    '2026-03-01',
    '2026-05-30'
)
GO

INSERT INTO phieu_bao_hong (
    tieu_de,
    mo_ta_loi,
    ma_thiet_bi,
    muc_do_uu_tien,
    trang_thai,
    nguoi_xu_ly_id
)
VALUES
(
    N'Cháy đèn',
    N'Đèn sảnh tầng 1 bị cháy',
    3,
    'CAO',
    'DANG_SUA',
    2
)
GO