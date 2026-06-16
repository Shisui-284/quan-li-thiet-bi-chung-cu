USE [master]
GO
DROP DATABASE BmsApartmentDB;
GO

-- 1. Kiểm tra và xóa Database nếu đã tồn tại để tránh lỗi
IF EXISTS (SELECT name FROM sys.databases WHERE name = N'BmsApartmentDB')
BEGIN
	ALTER DATABASE [BmsApartmentDB] SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE [BmsApartmentDB];
END
GO

-- 2. Tạo Database (Bỏ đường dẫn cứng, để SQL Server tự định vị file)
CREATE DATABASE [BmsApartmentDB]
GO

USE [BmsApartmentDB]
GO

-- =============================================
-- 3. TẠO BẢNG (CREATE TABLES)
-- =============================================

CREATE TABLE [dbo].[don_vi_bao_tri](
	[ma_don_vi] [int] IDENTITY(1,1) NOT NULL,
	[ten_don_vi] [nvarchar](150) NOT NULL,
	[nguoi_lien_he] [nvarchar](100) NULL,
	[so_dien_thoai] [varchar](20) NOT NULL,
	[ghi_chu] [nvarchar](500) NULL,
	[trang_thai] [varchar](30) NOT NULL DEFAULT ('HOP_TAC'),
PRIMARY KEY CLUSTERED ([ma_don_vi] ASC)
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[lich_bao_tri](
	[ma_lich] [int] IDENTITY(1,1) NOT NULL,
	[ma_thiet_bi] [int] NOT NULL,
	[ma_don_vi] [int] NULL,
	[chu_ky_ngay] [int] NOT NULL DEFAULT ((30)),
	[ngay_bao_tri_gan_nhat] [datetime] NULL,
	[ngay_bao_tri_tiep_theo] [datetime] NOT NULL,
	[trang_thai] [varchar](30) NOT NULL DEFAULT ('DANG_THEO_DOI'),
PRIMARY KEY CLUSTERED ([ma_lich] ASC)
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[lich_su_bao_tri](
	[ma_lich_su] [int] IDENTITY(1,1) NOT NULL,
	[ma_thiet_bi] [int] NOT NULL,
	[ma_don_vi] [int] NOT NULL,
	[ngay_thuc_hien] [datetime] NOT NULL,
	[chi_phi] [decimal](18, 2) NULL DEFAULT ((0)),
	[mo_ta_cong_viec] [nvarchar](max) NULL,
	[anh_bien_ban] [varchar](500) NULL,
	[ngay_tao] [datetime] NOT NULL DEFAULT (getdate()),
PRIMARY KEY CLUSTERED ([ma_lich_su] ASC)
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[nguoi_dung](
	[ma_nguoi_dung] [int] IDENTITY(1,1) NOT NULL,
	[ten_dang_nhap] [varchar](50) NOT NULL,
	[mat_khau] [varchar](255) NOT NULL,
	[ho_ten] [nvarchar](100) NOT NULL,
	[so_dien_thoai] [varchar](20) NULL,
	[vai_tro] [varchar](30) NOT NULL,
	[trang_thai] [varchar](30) NOT NULL DEFAULT ('HOAT_DONG'),
	[ngay_tao] [datetime] NOT NULL DEFAULT (getdate()),
PRIMARY KEY CLUSTERED ([ma_nguoi_dung] ASC),
UNIQUE NONCLUSTERED ([ten_dang_nhap] ASC)
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[phieu_bao_hong](
	[ma_phieu] [int] IDENTITY(1,1) NOT NULL,
	[tieu_de] [nvarchar](255) NULL,
	[mo_ta_loi] [nvarchar](max) NULL,
	[ma_thiet_bi] [int] NOT NULL,
	[muc_do_uu_tien] [varchar](20) NOT NULL DEFAULT ('TRUNG_BINH'),
	[trang_thai] [varchar](30) NOT NULL DEFAULT ('CHO_PHAN_CONG'),
	[nguoi_tao_id] [int] NULL,
	[nguoi_xu_ly_id] [int] NULL,
	[ghi_chu_ket_qua] [nvarchar](max) NULL,
	[anh_nghiem_thu] [varchar](500) NULL,
	[ngay_tao] [datetime] NOT NULL DEFAULT (getdate()),
	[ngay_hoan_thanh] [datetime] NULL,
PRIMARY KEY CLUSTERED ([ma_phieu] ASC)
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[thiet_bi](
	[ma_thiet_bi] [int] IDENTITY(1,1) NOT NULL,
	[ten_thiet_bi] [nvarchar](255) NULL,
	[loai_thiet_bi] [varchar](50) NOT NULL,
	[vi_tri] [nvarchar](255) NOT NULL,
	[trang_thai] [varchar](30) NOT NULL DEFAULT ('HOAT_DONG'),
	[ngay_tao] [datetime] NOT NULL DEFAULT (getdate()),
PRIMARY KEY CLUSTERED ([ma_thiet_bi] ASC)
) ON [PRIMARY]
GO

-- =============================================
-- 4. CHÈN DỮ LIỆU (INSERT DATA)
-- =============================================

SET IDENTITY_INSERT [dbo].[don_vi_bao_tri] ON 
INSERT [dbo].[don_vi_bao_tri] ([ma_don_vi], [ten_don_vi], [nguoi_lien_he], [so_dien_thoai], [ghi_chu], [trang_thai]) VALUES (1, N'Công ty Thang máy Otis VN', N'Nguyễn Văn A - Kỹ sư trưởng', N'19001111', N'Hợp đồng bảo trì trọn gói 2026', N'HOP_TAC')
INSERT [dbo].[don_vi_bao_tri] ([ma_don_vi], [ten_don_vi], [nguoi_lien_he], [so_dien_thoai], [ghi_chu], [trang_thai]) VALUES (2, N'Điện lực Tân Bình', N'Hotline Sự Cố', N'19002222', N'Liên hệ khi mất điện lưới', N'HOP_TAC')
INSERT [dbo].[don_vi_bao_tri] ([ma_don_vi], [ten_don_vi], [nguoi_lien_he], [so_dien_thoai], [ghi_chu], [trang_thai]) VALUES (4, N'Công ty TNHH Cấp Thoát Nước Sài Gòn', N'hotline', N'18008888', N'Hệ thống nước', N'HOP_TAC')
INSERT [dbo].[don_vi_bao_tri] ([ma_don_vi], [ten_don_vi], [nguoi_lien_he], [so_dien_thoai], [ghi_chu], [trang_thai]) VALUES (5, N'Công ty TNHH Kỹ Thuật Tòa Nhà An Phát', N'hotline', N'18009999', N'bảo trì tổng hợp', N'HOP_TAC')
INSERT [dbo].[don_vi_bao_tri] ([ma_don_vi], [ten_don_vi], [nguoi_lien_he], [so_dien_thoai], [ghi_chu], [trang_thai]) VALUES (6, N'Nội Bộ', N'Nguyên Văn Dũng', N'038812353', N'Trưởng bộ phận kỹ thuật', N'HOP_TAC')
SET IDENTITY_INSERT [dbo].[don_vi_bao_tri] OFF
GO

SET IDENTITY_INSERT [dbo].[thiet_bi] ON 
INSERT [dbo].[thiet_bi] ([ma_thiet_bi], [ten_thiet_bi], [loai_thiet_bi], [vi_tri], [trang_thai], [ngay_tao]) VALUES (1, N'Thang máy Otis 1 tải trọng 1000kg', N'THANG_MAY', N'Block A1', N'HOAT_DONG', CAST(N'2026-05-27T20:34:16.423' AS DateTime))
INSERT [dbo].[thiet_bi] ([ma_thiet_bi], [ten_thiet_bi], [loai_thiet_bi], [vi_tri], [trang_thai], [ngay_tao]) VALUES (2, N'Máy phát Cummins dự phòng 250kVA', N'MAY_PHAT', N'Phòng kỹ thuật tầng hầm', N'HOAT_DONG', CAST(N'2026-05-27T20:34:16.423' AS DateTime))
INSERT [dbo].[thiet_bi] ([ma_thiet_bi], [ten_thiet_bi], [loai_thiet_bi], [vi_tri], [trang_thai], [ngay_tao]) VALUES (3, N'Hệ thống đèn sảnh chính', N'DEN_HANH_LANG', N'Sảnh tầng 1 Block A', N'HOAT_DONG', CAST(N'2026-05-27T20:34:16.423' AS DateTime))
INSERT [dbo].[thiet_bi] ([ma_thiet_bi], [ten_thiet_bi], [loai_thiet_bi], [vi_tri], [trang_thai], [ngay_tao]) VALUES (5, N'bơm cấp nước số 1', N'KHAC', N'Phòng kỹ thuật', N'HOAT_DONG', CAST(N'2026-06-16T22:20:49.643' AS DateTime))
INSERT [dbo].[thiet_bi] ([ma_thiet_bi], [ten_thiet_bi], [loai_thiet_bi], [vi_tri], [trang_thai], [ngay_tao]) VALUES (6, N'Tủ điện tổng', N'KHAC', N'Tầng hầm', N'HOAT_DONG', CAST(N'2026-06-16T22:23:03.980' AS DateTime))
INSERT [dbo].[thiet_bi] ([ma_thiet_bi], [ten_thiet_bi], [loai_thiet_bi], [vi_tri], [trang_thai], [ngay_tao]) VALUES (7, N'Camera CCTV cổng chính', N'KHAC', N'Công ra vào', N'HOAT_DONG', CAST(N'2026-06-16T22:25:51.457' AS DateTime))
INSERT [dbo].[thiet_bi] ([ma_thiet_bi], [ten_thiet_bi], [loai_thiet_bi], [vi_tri], [trang_thai], [ngay_tao]) VALUES (8, N'Đèn hành lang tầng 1', N'DEN_HANH_LANG', N'Tầng 1', N'HOAT_DONG', CAST(N'2026-06-16T22:26:37.140' AS DateTime))
INSERT [dbo].[thiet_bi] ([ma_thiet_bi], [ten_thiet_bi], [loai_thiet_bi], [vi_tri], [trang_thai], [ngay_tao]) VALUES (9, N'Quạt hút khói', N'KHAC', N'tầng hầm', N'HOAT_DONG', CAST(N'2026-06-16T22:27:51.480' AS DateTime))
INSERT [dbo].[thiet_bi] ([ma_thiet_bi], [ten_thiet_bi], [loai_thiet_bi], [vi_tri], [trang_thai], [ngay_tao]) VALUES (10, N'Bơm cấp nước số 2', N'KHAC', N'Phòng kĩ thuật', N'HOAT_DONG', CAST(N'2026-06-16T22:28:47.457' AS DateTime))
INSERT [dbo].[thiet_bi] ([ma_thiet_bi], [ten_thiet_bi], [loai_thiet_bi], [vi_tri], [trang_thai], [ngay_tao]) VALUES (11, N'Thang máy Otis 2 tải trọng 1000kg', N'THANG_MAY', N'Block A', N'HOAT_DONG', CAST(N'2026-06-17T02:23:50.233' AS DateTime))
INSERT [dbo].[thiet_bi] ([ma_thiet_bi], [ten_thiet_bi], [loai_thiet_bi], [vi_tri], [trang_thai], [ngay_tao]) VALUES (12, N'Đèn hành lang tầng 2', N'DEN_HANH_LANG', N'Tầng 2', N'HOAT_DONG', CAST(N'2026-06-17T02:26:15.993' AS DateTime))
INSERT [dbo].[thiet_bi] ([ma_thiet_bi], [ten_thiet_bi], [loai_thiet_bi], [vi_tri], [trang_thai], [ngay_tao]) VALUES (13, N'Hệ thống báo cháy ', N'KHAC', N'Tâng 1', N'HOAT_DONG', CAST(N'2026-06-17T02:31:30.557' AS DateTime))
INSERT [dbo].[thiet_bi] ([ma_thiet_bi], [ten_thiet_bi], [loai_thiet_bi], [vi_tri], [trang_thai], [ngay_tao]) VALUES (14, N'Hệ Thống Báo Cháy', N'KHAC', N'Tầng 2', N'HOAT_DONG', CAST(N'2026-06-17T02:32:00.200' AS DateTime))
INSERT [dbo].[thiet_bi] ([ma_thiet_bi], [ten_thiet_bi], [loai_thiet_bi], [vi_tri], [trang_thai], [ngay_tao]) VALUES (15, N'Camera CCTV hầm xe', N'KHAC', N'B1', N'HOAT_DONG', CAST(N'2026-06-17T02:33:05.093' AS DateTime))
SET IDENTITY_INSERT [dbo].[thiet_bi] OFF
GO

SET IDENTITY_INSERT [dbo].[lich_bao_tri] ON 
INSERT [dbo].[lich_bao_tri] ([ma_lich], [ma_thiet_bi], [ma_don_vi], [chu_ky_ngay], [ngay_bao_tri_gan_nhat], [ngay_bao_tri_tiep_theo], [trang_thai]) VALUES (1, 1, 1, 30, CAST(N'2026-05-18T00:00:00.000' AS DateTime), CAST(N'2026-06-19T00:00:00.000' AS DateTime), N'DANG_THEO_DOI')
INSERT [dbo].[lich_bao_tri] ([ma_lich], [ma_thiet_bi], [ma_don_vi], [chu_ky_ngay], [ngay_bao_tri_gan_nhat], [ngay_bao_tri_tiep_theo], [trang_thai]) VALUES (3, 2, 2, 30, CAST(N'2026-06-17T22:12:00.000' AS DateTime), CAST(N'2026-07-17T22:12:00.000' AS DateTime), N'DANG_THEO_DOI')
INSERT [dbo].[lich_bao_tri] ([ma_lich], [ma_thiet_bi], [ma_don_vi], [chu_ky_ngay], [ngay_bao_tri_gan_nhat], [ngay_bao_tri_tiep_theo], [trang_thai]) VALUES (4, 3, 5, 30, CAST(N'2026-06-16T23:14:00.000' AS DateTime), CAST(N'2026-06-17T22:14:00.000' AS DateTime), N'DANG_THEO_DOI')
INSERT [dbo].[lich_bao_tri] ([ma_lich], [ma_thiet_bi], [ma_don_vi], [chu_ky_ngay], [ngay_bao_tri_gan_nhat], [ngay_bao_tri_tiep_theo], [trang_thai]) VALUES (5, 9, 5, 180, CAST(N'2026-01-01T10:20:00.000' AS DateTime), CAST(N'2026-06-01T10:20:00.000' AS DateTime), N'DANG_THEO_DOI')
INSERT [dbo].[lich_bao_tri] ([ma_lich], [ma_thiet_bi], [ma_don_vi], [chu_ky_ngay], [ngay_bao_tri_gan_nhat], [ngay_bao_tri_tiep_theo], [trang_thai]) VALUES (6, 5, 4, 90, CAST(N'2026-03-30T08:05:00.000' AS DateTime), CAST(N'2026-06-30T08:05:00.000' AS DateTime), N'DANG_THEO_DOI')
INSERT [dbo].[lich_bao_tri] ([ma_lich], [ma_thiet_bi], [ma_don_vi], [chu_ky_ngay], [ngay_bao_tri_gan_nhat], [ngay_bao_tri_tiep_theo], [trang_thai]) VALUES (7, 6, 2, 30, CAST(N'2026-06-15T09:00:00.000' AS DateTime), CAST(N'2026-07-15T09:00:00.000' AS DateTime), N'DANG_THEO_DOI')
INSERT [dbo].[lich_bao_tri] ([ma_lich], [ma_thiet_bi], [ma_don_vi], [chu_ky_ngay], [ngay_bao_tri_gan_nhat], [ngay_bao_tri_tiep_theo], [trang_thai]) VALUES (9, 13, 6, 30, CAST(N'2026-06-18T02:37:00.000' AS DateTime), CAST(N'2026-07-19T02:37:00.000' AS DateTime), N'DANG_THEO_DOI')
SET IDENTITY_INSERT [dbo].[lich_bao_tri] OFF
GO

SET IDENTITY_INSERT [dbo].[nguoi_dung] ON 
INSERT [dbo].[nguoi_dung] ([ma_nguoi_dung], [ten_dang_nhap], [mat_khau], [ho_ten], [so_dien_thoai], [vai_tro], [trang_thai], [ngay_tao]) VALUES (1, N'admin', N'$2a$10$Z0Vz4YzXHLyrtRuaEL7lke1kOxDjlS.WCh0GqxkmEHXuqQNkrEvOS', N'Quản Trị Viên Hệ Thống', N'0901234567', N'ADMIN', N'HOAT_DONG', CAST(N'2026-05-27T20:34:16.417' AS DateTime))
INSERT [dbo].[nguoi_dung] ([ma_nguoi_dung], [ten_dang_nhap], [mat_khau], [ho_ten], [so_dien_thoai], [vai_tro], [trang_thai], [ngay_tao]) VALUES (2, N'kythuat01', N'$2a$10$NElRnLQcIxdPZpNAU/ldi.81Ty/GCP1K9EH7m8QAPt0ny3DWZYtlC', N'Trần Văn Chung', N'0988111222', N'KY_THUAT', N'HOAT_DONG', CAST(N'2026-05-27T20:34:16.417' AS DateTime))
INSERT [dbo].[nguoi_dung] ([ma_nguoi_dung], [ten_dang_nhap], [mat_khau], [ho_ten], [so_dien_thoai], [vai_tro], [trang_thai], [ngay_tao]) VALUES (3, N'kythuat02', N'$2a$10$tUkANlgJn.K05mrFJiZ.beTvyABAe.gjgDSuG8bG.ZHBlY.byArzy', N'Nguyễn Văn Cư', N'098889898', N'KY_THUAT', N'HOAT_DONG', CAST(N'2026-06-15T23:22:24.170' AS DateTime))
INSERT [dbo].[nguoi_dung] ([ma_nguoi_dung], [ten_dang_nhap], [mat_khau], [ho_ten], [so_dien_thoai], [vai_tro], [trang_thai], [ngay_tao]) VALUES (4, N'kythuat03', N'$2a$10$wbCSlCnK0h.S8a6yt5Twg.XalKo/6kTLXXoPIUIsVroPtq9fe/kTi', N'Lê Thị A', N'0991122333', N'KY_THUAT', N'HOAT_DONG', CAST(N'2026-06-16T22:48:14.317' AS DateTime))
INSERT [dbo].[nguoi_dung] ([ma_nguoi_dung], [ten_dang_nhap], [mat_khau], [ho_ten], [so_dien_thoai], [vai_tro], [trang_thai], [ngay_tao]) VALUES (5, N'kythuat04', N'$2a$10$d2Optd4WYSWBsNsnjMkpjeDDIxThJXlruW6ruHWaKRdo8KPw0i5VG', N'Phạm Thi B', N'0944556677', N'KY_THUAT', N'HOAT_DONG', CAST(N'2026-06-16T22:49:54.357' AS DateTime))
INSERT [dbo].[nguoi_dung] ([ma_nguoi_dung], [ten_dang_nhap], [mat_khau], [ho_ten], [so_dien_thoai], [vai_tro], [trang_thai], [ngay_tao]) VALUES (6, N'kythuat05', N'$2a$10$yjCFQVEzw5W3xBRycI8mc.OzBaa/xmlnZCdi5iyG9ltqYaUL.qea6', N'Hoàng Văn C', N'0944556677', N'KY_THUAT', N'HOAT_DONG', CAST(N'2026-06-16T22:51:02.317' AS DateTime))
SET IDENTITY_INSERT [dbo].[nguoi_dung] OFF
GO

SET IDENTITY_INSERT [dbo].[phieu_bao_hong] ON 
INSERT [dbo].[phieu_bao_hong] ([ma_phieu], [tieu_de], [mo_ta_loi], [ma_thiet_bi], [muc_do_uu_tien], [trang_thai], [nguoi_tao_id], [nguoi_xu_ly_id], [ghi_chu_ket_qua], [anh_nghiem_thu], [ngay_tao], [ngay_hoan_thanh]) VALUES (1, N'Cháy đèn', N'Đèn sảnh tầng 1 bị cháy', 3, N'CAO', N'HOAN_THANH', NULL, 2, N'sửa xong', NULL, CAST(N'2026-05-27T20:34:16.450' AS DateTime), CAST(N'2026-06-16T22:18:16.887' AS DateTime))
INSERT [dbo].[phieu_bao_hong] ([ma_phieu], [tieu_de], [mo_ta_loi], [ma_thiet_bi], [muc_do_uu_tien], [trang_thai], [nguoi_tao_id], [nguoi_xu_ly_id], [ghi_chu_ket_qua], [anh_nghiem_thu], [ngay_tao], [ngay_hoan_thanh]) VALUES (2, N'Thang máy tầng 5 lỗi', N'Thang máy dừng bất thường', 1, N'CAO', N'HOAN_THANH', NULL, 2, N'hoan thanh', NULL, CAST(N'2026-06-15T08:54:14.747' AS DateTime), CAST(N'2026-06-16T22:18:01.923' AS DateTime))
INSERT [dbo].[phieu_bao_hong] ([ma_phieu], [tieu_de], [mo_ta_loi], [ma_thiet_bi], [muc_do_uu_tien], [trang_thai], [nguoi_tao_id], [nguoi_xu_ly_id], [ghi_chu_ket_qua], [anh_nghiem_thu], [ngay_tao], [ngay_hoan_thanh]) VALUES (7, N'ống nước hỏng', N'vỡ ống nước', 2, N'TRUNG_BINH', N'DA_PHAN_CONG', NULL, 4, NULL, NULL, CAST(N'2026-06-15T23:27:39.463' AS DateTime), NULL)
INSERT [dbo].[phieu_bao_hong] ([ma_phieu], [tieu_de], [mo_ta_loi], [ma_thiet_bi], [muc_do_uu_tien], [trang_thai], [nguoi_tao_id], [nguoi_xu_ly_id], [ghi_chu_ket_qua], [anh_nghiem_thu], [ngay_tao], [ngay_hoan_thanh]) VALUES (8, N'Hỏng ống nước', N'rò rỉ ống nước', 10, N'CAO', N'DA_PHAN_CONG', NULL, 6, NULL, NULL, CAST(N'2026-06-16T22:54:23.263' AS DateTime), NULL)
INSERT [dbo].[phieu_bao_hong] ([ma_phieu], [tieu_de], [mo_ta_loi], [ma_thiet_bi], [muc_do_uu_tien], [trang_thai], [nguoi_tao_id], [nguoi_xu_ly_id], [ghi_chu_ket_qua], [anh_nghiem_thu], [ngay_tao], [ngay_hoan_thanh]) VALUES (9, N'Camera không hoạt động', N'hỏng camera', 7, N'THAP', N'DA_PHAN_CONG', NULL, 4, NULL, NULL, CAST(N'2026-06-16T22:55:30.643' AS DateTime), NULL)
INSERT [dbo].[phieu_bao_hong] ([ma_phieu], [tieu_de], [mo_ta_loi], [ma_thiet_bi], [muc_do_uu_tien], [trang_thai], [nguoi_tao_id], [nguoi_xu_ly_id], [ghi_chu_ket_qua], [anh_nghiem_thu], [ngay_tao], [ngay_hoan_thanh]) VALUES (10, N'Quạt không hoạt động', N'cháy quạt hút khói', 9, N'THAP', N'DA_PHAN_CONG', NULL, 2, NULL, NULL, CAST(N'2026-06-16T22:57:06.253' AS DateTime), NULL)
INSERT [dbo].[phieu_bao_hong] ([ma_phieu], [tieu_de], [mo_ta_loi], [ma_thiet_bi], [muc_do_uu_tien], [trang_thai], [nguoi_tao_id], [nguoi_xu_ly_id], [ghi_chu_ket_qua], [anh_nghiem_thu], [ngay_tao], [ngay_hoan_thanh]) VALUES (11, N'hỏng bóng đèn', N'cháy bóng đèn ở sảnh chính', 3, N'TRUNG_BINH', N'CHO_PHAN_CONG', NULL, NULL, NULL, NULL, CAST(N'2026-06-16T23:04:25.390' AS DateTime), NULL)
INSERT [dbo].[phieu_bao_hong] ([ma_phieu], [tieu_de], [mo_ta_loi], [ma_thiet_bi], [muc_do_uu_tien], [trang_thai], [nguoi_tao_id], [nguoi_xu_ly_id], [ghi_chu_ket_qua], [anh_nghiem_thu], [ngay_tao], [ngay_hoan_thanh]) VALUES (12, N'hỏng bóng đèn test', N'đèn hành lang sảnh chờ k sáng', 3, N'TRUNG_BINH', N'CHO_PHAN_CONG', NULL, NULL, NULL, NULL, CAST(N'2026-06-16T23:07:36.323' AS DateTime), NULL)
INSERT [dbo].[phieu_bao_hong] ([ma_phieu], [tieu_de], [mo_ta_loi], [ma_thiet_bi], [muc_do_uu_tien], [trang_thai], [nguoi_tao_id], [nguoi_xu_ly_id], [ghi_chu_ket_qua], [anh_nghiem_thu], [ngay_tao], [ngay_hoan_thanh]) VALUES (13, N'vỡ ống nước tầng hầm', N'', 10, N'CAO', N'CHO_PHAN_CONG', NULL, NULL, NULL, NULL, CAST(N'2026-06-16T23:10:16.820' AS DateTime), NULL)
SET IDENTITY_INSERT [dbo].[phieu_bao_hong] OFF
GO

-- =============================================
-- 5. TẠO CHỈ MỤC & KHÓA NGOẠI (INDEXES & FOREIGN KEYS)
-- =============================================

CREATE NONCLUSTERED INDEX [idx_fk_lich_thiet_bi] ON [dbo].[lich_bao_tri] ([ma_thiet_bi] ASC)
GO
CREATE NONCLUSTERED INDEX [idx_lich_ngay_tiep_theo] ON [dbo].[lich_bao_tri] ([ngay_bao_tri_tiep_theo] ASC)
GO
CREATE NONCLUSTERED INDEX [idx_fk_lichsu_don_vi] ON [dbo].[lich_su_bao_tri] ([ma_don_vi] ASC)
GO
CREATE NONCLUSTERED INDEX [idx_fk_lichsu_thiet_bi] ON [dbo].[lich_su_bao_tri] ([ma_thiet_bi] ASC)
GO
CREATE NONCLUSTERED INDEX [idx_fk_phieu_thiet_bi] ON [dbo].[phieu_bao_hong] ([ma_thiet_bi] ASC)
GO
CREATE NONCLUSTERED INDEX [idx_phieu_ky_thuat] ON [dbo].[phieu_bao_hong] ([nguoi_xu_ly_id] ASC)
GO
CREATE NONCLUSTERED INDEX [idx_phieu_trang_thai] ON [dbo].[phieu_bao_hong] ([trang_thai] ASC)
GO

ALTER TABLE [dbo].[lich_bao_tri] WITH CHECK ADD CONSTRAINT [fk_lbt_don_vi] FOREIGN KEY([ma_don_vi]) REFERENCES [dbo].[don_vi_bao_tri] ([ma_don_vi])
GO
ALTER TABLE [dbo].[lich_bao_tri] WITH CHECK ADD CONSTRAINT [fk_lbt_thiet_bi] FOREIGN KEY([ma_thiet_bi]) REFERENCES [dbo].[thiet_bi] ([ma_thiet_bi])
GO
ALTER TABLE [dbo].[lich_su_bao_tri] WITH CHECK ADD CONSTRAINT [fk_ls_don_vi] FOREIGN KEY([ma_don_vi]) REFERENCES [dbo].[don_vi_bao_tri] ([ma_don_vi])
GO
ALTER TABLE [dbo].[lich_su_bao_tri] WITH CHECK ADD CONSTRAINT [fk_ls_thiet_bi] FOREIGN KEY([ma_thiet_bi]) REFERENCES [dbo].[thiet_bi] ([ma_thiet_bi])
GO
ALTER TABLE [dbo].[phieu_bao_hong] WITH CHECK ADD CONSTRAINT [fk_pbh_nguoi_tao] FOREIGN KEY([nguoi_tao_id]) REFERENCES [dbo].[nguoi_dung] ([ma_nguoi_dung])
GO
ALTER TABLE [dbo].[phieu_bao_hong] WITH CHECK ADD CONSTRAINT [fk_pbh_nguoi_xu_ly] FOREIGN KEY([nguoi_xu_ly_id]) REFERENCES [dbo].[nguoi_dung] ([ma_nguoi_dung])
GO
ALTER TABLE [dbo].[phieu_bao_hong] WITH CHECK ADD CONSTRAINT [fk_pbh_thiet_bi] FOREIGN KEY([ma_thiet_bi]) REFERENCES [dbo].[thiet_bi] ([ma_thiet_bi])
GO

-- =============================================
-- 6. TẠO RÀNG BUỘC KIỂM TRA (CHECK CONSTRAINTS)
-- =============================================

ALTER TABLE [dbo].[don_vi_bao_tri] WITH CHECK ADD CONSTRAINT [chk_trang_thai_dv] CHECK (([trang_thai]='NGUNG_HOP_TAC' OR [trang_thai]='HOP_TAC'))
GO
ALTER TABLE [dbo].[lich_bao_tri] WITH CHECK ADD CONSTRAINT [chk_chu_ky] CHECK (([chu_ky_ngay]>(0)))
GO
ALTER TABLE [dbo].[lich_bao_tri] WITH CHECK ADD CONSTRAINT [chk_trang_thai_lbt] CHECK (([trang_thai]='TAM_DUNG' OR [trang_thai]='DANG_THEO_DOI'))
GO
ALTER TABLE [dbo].[lich_su_bao_tri] WITH CHECK ADD CONSTRAINT [chk_chi_phi] CHECK (([chi_phi]>=(0)))
GO
ALTER TABLE [dbo].[nguoi_dung] WITH CHECK ADD CONSTRAINT [chk_trang_thai_nd] CHECK (([trang_thai]='KHOA' OR [trang_thai]='HOAT_DONG'))
GO
ALTER TABLE [dbo].[nguoi_dung] WITH CHECK ADD CONSTRAINT [chk_vai_tro] CHECK (([vai_tro]='LE_TAN' OR [vai_tro]='KY_THUAT' OR [vai_tro]='ADMIN'))
GO
ALTER TABLE [dbo].[phieu_bao_hong] WITH CHECK ADD CONSTRAINT [chk_muc_do] CHECK (([muc_do_uu_tien]='KHAN_CAP' OR [muc_do_uu_tien]='CAO' OR [muc_do_uu_tien]='TRUNG_BINH' OR [muc_do_uu_tien]='THAP'))
GO
ALTER TABLE [dbo].[phieu_bao_hong] WITH CHECK ADD CONSTRAINT [chk_trang_thai_pbh] CHECK (([trang_thai]='HOAN_THANH' OR [trang_thai]='DANG_SUA' OR [trang_thai]='DA_PHAN_CONG' OR [trang_thai]='CHO_PHAN_CONG'))
GO
ALTER TABLE [dbo].[thiet_bi] WITH CHECK ADD CONSTRAINT [chk_loai_tb] CHECK (([loai_thiet_bi]='KHAC' OR [loai_thiet_bi]='DEN_HANH_LANG' OR [loai_thiet_bi]='MAY_PHAT' OR [loai_thiet_bi]='THANG_MAY'))
GO
ALTER TABLE [dbo].[thiet_bi] WITH CHECK ADD CONSTRAINT [chk_trang_thai_tb] CHECK (([trang_thai]='NGUNG_SU_DUNG' OR [trang_thai]='HONG' OR [trang_thai]='DANG_BAO_TRI' OR [trang_thai]='HOAT_DONG'))
GO

PRINT 'Tạo Database và Data thành công!'