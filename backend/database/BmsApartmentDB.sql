{"metadata":{"kernel_spec":{"name":"SQL","language":"sql","display_name":"SQL"},"language_info":{"name":"sql","version":""}},"nbformat":4,"nbformat_minor":2,"cells":[{"cell_type":"markdown","source":["# [BmsApartmentDB]"],"metadata":{"urn":"Server[@Name='admin\\MAY1']/Database[@Name='BmsApartmentDB']","object_type":"Database"}},{"outputs":[],"execution_count":0,"cell_type":"code","source":["USE [master]
","GO
"],"metadata":{"urn":"Server[@Name='admin\\MAY1']/Database[@Name='BmsApartmentDB']","object_type":"Database"}},{"outputs":[],"execution_count":0,"cell_type":"code","source":["/****** Object:  Database [BmsApartmentDB]    Script Date: 27/05/2026 2:03:28 SA ******/
CREATE DATABASE [BmsApartmentDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'BmsApartmentDB', FILENAME = N'C:\\Program Files\\Microsoft SQL Server\\MSSQL16.MAY1\\MSSQL\\DATA\\BmsApartmentDB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'BmsApartmentDB_log', FILENAME = N'C:\\Program Files\\Microsoft SQL Server\\MSSQL16.MAY1\\MSSQL\\DATA\\BmsApartmentDB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
","GO
","ALTER DATABASE [BmsApartmentDB] SET COMPATIBILITY_LEVEL = 160
","GO
","IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [BmsApartmentDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
","GO
","ALTER DATABASE [BmsApartmentDB] SET ANSI_NULL_DEFAULT OFF 
","GO
","ALTER DATABASE [BmsApartmentDB] SET ANSI_NULLS OFF 
","GO
","ALTER DATABASE [BmsApartmentDB] SET ANSI_PADDING OFF 
","GO
","ALTER DATABASE [BmsApartmentDB] SET ANSI_WARNINGS OFF 
","GO
","ALTER DATABASE [BmsApartmentDB] SET ARITHABORT OFF 
","GO
","ALTER DATABASE [BmsApartmentDB] SET AUTO_CLOSE OFF 
","GO
","ALTER DATABASE [BmsApartmentDB] SET AUTO_SHRINK OFF 
","GO
","ALTER DATABASE [BmsApartmentDB] SET AUTO_UPDATE_STATISTICS ON 
","GO
","ALTER DATABASE [BmsApartmentDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
","GO
","ALTER DATABASE [BmsApartmentDB] SET CURSOR_DEFAULT  GLOBAL 
","GO
","ALTER DATABASE [BmsApartmentDB] SET CONCAT_NULL_YIELDS_NULL OFF 
","GO
","ALTER DATABASE [BmsApartmentDB] SET NUMERIC_ROUNDABORT OFF 
","GO
","ALTER DATABASE [BmsApartmentDB] SET QUOTED_IDENTIFIER OFF 
","GO
","ALTER DATABASE [BmsApartmentDB] SET RECURSIVE_TRIGGERS OFF 
","GO
","ALTER DATABASE [BmsApartmentDB] SET  DISABLE_BROKER 
","GO
","ALTER DATABASE [BmsApartmentDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
","GO
","ALTER DATABASE [BmsApartmentDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
","GO
","ALTER DATABASE [BmsApartmentDB] SET TRUSTWORTHY OFF 
","GO
","ALTER DATABASE [BmsApartmentDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
","GO
","ALTER DATABASE [BmsApartmentDB] SET PARAMETERIZATION SIMPLE 
","GO
","ALTER DATABASE [BmsApartmentDB] SET READ_COMMITTED_SNAPSHOT OFF 
","GO
","ALTER DATABASE [BmsApartmentDB] SET HONOR_BROKER_PRIORITY OFF 
","GO
","ALTER DATABASE [BmsApartmentDB] SET RECOVERY FULL 
","GO
","ALTER DATABASE [BmsApartmentDB] SET  MULTI_USER 
","GO
","ALTER DATABASE [BmsApartmentDB] SET PAGE_VERIFY CHECKSUM  
","GO
","ALTER DATABASE [BmsApartmentDB] SET DB_CHAINING OFF 
","GO
","ALTER DATABASE [BmsApartmentDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
","GO
","ALTER DATABASE [BmsApartmentDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
","GO
","ALTER DATABASE [BmsApartmentDB] SET DELAYED_DURABILITY = DISABLED 
","GO
","ALTER DATABASE [BmsApartmentDB] SET ACCELERATED_DATABASE_RECOVERY = OFF  
","GO
","EXEC sys.sp_db_vardecimal_storage_format N'BmsApartmentDB', N'ON'
","GO
","ALTER DATABASE [BmsApartmentDB] SET QUERY_STORE = ON
","GO
","ALTER DATABASE [BmsApartmentDB] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
","GO
"],"metadata":{"urn":"Server[@Name='admin\\MAY1']/Database[@Name='BmsApartmentDB']","object_type":"Database"}},{"cell_type":"markdown","source":["# [dbo].[don_vi_bao_tri]"],"metadata":{"urn":"Server[@Name='admin\\MAY1']/Database[@Name='BmsApartmentDB']/Table[@Name='don_vi_bao_tri' and @Schema='dbo']","object_type":"Table"}},{"outputs":[],"execution_count":0,"cell_type":"code","source":["USE [BmsApartmentDB]
","GO
"],"metadata":{"urn":"Server[@Name='admin\\MAY1']/Database[@Name='BmsApartmentDB']/Table[@Name='don_vi_bao_tri' and @Schema='dbo']","object_type":"Table"}},{"outputs":[],"execution_count":0,"cell_type":"code","source":["/****** Object:  Table [dbo].[don_vi_bao_tri]    Script Date: 27/05/2026 2:03:28 SA ******/
SET ANSI_NULLS ON
","GO
","SET QUOTED_IDENTIFIER ON
","GO
","CREATE TABLE [dbo].[don_vi_bao_tri](
	[ma_don_vi] [int] IDENTITY(1,1) NOT NULL,
	[ten_don_vi] [nvarchar](150) NOT NULL,
	[nguoi_lien_he] [nvarchar](100) NULL,
	[so_dien_thoai] [varchar](20) NOT NULL,
	[ghi_chu] [nvarchar](500) NULL,
	[trang_thai] [varchar](30) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ma_don_vi] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
"],"metadata":{"urn":"Server[@Name='admin\\MAY1']/Database[@Name='BmsApartmentDB']/Table[@Name='don_vi_bao_tri' and @Schema='dbo']","object_type":"Table"}},{"cell_type":"markdown","source":["# [dbo].[lich_bao_tri]"],"metadata":{"urn":"Server[@Name='admin\\MAY1']/Database[@Name='BmsApartmentDB']/Table[@Name='lich_bao_tri' and @Schema='dbo']","object_type":"Table"}},{"outputs":[],"execution_count":0,"cell_type":"code","source":["/****** Object:  Table [dbo].[lich_bao_tri]    Script Date: 27/05/2026 2:03:29 SA ******/
SET ANSI_NULLS ON
","GO
","SET QUOTED_IDENTIFIER ON
","GO
","CREATE TABLE [dbo].[lich_bao_tri](
	[ma_lich] [int] IDENTITY(1,1) NOT NULL,
	[ma_thiet_bi] [int] NOT NULL,
	[ma_don_vi] [int] NULL,
	[chu_ky_ngay] [int] NOT NULL,
	[ngay_bao_tri_gan_nhat] [datetime] NULL,
	[ngay_bao_tri_tiep_theo] [datetime] NOT NULL,
	[trang_thai] [varchar](30) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ma_lich] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
"],"metadata":{"urn":"Server[@Name='admin\\MAY1']/Database[@Name='BmsApartmentDB']/Table[@Name='lich_bao_tri' and @Schema='dbo']","object_type":"Table"}},{"cell_type":"markdown","source":["# [dbo].[lich_su_bao_tri]"],"metadata":{"urn":"Server[@Name='admin\\MAY1']/Database[@Name='BmsApartmentDB']/Table[@Name='lich_su_bao_tri' and @Schema='dbo']","object_type":"Table"}},{"outputs":[],"execution_count":0,"cell_type":"code","source":["/****** Object:  Table [dbo].[lich_su_bao_tri]    Script Date: 27/05/2026 2:03:29 SA ******/
SET ANSI_NULLS ON
","GO
","SET QUOTED_IDENTIFIER ON
","GO
","CREATE TABLE [dbo].[lich_su_bao_tri](
	[ma_lich_su] [int] IDENTITY(1,1) NOT NULL,
	[ma_thiet_bi] [int] NOT NULL,
	[ma_don_vi] [int] NOT NULL,
	[ngay_thuc_hien] [datetime] NOT NULL,
	[chi_phi] [decimal](18, 2) NULL,
	[mo_ta_cong_viec] [nvarchar](max) NULL,
	[anh_bien_ban] [varchar](500) NULL,
	[ngay_tao] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ma_lich_su] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
"],"metadata":{"urn":"Server[@Name='admin\\MAY1']/Database[@Name='BmsApartmentDB']/Table[@Name='lich_su_bao_tri' and @Schema='dbo']","object_type":"Table"}},{"cell_type":"markdown","source":["# [dbo].[nguoi_dung]"],"metadata":{"urn":"Server[@Name='admin\\MAY1']/Database[@Name='BmsApartmentDB']/Table[@Name='nguoi_dung' and @Schema='dbo']","object_type":"Table"}},{"outputs":[],"execution_count":0,"cell_type":"code","source":["/****** Object:  Table [dbo].[nguoi_dung]    Script Date: 27/05/2026 2:03:29 SA ******/
SET ANSI_NULLS ON
","GO
","SET QUOTED_IDENTIFIER ON
","GO
","CREATE TABLE [dbo].[nguoi_dung](
	[ma_nguoi_dung] [int] IDENTITY(1,1) NOT NULL,
	[ten_dang_nhap] [varchar](50) NOT NULL,
	[mat_khau] [varchar](255) NOT NULL,
	[ho_ten] [nvarchar](100) NOT NULL,
	[so_dien_thoai] [varchar](20) NULL,
	[vai_tro] [varchar](30) NOT NULL,
	[trang_thai] [varchar](30) NOT NULL,
	[ngay_tao] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ma_nguoi_dung] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
"],"metadata":{"urn":"Server[@Name='admin\\MAY1']/Database[@Name='BmsApartmentDB']/Table[@Name='nguoi_dung' and @Schema='dbo']","object_type":"Table"}},{"cell_type":"markdown","source":["# [dbo].[phieu_bao_hong]"],"metadata":{"urn":"Server[@Name='admin\\MAY1']/Database[@Name='BmsApartmentDB']/Table[@Name='phieu_bao_hong' and @Schema='dbo']","object_type":"Table"}},{"outputs":[],"execution_count":0,"cell_type":"code","source":["/****** Object:  Table [dbo].[phieu_bao_hong]    Script Date: 27/05/2026 2:03:29 SA ******/
SET ANSI_NULLS ON
","GO
","SET QUOTED_IDENTIFIER ON
","GO
","CREATE TABLE [dbo].[phieu_bao_hong](
	[ma_phieu] [int] IDENTITY(1,1) NOT NULL,
	[tieu_de] [nvarchar](255) NULL,
	[mo_ta_loi] [nvarchar](max) NULL,
	[ma_thiet_bi] [int] NOT NULL,
	[muc_do_uu_tien] [varchar](20) NOT NULL,
	[trang_thai] [varchar](30) NOT NULL,
	[nguoi_tao_id] [int] NULL,
	[nguoi_xu_ly_id] [int] NULL,
	[ghi_chu_ket_qua] [nvarchar](max) NULL,
	[anh_nghiem_thu] [varchar](500) NULL,
	[ngay_tao] [datetime] NOT NULL,
	[ngay_hoan_thanh] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ma_phieu] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
"],"metadata":{"urn":"Server[@Name='admin\\MAY1']/Database[@Name='BmsApartmentDB']/Table[@Name='phieu_bao_hong' and @Schema='dbo']","object_type":"Table"}},{"cell_type":"markdown","source":["# [dbo].[thiet_bi]"],"metadata":{"urn":"Server[@Name='admin\\MAY1']/Database[@Name='BmsApartmentDB']/Table[@Name='thiet_bi' and @Schema='dbo']","object_type":"Table"}},{"outputs":[],"execution_count":0,"cell_type":"code","source":["/****** Object:  Table [dbo].[thiet_bi]    Script Date: 27/05/2026 2:03:29 SA ******/
SET ANSI_NULLS ON
","GO
","SET QUOTED_IDENTIFIER ON
","GO
","CREATE TABLE [dbo].[thiet_bi](
	[ma_thiet_bi] [int] IDENTITY(1,1) NOT NULL,
	[ten_thiet_bi] [nvarchar](255) NULL,
	[loai_thiet_bi] [varchar](50) NOT NULL,
	[vi_tri] [nvarchar](255) NOT NULL,
	[trang_thai] [varchar](30) NOT NULL,
	[ngay_tao] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ma_thiet_bi] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
"],"metadata":{"urn":"Server[@Name='admin\\MAY1']/Database[@Name='BmsApartmentDB']/Table[@Name='thiet_bi' and @Schema='dbo']","object_type":"Table"}},{"cell_type":"markdown","source":["# [dbo].[don_vi_bao_tri]"],"metadata":{"urn":"Server[@Name='admin\\MAY1']/Database[@Name='BmsApartmentDB']/Table[@Name='don_vi_bao_tri' and @Schema='dbo']","object_type":"Table"}},{"outputs":[],"execution_count":0,"cell_type":"code","source":["SET IDENTITY_INSERT [dbo].[don_vi_bao_tri] ON 
","INSERT [dbo].[don_vi_bao_tri] ([ma_don_vi], [ten_don_vi], [nguoi_lien_he], [so_dien_thoai], [ghi_chu], [trang_thai]) VALUES (1, N'Công ty Thang máy Otis VN', N'Nguy?n Van A - K? su tru?ng', N'19001111', N'H?p d?ng b?o trì tr?n gói 2026', N'HOP_TAC')
","INSERT [dbo].[don_vi_bao_tri] ([ma_don_vi], [ten_don_vi], [nguoi_lien_he], [so_dien_thoai], [ghi_chu], [trang_thai]) VALUES (2, N'Ði?n l?c Tân Bình', N'Hotline S? C?', N'19002222', N'Liên h? khi m?t di?n lu?i', N'HOP_TAC')
","SET IDENTITY_INSERT [dbo].[don_vi_bao_tri] OFF
","GO
"],"metadata":{"urn":"Server[@Name='admin\\MAY1']/Database[@Name='BmsApartmentDB']/Table[@Name='don_vi_bao_tri' and @Schema='dbo']","object_type":"Table"}},{"cell_type":"markdown","source":["# [dbo].[lich_bao_tri]"],"metadata":{"urn":"Server[@Name='admin\\MAY1']/Database[@Name='BmsApartmentDB']/Table[@Name='lich_bao_tri' and @Schema='dbo']","object_type":"Table"}},{"outputs":[],"execution_count":0,"cell_type":"code","source":["SET IDENTITY_INSERT [dbo].[lich_bao_tri] ON 
","INSERT [dbo].[lich_bao_tri] ([ma_lich], [ma_thiet_bi], [ma_don_vi], [chu_ky_ngay], [ngay_bao_tri_gan_nhat], [ngay_bao_tri_tiep_theo], [trang_thai]) VALUES (1, 1, 1, 30, CAST(N'2026-05-01T00:00:00.000' AS DateTime), CAST(N'2026-05-31T00:00:00.000' AS DateTime), N'DANG_THEO_DOI')
","INSERT [dbo].[lich_bao_tri] ([ma_lich], [ma_thiet_bi], [ma_don_vi], [chu_ky_ngay], [ngay_bao_tri_gan_nhat], [ngay_bao_tri_tiep_theo], [trang_thai]) VALUES (2, 2, NULL, 90, CAST(N'2026-03-01T00:00:00.000' AS DateTime), CAST(N'2026-05-30T00:00:00.000' AS DateTime), N'DANG_THEO_DOI')
","SET IDENTITY_INSERT [dbo].[lich_bao_tri] OFF
","GO
"],"metadata":{"urn":"Server[@Name='admin\\MAY1']/Database[@Name='BmsApartmentDB']/Table[@Name='lich_bao_tri' and @Schema='dbo']","object_type":"Table"}},{"cell_type":"markdown","source":["# [dbo].[nguoi_dung]"],"metadata":{"urn":"Server[@Name='admin\\MAY1']/Database[@Name='BmsApartmentDB']/Table[@Name='nguoi_dung' and @Schema='dbo']","object_type":"Table"}},{"outputs":[],"execution_count":0,"cell_type":"code","source":["SET IDENTITY_INSERT [dbo].[nguoi_dung] ON 
","INSERT [dbo].[nguoi_dung] ([ma_nguoi_dung], [ten_dang_nhap], [mat_khau], [ho_ten], [so_dien_thoai], [vai_tro], [trang_thai], [ngay_tao]) VALUES (1, N'admin', N'$2a$10$W6S8gb9lXB/ZlxCLezVC.ev.rtmx4HRyjq3A9l2UGgbGn0pr2r9Oq', N'Qu?n Tr? Viên H? Th?ng', N'0901234567', N'ADMIN', N'HOAT_DONG', CAST(N'2026-05-26T19:57:33.567' AS DateTime))
","INSERT [dbo].[nguoi_dung] ([ma_nguoi_dung], [ten_dang_nhap], [mat_khau], [ho_ten], [so_dien_thoai], [vai_tro], [trang_thai], [ngay_tao]) VALUES (2, N'kythuat01', N'$2a$10$k4mDtr54hHijCcvXllBKCOmouwnQmVZaV/WHwKNvuDTwu1DTp4DsS', N'Tr?n Van Chung', N'0988111222', N'KY_THUAT', N'HOAT_DONG', CAST(N'2026-05-26T19:57:33.567' AS DateTime))
","SET IDENTITY_INSERT [dbo].[nguoi_dung] OFF
","GO
"],"metadata":{"urn":"Server[@Name='admin\\MAY1']/Database[@Name='BmsApartmentDB']/Table[@Name='nguoi_dung' and @Schema='dbo']","object_type":"Table"}},{"cell_type":"markdown","source":["# [dbo].[phieu_bao_hong]"],"metadata":{"urn":"Server[@Name='admin\\MAY1']/Database[@Name='BmsApartmentDB']/Table[@Name='phieu_bao_hong' and @Schema='dbo']","object_type":"Table"}},{"outputs":[],"execution_count":0,"cell_type":"code","source":["SET IDENTITY_INSERT [dbo].[phieu_bao_hong] ON 
","INSERT [dbo].[phieu_bao_hong] ([ma_phieu], [tieu_de], [mo_ta_loi], [ma_thiet_bi], [muc_do_uu_tien], [trang_thai], [nguoi_tao_id], [nguoi_xu_ly_id], [ghi_chu_ket_qua], [anh_nghiem_thu], [ngay_tao], [ngay_hoan_thanh]) VALUES (2, N'TestTicket', N'TestDescription', 1, N'CAO', N'CHO_PHAN_CONG', NULL, NULL, NULL, NULL, CAST(N'2026-05-26T21:37:28.563' AS DateTime), NULL)
","INSERT [dbo].[phieu_bao_hong] ([ma_phieu], [tieu_de], [mo_ta_loi], [ma_thiet_bi], [muc_do_uu_tien], [trang_thai], [nguoi_tao_id], [nguoi_xu_ly_id], [ghi_chu_ket_qua], [anh_nghiem_thu], [ngay_tao], [ngay_hoan_thanh]) VALUES (9, N'cháy', N'đèn', 3, N'CAO', N'DANG_SUA', NULL, 2, NULL, NULL, CAST(N'2026-05-27T01:01:30.587' AS DateTime), NULL)
","SET IDENTITY_INSERT [dbo].[phieu_bao_hong] OFF
","GO
"],"metadata":{"urn":"Server[@Name='admin\\MAY1']/Database[@Name='BmsApartmentDB']/Table[@Name='phieu_bao_hong' and @Schema='dbo']","object_type":"Table"}},{"cell_type":"markdown","source":["# [dbo].[thiet_bi]"],"metadata":{"urn":"Server[@Name='admin\\MAY1']/Database[@Name='BmsApartmentDB']/Table[@Name='thiet_bi' and @Schema='dbo']","object_type":"Table"}},{"outputs":[],"execution_count":0,"cell_type":"code","source":["SET IDENTITY_INSERT [dbo].[thiet_bi] ON 
","INSERT [dbo].[thiet_bi] ([ma_thiet_bi], [ten_thiet_bi], [loai_thiet_bi], [vi_tri], [trang_thai], [ngay_tao]) VALUES (1, N'Thang máy Otis Tải trọng 1000kg', N'THANG_MAY', N'Trục kỹ thuật Block A1', N'HOAT_DONG', CAST(N'2026-05-26T19:57:33.570' AS DateTime))
","INSERT [dbo].[thiet_bi] ([ma_thiet_bi], [ten_thiet_bi], [loai_thiet_bi], [vi_tri], [trang_thai], [ngay_tao]) VALUES (2, N'Máy phát Cummins dự phòng 250kVA', N'MAY_PHAT', N'Phòng kỹ thuật tầng hầm', N'HOAT_DONG', CAST(N'2026-05-26T19:57:33.570' AS DateTime))
","INSERT [dbo].[thiet_bi] ([ma_thiet_bi], [ten_thiet_bi], [loai_thiet_bi], [vi_tri], [trang_thai], [ngay_tao]) VALUES (3, N'Hệ thống đèn sảnh chính', N'DEN_HANH_LANG', N'Sảnh tầng 1 Block A', N'HOAT_DONG', CAST(N'2026-05-26T19:57:33.570' AS DateTime))
","SET IDENTITY_INSERT [dbo].[thiet_bi] OFF
","GO
"],"metadata":{"urn":"Server[@Name='admin\\MAY1']/Database[@Name='BmsApartmentDB']/Table[@Name='thiet_bi' and @Schema='dbo']","object_type":"Table"}},{"cell_type":"markdown","source":["# [idx_fk_lich_thiet_bi]"],"metadata":{"urn":"Server[@Name='admin\\MAY1']/Database[@Name='BmsApartmentDB']/Table[@Name='lich_bao_tri' and @Schema='dbo']/Index[@Name='idx_fk_lich_thiet_bi']","object_type":"Index"}},{"outputs":[],"execution_count":0,"cell_type":"code","source":["/****** Object:  Index [idx_fk_lich_thiet_bi]    Script Date: 27/05/2026 2:03:29 SA ******/
CREATE NONCLUSTERED INDEX [idx_fk_lich_thiet_bi] ON [dbo].[lich_bao_tri]
(
	[ma_thiet_bi] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
","GO
"],"metadata":{"urn":"Server[@Name='admin\\MAY1']/Database[@Name='BmsApartmentDB']/Table[@Name='lich_bao_tri' and @Schema='dbo']/Index[@Name='idx_fk_lich_thiet_bi']","object_type":"Index"}},{"cell_type":"markdown","source":["# [idx_lich_ngay_tiep_theo]"],"metadata":{"urn":"Server[@Name='admin\\MAY1']/Database[@Name='BmsApartmentDB']/Table[@Name='lich_bao_tri' and @Schema='dbo']/Index[@Name='idx_lich_ngay_tiep_theo']","object_type":"Index"}},{"outputs":[],"execution_count":0,"cell_type":"code","source":["/****** Object:  Index [idx_lich_ngay_tiep_theo]    Script Date: 27/05/2026 2:03:29 SA ******/
CREATE NONCLUSTERED INDEX [idx_lich_ngay_tiep_theo] ON [dbo].[lich_bao_tri]
(
	[ngay_bao_tri_tiep_theo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
","GO
"],"metadata":{"urn":"Server[@Name='admin\\MAY1']/Database[@Name='BmsApartmentDB']/Table[@Name='lich_bao_tri' and @Schema='dbo']/Index[@Name='idx_lich_ngay_tiep_theo']","object_type":"Index"}},{"cell_type":"markdown","source":["# [idx_fk_lichsu_don_vi]"],"metadata":{"urn":"Server[@Name='admin\\MAY1']/Database[@Name='BmsApartmentDB']/Table[@Name='lich_su_bao_tri' and @Schema='dbo']/Index[@Name='idx_fk_lichsu_don_vi']","object_type":"Index"}},{"outputs":[],"execution_count":0,"cell_type":"code","source":["/****** Object:  Index [idx_fk_lichsu_don_vi]    Script Date: 27/05/2026 2:03:29 SA ******/
CREATE NONCLUSTERED INDEX [idx_fk_lichsu_don_vi] ON [dbo].[lich_su_bao_tri]
(
	[ma_don_vi] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
","GO
"],"metadata":{"urn":"Server[@Name='admin\\MAY1']/Database[@Name='BmsApartmentDB']/Table[@Name='lich_su_bao_tri' and @Schema='dbo']/Index[@Name='idx_fk_lichsu_don_vi']","object_type":"Index"}},{"cell_type":"markdown","source":["# [idx_fk_lichsu_thiet_bi]"],"metadata":{"urn":"Server[@Name='admin\\MAY1']/Database[@Name='BmsApartmentDB']/Table[@Name='lich_su_bao_tri' and @Schema='dbo']/Index[@Name='idx_fk_lichsu_thiet_bi']","object_type":"Index"}},{"outputs":[],"execution_count":0,"cell_type":"code","source":["/****** Object:  Index [idx_fk_lichsu_thiet_bi]    Script Date: 27/05/2026 2:03:29 SA ******/
CREATE NONCLUSTERED INDEX [idx_fk_lichsu_thiet_bi] ON [dbo].[lich_su_bao_tri]
(
	[ma_thiet_bi] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
","GO
"],"metadata":{"urn":"Server[@Name='admin\\MAY1']/Database[@Name='BmsApartmentDB']/Table[@Name='lich_su_bao_tri' and @Schema='dbo']/Index[@Name='idx_fk_lichsu_thiet_bi']","object_type":"Index"}},{"cell_type":"markdown","source":["# [UQ__nguoi_du__363698B326A302DF]"],"metadata":{"urn":"Server[@Name='admin\\MAY1']/Database[@Name='BmsApartmentDB']/Table[@Name='nguoi_dung' and @Schema='dbo']/Index[@Name='UQ__nguoi_du__363698B326A302DF']","object_type":"Index"}},{"outputs":[],"execution_count":0,"cell_type":"code","source":["SET ANSI_PADDING ON
GO
","/****** Object:  Index [UQ__nguoi_du__363698B326A302DF]    Script Date: 27/05/2026 2:03:29 SA ******/
ALTER TABLE [dbo].[nguoi_dung] ADD UNIQUE NONCLUSTERED 
(
	[ten_dang_nhap] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
","GO
"],"metadata":{"urn":"Server[@Name='admin\\MAY1']/Database[@Name='BmsApartmentDB']/Table[@Name='nguoi_dung' and @Schema='dbo']/Index[@Name='UQ__nguoi_du__363698B326A302DF']","object_type":"Index"}},{"cell_type":"markdown","source":["# [idx_fk_phieu_thiet_bi]"],"metadata":{"urn":"Server[@Name='admin\\MAY1']/Database[@Name='BmsApartmentDB']/Table[@Name='phieu_bao_hong' and @Schema='dbo']/Index[@Name='idx_fk_phieu_thiet_bi']","object_type":"Index"}},{"outputs":[],"execution_count":0,"cell_type":"code","source":["/****** Object:  Index [idx_fk_phieu_thiet_bi]    Script Date: 27/05/2026 2:03:29 SA ******/
CREATE NONCLUSTERED INDEX [idx_fk_phieu_thiet_bi] ON [dbo].[phieu_bao_hong]
(
	[ma_thiet_bi] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
","GO
"],"metadata":{"urn":"Server[@Name='admin\\MAY1']/Database[@Name='BmsApartmentDB']/Table[@Name='phieu_bao_hong' and @Schema='dbo']/Index[@Name='idx_fk_phieu_thiet_bi']","object_type":"Index"}},{"cell_type":"markdown","source":["# [idx_phieu_ky_thuat]"],"metadata":{"urn":"Server[@Name='admin\\MAY1']/Database[@Name='BmsApartmentDB']/Table[@Name='phieu_bao_hong' and @Schema='dbo']/Index[@Name='idx_phieu_ky_thuat']","object_type":"Index"}},{"outputs":[],"execution_count":0,"cell_type":"code","source":["/****** Object:  Index [idx_phieu_ky_thuat]    Script Date: 27/05/2026 2:03:29 SA ******/
CREATE NONCLUSTERED INDEX [idx_phieu_ky_thuat] ON [dbo].[phieu_bao_hong]
(
	[nguoi_xu_ly_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
","GO
"],"metadata":{"urn":"Server[@Name='admin\\MAY1']/Database[@Name='BmsApartmentDB']/Table[@Name='phieu_bao_hong' and @Schema='dbo']/Index[@Name='idx_phieu_ky_thuat']","object_type":"Index"}},{"cell_type":"markdown","source":["# [idx_phieu_trang_thai]"],"metadata":{"urn":"Server[@Name='admin\\MAY1']/Database[@Name='BmsApartmentDB']/Table[@Name='phieu_bao_hong' and @Schema='dbo']/Index[@Name='idx_phieu_trang_thai']","object_type":"Index"}},{"outputs":[],"execution_count":0,"cell_type":"code","source":["SET ANSI_PADDING ON
GO
","/****** Object:  Index [idx_phieu_trang_thai]    Script Date: 27/05/2026 2:03:29 SA ******/
CREATE NONCLUSTERED INDEX [idx_phieu_trang_thai] ON [dbo].[phieu_bao_hong]
(
	[trang_thai] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
","GO
"],"metadata":{"urn":"Server[@Name='admin\\MAY1']/Database[@Name='BmsApartmentDB']/Table[@Name='phieu_bao_hong' and @Schema='dbo']/Index[@Name='idx_phieu_trang_thai']","object_type":"Index"}},{"cell_type":"markdown","source":["# [DF__don_vi_ba__trang__440B1D61]"],"metadata":{"urn":"Server[@Name='admin\\MAY1']/Database[@Name='BmsApartmentDB']/Table[@Name='don_vi_bao_tri' and @Schema='dbo']/Column[@Name='trang_thai']/Default[@Name='DF__don_vi_ba__trang__440B1D61']","object_type":"Default"}},{"outputs":[],"execution_count":0,"cell_type":"code","source":["ALTER TABLE [dbo].[don_vi_bao_tri] ADD  DEFAULT ('HOP_TAC') FOR [trang_thai]
","GO
"],"metadata":{"urn":"Server[@Name='admin\\MAY1']/Database[@Name='BmsApartmentDB']/Table[@Name='don_vi_bao_tri' and @Schema='dbo']/Column[@Name='trang_thai']/Default[@Name='DF__don_vi_ba__trang__440B1D61']","object_type":"Default"}},{"cell_type":"markdown","source":["# [DF__lich_bao___chu_k__47DBAE45]"],"metadata":{"urn":"Server[@Name='admin\\MAY1']/Database[@Name='BmsApartmentDB']/Table[@Name='lich_bao_tri' and @Schema='dbo']/Column[@Name='chu_ky_ngay']/Default[@Name='DF__lich_bao___chu_k__47DBAE45']","object_type":"Default"}},{"outputs":[],"execution_count":0,"cell_type":"code","source":["ALTER TABLE [dbo].[lich_bao_tri] ADD  DEFAULT ((30)) FOR [chu_ky_ngay]
","GO
"],"metadata":{"urn":"Server[@Name='admin\\MAY1']/Database[@Name='BmsApartmentDB']/Table[@Name='lich_bao_tri' and @Schema='dbo']/Column[@Name='chu_ky_ngay']/Default[@Name='DF__lich_bao___chu_k__47DBAE45']","object_type":"Default"}},{"cell_type":"markdown","source":["# [DF__lich_bao___trang__48CFD27E]"],"metadata":{"urn":"Server[@Name='admin\\MAY1']/Database[@Name='BmsApartmentDB']/Table[@Name='lich_bao_tri' and @Schema='dbo']/Column[@Name='trang_thai']/Default[@Name='DF__lich_bao___trang__48CFD27E']","object_type":"Default"}},{"outputs":[],"execution_count":0,"cell_type":"code","source":["ALTER TABLE [dbo].[lich_bao_tri] ADD  DEFAULT ('DANG_THEO_DOI') FOR [trang_thai]
","GO
"],"metadata":{"urn":"Server[@Name='admin\\MAY1']/Database[@Name='BmsApartmentDB']/Table[@Name='lich_bao_tri' and @Schema='dbo']/Column[@Name='trang_thai']/Default[@Name='DF__lich_bao___trang__48CFD27E']","object_type":"Default"}},{"cell_type":"markdown","source":["# [DF__lich_su_b__chi_p__4F7CD00D]"],"metadata":{"urn":"Server[@Name='admin\\MAY1']/Database[@Name='BmsApartmentDB']/Table[@Name='lich_su_bao_tri' and @Schema='dbo']/Column[@Name='chi_phi']/Default[@Name='DF__lich_su_b__chi_p__4F7CD00D']","object_type":"Default"}},{"outputs":[],"execution_count":0,"cell_type":"code","source":["ALTER TABLE [dbo].[lich_su_bao_tri] ADD  DEFAULT ((0.00)) FOR [chi_phi]
","GO
"],"metadata":{"urn":"Server[@Name='admin\\MAY1']/Database[@Name='BmsApartmentDB']/Table[@Name='lich_su_bao_tri' and @Schema='dbo']/Column[@Name='chi_phi']/Default[@Name='DF__lich_su_b__chi_p__4F7CD00D']","object_type":"Default"}},{"cell_type":"markdown","source":["# [DF__lich_su_b__ngay___5070F446]"],"metadata":{"urn":"Server[@Name='admin\\MAY1']/Database[@Name='BmsApartmentDB']/Table[@Name='lich_su_bao_tri' and @Schema='dbo']/Column[@Name='ngay_tao']/Default[@Name='DF__lich_su_b__ngay___5070F446']","object_type":"Default"}},{"outputs":[],"execution_count":0,"cell_type":"code","source":["ALTER TABLE [dbo].[lich_su_bao_tri] ADD  DEFAULT (getdate()) FOR [ngay_tao]
","GO
"],"metadata":{"urn":"Server[@Name='admin\\MAY1']/Database[@Name='BmsApartmentDB']/Table[@Name='lich_su_bao_tri' and @Schema='dbo']/Column[@Name='ngay_tao']/Default[@Name='DF__lich_su_b__ngay___5070F446']","object_type":"Default"}},{"cell_type":"markdown","source":["# [DF__nguoi_dun__trang__38996AB5]"],"metadata":{"urn":"Server[@Name='admin\\MAY1']/Database[@Name='BmsApartmentDB']/Table[@Name='nguoi_dung' and @Schema='dbo']/Column[@Name='trang_thai']/Default[@Name='DF__nguoi_dun__trang__38996AB5']","object_type":"Default"}},{"outputs":[],"execution_count":0,"cell_type":"code","source":["ALTER TABLE [dbo].[nguoi_dung] ADD  DEFAULT ('HOAT_DONG') FOR [trang_thai]
","GO
"],"metadata":{"urn":"Server[@Name='admin\\MAY1']/Database[@Name='BmsApartmentDB']/Table[@Name='nguoi_dung' and @Schema='dbo']/Column[@Name='trang_thai']/Default[@Name='DF__nguoi_dun__trang__38996AB5']","object_type":"Default"}},{"cell_type":"markdown","source":["# [DF__nguoi_dun__ngay___398D8EEE]"],"metadata":{"urn":"Server[@Name='admin\\MAY1']/Database[@Name='BmsApartmentDB']/Table[@Name='nguoi_dung' and @Schema='dbo']/Column[@Name='ngay_tao']/Default[@Name='DF__nguoi_dun__ngay___398D8EEE']","object_type":"Default"}},{"outputs":[],"execution_count":0,"cell_type":"code","source":["ALTER TABLE [dbo].[nguoi_dung] ADD  DEFAULT (getdate()) FOR [ngay_tao]
","GO
"],"metadata":{"urn":"Server[@Name='admin\\MAY1']/Database[@Name='BmsApartmentDB']/Table[@Name='nguoi_dung' and @Schema='dbo']/Column[@Name='ngay_tao']/Default[@Name='DF__nguoi_dun__ngay___398D8EEE']","object_type":"Default"}},{"cell_type":"markdown","source":["# [DF__phieu_bao__muc_d__5629CD9C]"],"metadata":{"urn":"Server[@Name='admin\\MAY1']/Database[@Name='BmsApartmentDB']/Table[@Name='phieu_bao_hong' and @Schema='dbo']/Column[@Name='muc_do_uu_tien']/Default[@Name='DF__phieu_bao__muc_d__5629CD9C']","object_type":"Default"}},{"outputs":[],"execution_count":0,"cell_type":"code","source":["ALTER TABLE [dbo].[phieu_bao_hong] ADD  DEFAULT ('TRUNG_BINH') FOR [muc_do_uu_tien]
","GO
"],"metadata":{"urn":"Server[@Name='admin\\MAY1']/Database[@Name='BmsApartmentDB']/Table[@Name='phieu_bao_hong' and @Schema='dbo']/Column[@Name='muc_do_uu_tien']/Default[@Name='DF__phieu_bao__muc_d__5629CD9C']","object_type":"Default"}},{"cell_type":"markdown","source":["# [DF__phieu_bao__trang__571DF1D5]"],"metadata":{"urn":"Server[@Name='admin\\MAY1']/Database[@Name='BmsApartmentDB']/Table[@Name='phieu_bao_hong' and @Schema='dbo']/Column[@Name='trang_thai']/Default[@Name='DF__phieu_bao__trang__571DF1D5']","object_type":"Default"}},{"outputs":[],"execution_count":0,"cell_type":"code","source":["ALTER TABLE [dbo].[phieu_bao_hong] ADD  DEFAULT ('CHO_PHAN_CONG') FOR [trang_thai]
","GO
"],"metadata":{"urn":"Server[@Name='admin\\MAY1']/Database[@Name='BmsApartmentDB']/Table[@Name='phieu_bao_hong' and @Schema='dbo']/Column[@Name='trang_thai']/Default[@Name='DF__phieu_bao__trang__571DF1D5']","object_type":"Default"}},{"cell_type":"markdown","source":["# [DF__phieu_bao__ngay___5812160E]"],"metadata":{"urn":"Server[@Name='admin\\MAY1']/Database[@Name='BmsApartmentDB']/Table[@Name='phieu_bao_hong' and @Schema='dbo']/Column[@Name='ngay_tao']/Default[@Name='DF__phieu_bao__ngay___5812160E']","object_type":"Default"}},{"outputs":[],"execution_count":0,"cell_type":"code","source":["ALTER TABLE [dbo].[phieu_bao_hong] ADD  DEFAULT (getdate()) FOR [ngay_tao]
","GO
"],"metadata":{"urn":"Server[@Name='admin\\MAY1']/Database[@Name='BmsApartmentDB']/Table[@Name='phieu_bao_hong' and @Schema='dbo']/Column[@Name='ngay_tao']/Default[@Name='DF__phieu_bao__ngay___5812160E']","object_type":"Default"}},{"cell_type":"markdown","source":["# [DF__thiet_bi__trang___3E52440B]"],"metadata":{"urn":"Server[@Name='admin\\MAY1']/Database[@Name='BmsApartmentDB']/Table[@Name='thiet_bi' and @Schema='dbo']/Column[@Name='trang_thai']/Default[@Name='DF__thiet_bi__trang___3E52440B']","object_type":"Default"}},{"outputs":[],"execution_count":0,"cell_type":"code","source":["ALTER TABLE [dbo].[thiet_bi] ADD  DEFAULT ('HOAT_DONG') FOR [trang_thai]
","GO
"],"metadata":{"urn":"Server[@Name='admin\\MAY1']/Database[@Name='BmsApartmentDB']/Table[@Name='thiet_bi' and @Schema='dbo']/Column[@Name='trang_thai']/Default[@Name='DF__thiet_bi__trang___3E52440B']","object_type":"Default"}},{"cell_type":"markdown","source":["# [DF__thiet_bi__ngay_t__3F466844]"],"metadata":{"urn":"Server[@Name='admin\\MAY1']/Database[@Name='BmsApartmentDB']/Table[@Name='thiet_bi' and @Schema='dbo']/Column[@Name='ngay_tao']/Default[@Name='DF__thiet_bi__ngay_t__3F466844']","object_type":"Default"}},{"outputs":[],"execution_count":0,"cell_type":"code","source":["ALTER TABLE [dbo].[thiet_bi] ADD  DEFAULT (getdate()) FOR [ngay_tao]
","GO
"],"metadata":{"urn":"Server[@Name='admin\\MAY1']/Database[@Name='BmsApartmentDB']/Table[@Name='thiet_bi' and @Schema='dbo']/Column[@Name='ngay_tao']/Default[@Name='DF__thiet_bi__ngay_t__3F466844']","object_type":"Default"}},{"cell_type":"markdown","source":["# [fk_lbt_don_vi]"],"metadata":{"urn":"Server[@Name='admin\\MAY1']/Database[@Name='BmsApartmentDB']/Table[@Name='lich_bao_tri' and @Schema='dbo']/ForeignKey[@Name='fk_lbt_don_vi']","object_type":"ForeignKey"}},{"outputs":[],"execution_count":0,"cell_type":"code","source":["ALTER TABLE [dbo].[lich_bao_tri]  WITH CHECK ADD  CONSTRAINT [fk_lbt_don_vi] FOREIGN KEY([ma_don_vi])
REFERENCES [dbo].[don_vi_bao_tri] ([ma_don_vi])
","GO
","ALTER TABLE [dbo].[lich_bao_tri] CHECK CONSTRAINT [fk_lbt_don_vi]
","GO
"],"metadata":{"urn":"Server[@Name='admin\\MAY1']/Database[@Name='BmsApartmentDB']/Table[@Name='lich_bao_tri' and @Schema='dbo']/ForeignKey[@Name='fk_lbt_don_vi']","object_type":"ForeignKey"}},{"cell_type":"markdown","source":["# [fk_lbt_thiet_bi]"],"metadata":{"urn":"Server[@Name='admin\\MAY1']/Database[@Name='BmsApartmentDB']/Table[@Name='lich_bao_tri' and @Schema='dbo']/ForeignKey[@Name='fk_lbt_thiet_bi']","object_type":"ForeignKey"}},{"outputs":[],"execution_count":0,"cell_type":"code","source":["ALTER TABLE [dbo].[lich_bao_tri]  WITH CHECK ADD  CONSTRAINT [fk_lbt_thiet_bi] FOREIGN KEY([ma_thiet_bi])
REFERENCES [dbo].[thiet_bi] ([ma_thiet_bi])
","GO
","ALTER TABLE [dbo].[lich_bao_tri] CHECK CONSTRAINT [fk_lbt_thiet_bi]
","GO
"],"metadata":{"urn":"Server[@Name='admin\\MAY1']/Database[@Name='BmsApartmentDB']/Table[@Name='lich_bao_tri' and @Schema='dbo']/ForeignKey[@Name='fk_lbt_thiet_bi']","object_type":"ForeignKey"}},{"cell_type":"markdown","source":["# [fk_ls_don_vi]"],"metadata":{"urn":"Server[@Name='admin\\MAY1']/Database[@Name='BmsApartmentDB']/Table[@Name='lich_su_bao_tri' and @Schema='dbo']/ForeignKey[@Name='fk_ls_don_vi']","object_type":"ForeignKey"}},{"outputs":[],"execution_count":0,"cell_type":"code","source":["ALTER TABLE [dbo].[lich_su_bao_tri]  WITH CHECK ADD  CONSTRAINT [fk_ls_don_vi] FOREIGN KEY([ma_don_vi])
REFERENCES [dbo].[don_vi_bao_tri] ([ma_don_vi])
","GO
","ALTER TABLE [dbo].[lich_su_bao_tri] CHECK CONSTRAINT [fk_ls_don_vi]
","GO
"],"metadata":{"urn":"Server[@Name='admin\\MAY1']/Database[@Name='BmsApartmentDB']/Table[@Name='lich_su_bao_tri' and @Schema='dbo']/ForeignKey[@Name='fk_ls_don_vi']","object_type":"ForeignKey"}},{"cell_type":"markdown","source":["# [fk_ls_thiet_bi]"],"metadata":{"urn":"Server[@Name='admin\\MAY1']/Database[@Name='BmsApartmentDB']/Table[@Name='lich_su_bao_tri' and @Schema='dbo']/ForeignKey[@Name='fk_ls_thiet_bi']","object_type":"ForeignKey"}},{"outputs":[],"execution_count":0,"cell_type":"code","source":["ALTER TABLE [dbo].[lich_su_bao_tri]  WITH CHECK ADD  CONSTRAINT [fk_ls_thiet_bi] FOREIGN KEY([ma_thiet_bi])
REFERENCES [dbo].[thiet_bi] ([ma_thiet_bi])
","GO
","ALTER TABLE [dbo].[lich_su_bao_tri] CHECK CONSTRAINT [fk_ls_thiet_bi]
","GO
"],"metadata":{"urn":"Server[@Name='admin\\MAY1']/Database[@Name='BmsApartmentDB']/Table[@Name='lich_su_bao_tri' and @Schema='dbo']/ForeignKey[@Name='fk_ls_thiet_bi']","object_type":"ForeignKey"}},{"cell_type":"markdown","source":["# [fk_pbh_nguoi_tao]"],"metadata":{"urn":"Server[@Name='admin\\MAY1']/Database[@Name='BmsApartmentDB']/Table[@Name='phieu_bao_hong' and @Schema='dbo']/ForeignKey[@Name='fk_pbh_nguoi_tao']","object_type":"ForeignKey"}},{"outputs":[],"execution_count":0,"cell_type":"code","source":["ALTER TABLE [dbo].[phieu_bao_hong]  WITH CHECK ADD  CONSTRAINT [fk_pbh_nguoi_tao] FOREIGN KEY([nguoi_tao_id])
REFERENCES [dbo].[nguoi_dung] ([ma_nguoi_dung])
","GO
","ALTER TABLE [dbo].[phieu_bao_hong] CHECK CONSTRAINT [fk_pbh_nguoi_tao]
","GO
"],"metadata":{"urn":"Server[@Name='admin\\MAY1']/Database[@Name='BmsApartmentDB']/Table[@Name='phieu_bao_hong' and @Schema='dbo']/ForeignKey[@Name='fk_pbh_nguoi_tao']","object_type":"ForeignKey"}},{"cell_type":"markdown","source":["# [fk_pbh_nguoi_xu_ly]"],"metadata":{"urn":"Server[@Name='admin\\MAY1']/Database[@Name='BmsApartmentDB']/Table[@Name='phieu_bao_hong' and @Schema='dbo']/ForeignKey[@Name='fk_pbh_nguoi_xu_ly']","object_type":"ForeignKey"}},{"outputs":[],"execution_count":0,"cell_type":"code","source":["ALTER TABLE [dbo].[phieu_bao_hong]  WITH CHECK ADD  CONSTRAINT [fk_pbh_nguoi_xu_ly] FOREIGN KEY([nguoi_xu_ly_id])
REFERENCES [dbo].[nguoi_dung] ([ma_nguoi_dung])
","GO
","ALTER TABLE [dbo].[phieu_bao_hong] CHECK CONSTRAINT [fk_pbh_nguoi_xu_ly]
","GO
"],"metadata":{"urn":"Server[@Name='admin\\MAY1']/Database[@Name='BmsApartmentDB']/Table[@Name='phieu_bao_hong' and @Schema='dbo']/ForeignKey[@Name='fk_pbh_nguoi_xu_ly']","object_type":"ForeignKey"}},{"cell_type":"markdown","source":["# [fk_pbh_thiet_bi]"],"metadata":{"urn":"Server[@Name='admin\\MAY1']/Database[@Name='BmsApartmentDB']/Table[@Name='phieu_bao_hong' and @Schema='dbo']/ForeignKey[@Name='fk_pbh_thiet_bi']","object_type":"ForeignKey"}},{"outputs":[],"execution_count":0,"cell_type":"code","source":["ALTER TABLE [dbo].[phieu_bao_hong]  WITH CHECK ADD  CONSTRAINT [fk_pbh_thiet_bi] FOREIGN KEY([ma_thiet_bi])
REFERENCES [dbo].[thiet_bi] ([ma_thiet_bi])
","GO
","ALTER TABLE [dbo].[phieu_bao_hong] CHECK CONSTRAINT [fk_pbh_thiet_bi]
","GO
"],"metadata":{"urn":"Server[@Name='admin\\MAY1']/Database[@Name='BmsApartmentDB']/Table[@Name='phieu_bao_hong' and @Schema='dbo']/ForeignKey[@Name='fk_pbh_thiet_bi']","object_type":"ForeignKey"}},{"cell_type":"markdown","source":["# [chk_trang_thai_dv]"],"metadata":{"urn":"Server[@Name='admin\\MAY1']/Database[@Name='BmsApartmentDB']/Table[@Name='don_vi_bao_tri' and @Schema='dbo']/Check[@Name='chk_trang_thai_dv']","object_type":"Check"}},{"outputs":[],"execution_count":0,"cell_type":"code","source":["ALTER TABLE [dbo].[don_vi_bao_tri]  WITH CHECK ADD  CONSTRAINT [chk_trang_thai_dv] CHECK  (([trang_thai]='NGUNG_HOP_TAC' OR [trang_thai]='HOP_TAC'))
","GO
","ALTER TABLE [dbo].[don_vi_bao_tri] CHECK CONSTRAINT [chk_trang_thai_dv]
","GO
"],"metadata":{"urn":"Server[@Name='admin\\MAY1']/Database[@Name='BmsApartmentDB']/Table[@Name='don_vi_bao_tri' and @Schema='dbo']/Check[@Name='chk_trang_thai_dv']","object_type":"Check"}},{"cell_type":"markdown","source":["# [chk_chu_ky]"],"metadata":{"urn":"Server[@Name='admin\\MAY1']/Database[@Name='BmsApartmentDB']/Table[@Name='lich_bao_tri' and @Schema='dbo']/Check[@Name='chk_chu_ky']","object_type":"Check"}},{"outputs":[],"execution_count":0,"cell_type":"code","source":["ALTER TABLE [dbo].[lich_bao_tri]  WITH CHECK ADD  CONSTRAINT [chk_chu_ky] CHECK  (([chu_ky_ngay]>(0)))
","GO
","ALTER TABLE [dbo].[lich_bao_tri] CHECK CONSTRAINT [chk_chu_ky]
","GO
"],"metadata":{"urn":"Server[@Name='admin\\MAY1']/Database[@Name='BmsApartmentDB']/Table[@Name='lich_bao_tri' and @Schema='dbo']/Check[@Name='chk_chu_ky']","object_type":"Check"}},{"cell_type":"markdown","source":["# [chk_trang_thai_lbt]"],"metadata":{"urn":"Server[@Name='admin\\MAY1']/Database[@Name='BmsApartmentDB']/Table[@Name='lich_bao_tri' and @Schema='dbo']/Check[@Name='chk_trang_thai_lbt']","object_type":"Check"}},{"outputs":[],"execution_count":0,"cell_type":"code","source":["ALTER TABLE [dbo].[lich_bao_tri]  WITH CHECK ADD  CONSTRAINT [chk_trang_thai_lbt] CHECK  (([trang_thai]='TAM_DUNG' OR [trang_thai]='DANG_THEO_DOI'))
","GO
","ALTER TABLE [dbo].[lich_bao_tri] CHECK CONSTRAINT [chk_trang_thai_lbt]
","GO
"],"metadata":{"urn":"Server[@Name='admin\\MAY1']/Database[@Name='BmsApartmentDB']/Table[@Name='lich_bao_tri' and @Schema='dbo']/Check[@Name='chk_trang_thai_lbt']","object_type":"Check"}},{"cell_type":"markdown","source":["# [chk_chi_phi]"],"metadata":{"urn":"Server[@Name='admin\\MAY1']/Database[@Name='BmsApartmentDB']/Table[@Name='lich_su_bao_tri' and @Schema='dbo']/Check[@Name='chk_chi_phi']","object_type":"Check"}},{"outputs":[],"execution_count":0,"cell_type":"code","source":["ALTER TABLE [dbo].[lich_su_bao_tri]  WITH CHECK ADD  CONSTRAINT [chk_chi_phi] CHECK  (([chi_phi]>=(0)))
","GO
","ALTER TABLE [dbo].[lich_su_bao_tri] CHECK CONSTRAINT [chk_chi_phi]
","GO
"],"metadata":{"urn":"Server[@Name='admin\\MAY1']/Database[@Name='BmsApartmentDB']/Table[@Name='lich_su_bao_tri' and @Schema='dbo']/Check[@Name='chk_chi_phi']","object_type":"Check"}},{"cell_type":"markdown","source":["# [chk_trang_thai_nd]"],"metadata":{"urn":"Server[@Name='admin\\MAY1']/Database[@Name='BmsApartmentDB']/Table[@Name='nguoi_dung' and @Schema='dbo']/Check[@Name='chk_trang_thai_nd']","object_type":"Check"}},{"outputs":[],"execution_count":0,"cell_type":"code","source":["ALTER TABLE [dbo].[nguoi_dung]  WITH CHECK ADD  CONSTRAINT [chk_trang_thai_nd] CHECK  (([trang_thai]='KHOA' OR [trang_thai]='HOAT_DONG'))
","GO
","ALTER TABLE [dbo].[nguoi_dung] CHECK CONSTRAINT [chk_trang_thai_nd]
","GO
"],"metadata":{"urn":"Server[@Name='admin\\MAY1']/Database[@Name='BmsApartmentDB']/Table[@Name='nguoi_dung' and @Schema='dbo']/Check[@Name='chk_trang_thai_nd']","object_type":"Check"}},{"cell_type":"markdown","source":["# [chk_vai_tro]"],"metadata":{"urn":"Server[@Name='admin\\MAY1']/Database[@Name='BmsApartmentDB']/Table[@Name='nguoi_dung' and @Schema='dbo']/Check[@Name='chk_vai_tro']","object_type":"Check"}},{"outputs":[],"execution_count":0,"cell_type":"code","source":["ALTER TABLE [dbo].[nguoi_dung]  WITH CHECK ADD  CONSTRAINT [chk_vai_tro] CHECK  (([vai_tro]='LE_TAN' OR [vai_tro]='KY_THUAT' OR [vai_tro]='ADMIN'))
","GO
","ALTER TABLE [dbo].[nguoi_dung] CHECK CONSTRAINT [chk_vai_tro]
","GO
"],"metadata":{"urn":"Server[@Name='admin\\MAY1']/Database[@Name='BmsApartmentDB']/Table[@Name='nguoi_dung' and @Schema='dbo']/Check[@Name='chk_vai_tro']","object_type":"Check"}},{"cell_type":"markdown","source":["# [chk_muc_do]"],"metadata":{"urn":"Server[@Name='admin\\MAY1']/Database[@Name='BmsApartmentDB']/Table[@Name='phieu_bao_hong' and @Schema='dbo']/Check[@Name='chk_muc_do']","object_type":"Check"}},{"outputs":[],"execution_count":0,"cell_type":"code","source":["ALTER TABLE [dbo].[phieu_bao_hong]  WITH CHECK ADD  CONSTRAINT [chk_muc_do] CHECK  (([muc_do_uu_tien]='KHAN_CAP' OR [muc_do_uu_tien]='CAO' OR [muc_do_uu_tien]='TRUNG_BINH' OR [muc_do_uu_tien]='THAP'))
","GO
","ALTER TABLE [dbo].[phieu_bao_hong] CHECK CONSTRAINT [chk_muc_do]
","GO
"],"metadata":{"urn":"Server[@Name='admin\\MAY1']/Database[@Name='BmsApartmentDB']/Table[@Name='phieu_bao_hong' and @Schema='dbo']/Check[@Name='chk_muc_do']","object_type":"Check"}},{"cell_type":"markdown","source":["# [chk_trang_thai_pbh]"],"metadata":{"urn":"Server[@Name='admin\\MAY1']/Database[@Name='BmsApartmentDB']/Table[@Name='phieu_bao_hong' and @Schema='dbo']/Check[@Name='chk_trang_thai_pbh']","object_type":"Check"}},{"outputs":[],"execution_count":0,"cell_type":"code","source":["ALTER TABLE [dbo].[phieu_bao_hong]  WITH CHECK ADD  CONSTRAINT [chk_trang_thai_pbh] CHECK  (([trang_thai]='HOAN_THANH' OR [trang_thai]='DANG_SUA' OR [trang_thai]='DA_PHAN_CONG' OR [trang_thai]='CHO_PHAN_CONG'))
","GO
","ALTER TABLE [dbo].[phieu_bao_hong] CHECK CONSTRAINT [chk_trang_thai_pbh]
","GO
"],"metadata":{"urn":"Server[@Name='admin\\MAY1']/Database[@Name='BmsApartmentDB']/Table[@Name='phieu_bao_hong' and @Schema='dbo']/Check[@Name='chk_trang_thai_pbh']","object_type":"Check"}},{"cell_type":"markdown","source":["# [chk_loai_tb]"],"metadata":{"urn":"Server[@Name='admin\\MAY1']/Database[@Name='BmsApartmentDB']/Table[@Name='thiet_bi' and @Schema='dbo']/Check[@Name='chk_loai_tb']","object_type":"Check"}},{"outputs":[],"execution_count":0,"cell_type":"code","source":["ALTER TABLE [dbo].[thiet_bi]  WITH CHECK ADD  CONSTRAINT [chk_loai_tb] CHECK  (([loai_thiet_bi]='KHAC' OR [loai_thiet_bi]='DEN_HANH_LANG' OR [loai_thiet_bi]='MAY_PHAT' OR [loai_thiet_bi]='THANG_MAY'))
","GO
","ALTER TABLE [dbo].[thiet_bi] CHECK CONSTRAINT [chk_loai_tb]
","GO
"],"metadata":{"urn":"Server[@Name='admin\\MAY1']/Database[@Name='BmsApartmentDB']/Table[@Name='thiet_bi' and @Schema='dbo']/Check[@Name='chk_loai_tb']","object_type":"Check"}},{"cell_type":"markdown","source":["# [chk_trang_thai_tb]"],"metadata":{"urn":"Server[@Name='admin\\MAY1']/Database[@Name='BmsApartmentDB']/Table[@Name='thiet_bi' and @Schema='dbo']/Check[@Name='chk_trang_thai_tb']","object_type":"Check"}},{"outputs":[],"execution_count":0,"cell_type":"code","source":["ALTER TABLE [dbo].[thiet_bi]  WITH CHECK ADD  CONSTRAINT [chk_trang_thai_tb] CHECK  (([trang_thai]='NGUNG_SU_DUNG' OR [trang_thai]='HONG' OR [trang_thai]='DANG_BAO_TRI' OR [trang_thai]='HOAT_DONG'))
","GO
","ALTER TABLE [dbo].[thiet_bi] CHECK CONSTRAINT [chk_trang_thai_tb]
","GO
"],"metadata":{"urn":"Server[@Name='admin\\MAY1']/Database[@Name='BmsApartmentDB']/Table[@Name='thiet_bi' and @Schema='dbo']/Check[@Name='chk_trang_thai_tb']","object_type":"Check"}},{"cell_type":"markdown","source":["# [BmsApartmentDB]"],"metadata":{"urn":"Server[@Name='admin\\MAY1']/Database[@Name='BmsApartmentDB']","object_type":"Database"}},{"outputs":[],"execution_count":0,"cell_type":"code","source":["USE [master]
","GO
"],"metadata":{"urn":"Server[@Name='admin\\MAY1']/Database[@Name='BmsApartmentDB']","object_type":"Database"}},{"outputs":[],"execution_count":0,"cell_type":"code","source":["ALTER DATABASE [BmsApartmentDB] SET  READ_WRITE 
","GO
"],"metadata":{"urn":"Server[@Name='admin\\MAY1']/Database[@Name='BmsApartmentDB']","object_type":"Database"}}]}