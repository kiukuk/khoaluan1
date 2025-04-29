-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th4 27, 2025 lúc 05:58 PM
-- Phiên bản máy phục vụ: 8.0.42
-- Phiên bản PHP: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `db_123`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `accountrequest`
--

CREATE TABLE `accountrequest` (
  `request_id` int NOT NULL,
  `user_id` int DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `accountrequest`
--

INSERT INTO `accountrequest` (`request_id`, `user_id`, `type`, `status`, `created_at`, `updated_at`) VALUES
(1, 1, 'Tạo mới', 'approved', '2025-04-25 10:47:34', '2025-04-26 19:54:21'),
(2, 2, 'Cấp lại mật khẩu', 'Hoàn thành', '2025-04-25 10:47:34', '2025-04-26 16:30:34'),
(3, 3, 'Khóa tài khoản', 'Hoàn thành', '2025-04-25 10:47:34', '2025-04-26 16:30:06'),
(4, 4, 'Tạo mới', 'approved', '2025-04-25 10:47:34', '2025-04-26 20:48:35'),
(5, 5, 'Cập nhật email', 'chờ duyệt', '2025-04-25 10:47:34', '2025-04-26 16:30:17');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `activity`
--

CREATE TABLE `activity` (
  `activity_id` int NOT NULL,
  `customer_data_id` int DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `description` text,
  `status` varchar(50) DEFAULT NULL,
  `due_date` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `activity`
--

INSERT INTO `activity` (`activity_id`, `customer_data_id`, `user_id`, `type`, `title`, `description`, `status`, `due_date`, `created_at`, `updated_at`) VALUES
(6, 1, 2, 'Gọi điện', 'Gọi xác nhận hợp đồng', 'Gọi cho khách để xác nhận thông tin ký hợp đồng.', 'pending', '2024-05-01 03:00:00', '2025-04-26 20:12:51', '2025-04-26 20:12:51'),
(7, 2, 3, 'Họp', 'Họp báo giá với khách', 'Chuẩn bị buổi họp báo giá với khách hàng tiềm năng.', 'pending', '2024-05-02 07:00:00', '2025-04-26 20:12:51', '2025-04-26 20:12:51'),
(8, 3, 4, 'Gửi email', 'Gửi bảng báo giá', 'Gửi bảng báo giá chi tiết cho khách.', 'completed', '2024-04-30 02:00:00', '2025-04-26 20:12:51', '2025-04-26 20:12:51'),
(9, 4, 5, 'Theo dõi', 'Theo dõi tiến độ ký hợp đồng', 'Theo dõi và nhắc khách hoàn tất ký hợp đồng.', 'in_progress', '2024-05-03 09:00:00', '2025-04-26 20:12:51', '2025-04-26 20:12:51');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `contract`
--

CREATE TABLE `contract` (
  `contract_id` int NOT NULL,
  `contract_code` varchar(50) NOT NULL,
  `customer_code` varchar(50) DEFAULT NULL,
  `customer_name` varchar(255) DEFAULT NULL,
  `customer_id` int DEFAULT NULL,
  `tax_code` varchar(50) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `value` decimal(15,2) DEFAULT NULL,
  `staff_id` int DEFAULT NULL,
  `staff_in_charge_name` varchar(255) DEFAULT NULL,
  `signing_date` date DEFAULT NULL,
  `source` varchar(100) DEFAULT NULL,
  `region` varchar(100) DEFAULT NULL,
  `status` enum('Chưa gửi','Chưa thanh toán','Đã TT một phần','Quá hạn','Đã thanh toán') DEFAULT 'Chưa gửi',
  `company_name` varchar(255) DEFAULT NULL,
  `service_product` varchar(255) DEFAULT NULL,
  `note` text,
  `detail_description` text,
  `attachment` text,
  `total_value` decimal(15,2) DEFAULT '0.00',
  `amount_paid` decimal(15,2) DEFAULT '0.00',
  `amount_due` decimal(15,2) DEFAULT '0.00',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `contract`
--

INSERT INTO `contract` (`contract_id`, `contract_code`, `customer_code`, `customer_name`, `customer_id`, `tax_code`, `start_date`, `end_date`, `value`, `staff_id`, `staff_in_charge_name`, `signing_date`, `source`, `region`, `status`, `company_name`, `service_product`, `note`, `detail_description`, `attachment`, `total_value`, `amount_paid`, `amount_due`, `created_at`, `updated_at`) VALUES
(11, '00000001', '00000001', 'Nguyễn Văn A', 1, '0101234567', '2024-01-01', '2024-12-31', 10000000000.00, 2, 'Trần Thị B', '2024-01-02', 'Trực tiếp', 'Hà Nội', 'Đã thanh toán', 'Công ty ABC', 'Internet doanh nghiệp', 'Không có ghi chú', 'Cung cấp đường truyền tốc độ cao', NULL, 100000000.00, 100000000.00, 0.00, '2025-04-25 12:46:59', '2025-04-26 08:46:41'),
(12, '00000002', '00000002', 'Lê Thị B', 2, '0207654321', '2024-02-01', '2025-01-31', 150000000.00, 2, 'Nguyễn Văn KD', '2024-02-05', 'Online', 'TP.HCM', 'Chưa thanh toán', 'Công ty XYZ', 'Thiết kế website', '', 'Website bán hàng & giới thiệu công ty', NULL, 150000000.00, 0.00, 150000000.00, '2025-04-25 12:46:59', '2025-04-25 12:46:59'),
(13, '00000003', '00000003', 'Phạm Văn C', 3, '0309998888', '2024-03-01', '2024-09-01', 90000000.00, 3, 'Trần Văn KT', '2024-03-03', 'Email', 'Đà Nẵng', 'Đã TT một phần', 'MobileTech', 'Ứng dụng đặt hàng', '', 'Ứng dụng mobile tích hợp thanh toán', NULL, 90000000.00, 40000000.00, 50000000.00, '2025-04-25 12:46:59', '2025-04-25 12:46:59'),
(14, '00000004', '00000004', 'Đỗ Thị D', 4, '0404567890', '2024-04-01', '2025-04-01', 130000000.00, 2, 'Nguyễn Văn KD', '2024-04-04', 'Giới thiệu', 'Hải Phòng', 'Quá hạn', 'SmartHome JSC', 'Thiết bị IoT', '', 'Hệ thống điều khiển nhà thông minh', NULL, 130000000.00, 50000000.00, 80000000.00, '2025-04-25 12:46:59', '2025-04-25 12:46:59'),
(18, '00000008', '00000008', 'Trần Văn H', 8, '0808881234', '2024-08-15', '2025-08-14', 98000000.00, 5, 'Phạm Thị TM', '2024-08-16', 'Đối tác', 'Nghệ An', 'Chưa gửi', 'Telecom24h', 'VoIP nội bộ', '', 'Tổng đài nội bộ qua mạng', NULL, 98000000.00, 0.00, 98000000.00, '2025-04-25 12:46:59', '2025-04-25 12:46:59'),
(20, '00000010', '00000010', 'Hoàng Văn K', 10, '1001237890', '2024-10-01', '2025-09-30', 115000000.00, 2, 'Trần Thị B', '2024-10-05', 'Telesales', 'Bắc Giang', 'Đã thanh toán', 'VPS Express', 'Cung cấp máy chủ ảo', 'Không có ghi chú', 'VPS + bảo trì hệ thống 12 tháng', NULL, 115000000.00, 115000000.00, 0.00, '2025-04-25 12:46:59', '2025-04-26 20:53:02'),
(22, '00000012', NULL, 'Nguyễn Văn A', 11, '45454', '2025-03-30', '2025-05-10', 10000000000.00, 3, 'Lê Văn C', '2025-04-16', 'Facebook', '0', 'Đã thanh toán', 'hjghjgh', 'hgjghjgh', 'Không có ghi chú', NULL, NULL, 10000000000.00, 0.00, 10000000000.00, '2025-04-26 09:46:08', '2025-04-26 09:47:18');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `customer`
--

CREATE TABLE `customer` (
  `customer_id` int NOT NULL,
  `customer_code` varchar(50) DEFAULT NULL,
  `customer_data_id` int DEFAULT NULL,
  `tax_code` varchar(50) DEFAULT NULL,
  `product_name` varchar(255) DEFAULT NULL,
  `handover_date` date DEFAULT NULL,
  `staff_in_charge_name` varchar(255) DEFAULT NULL,
  `attachment` text,
  `status` enum('Chưa bắt đầu','Tạm ngưng','Đang làm','Bàn giao','Hoàn thành') DEFAULT 'Chưa bắt đầu',
  `company_name` varchar(255) DEFAULT NULL,
  `industry` varchar(100) DEFAULT NULL,
  `comment` text,
  `note` text,
  `description` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `customer`
--

INSERT INTO `customer` (`customer_id`, `customer_code`, `customer_data_id`, `tax_code`, `product_name`, `handover_date`, `staff_in_charge_name`, `attachment`, `status`, `company_name`, `industry`, `comment`, `note`, `description`) VALUES
(1, '00000001', 1, '0101234567', 'Gói mạng doanh nghiệp', '2024-01-01', 'Trần Thị QL', NULL, 'Bàn giao', 'Công ty ABC', 'Viễn thông', '', '', 'Cung cấp Internet tốc độ cao'),
(2, '00000002', 2, '0207654321', 'Phần mềm bán hàng', '2024-02-01', 'Nguyễn Văn KD', NULL, 'Đang làm', 'Công ty XYZ', 'Phần mềm', '', '', 'Phần mềm quản lý bán hàng'),
(3, '00000003', 3, '0309998888', 'Ứng dụng mobile', '2024-03-01', 'Trần Văn KT', NULL, 'Tạm ngưng', 'Công ty ABC Mobile', 'Ứng dụng', '', '', 'Ứng dụng đặt hàng online'),
(4, '00000004', 4, '0404567890', 'Thiết bị IoT', '2024-04-01', 'Nguyễn Văn KD', NULL, 'Đang làm', 'SmartHome JSC', 'Công nghệ', '', '', 'Giải pháp nhà thông minh'),
(5, '00000005', 5, '0501234560', 'Website doanh nghiệp', '2024-05-01', 'Trần Thị QL', NULL, 'Bàn giao', 'Design Pro', 'Thiết kế', '', '', 'Thiết kế giao diện website'),
(6, '00000006', 6, '0602233445', 'Cung cấp hosting', '2024-06-01', 'Trần Văn KT', NULL, 'Hoàn thành', 'HostingX', 'Hạ tầng mạng', '', '', 'Máy chủ lưu trữ doanh nghiệp'),
(7, '00000007', 7, '0705566778', 'Hệ thống CRM', '2024-07-01', 'Lê Văn HT', NULL, 'Đang làm', 'CRM Center', 'Phần mềm', '', '', 'Hệ thống quản lý khách hàng'),
(8, '00000008', 8, '0808881234', 'Hệ thống VoIP', '2024-08-01', 'Phạm Thị TM', NULL, 'Chưa bắt đầu', 'Telecom24h', 'Viễn thông', '', '', 'Giải pháp tổng đài IP'),
(9, '00000009', 9, '0908765432', 'Giải pháp sản xuất', '2024-09-01', 'Nguyễn Văn KD', NULL, 'Tạm ngưng', 'Manufacture Pro', 'Công nghiệp', '', '', 'Tối ưu hóa sản xuất'),
(10, '00000010', 10, '1001237890', 'Dịch vụ máy chủ', '2024-10-01', 'Trần Thị QL', NULL, 'Hoàn thành', 'VPS Express', 'Hạ tầng mạng', '', '', 'Cung cấp VPS doanh nghiệp'),
(11, '00000012', NULL, '45454', NULL, NULL, NULL, NULL, 'Chưa bắt đầu', 'hjghjgh', NULL, NULL, NULL, NULL),
(12, '00000014', NULL, '45454', NULL, NULL, NULL, NULL, 'Chưa bắt đầu', '', NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `customerdata`
--

CREATE TABLE `customerdata` (
  `customer_data_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `last_care_date` date DEFAULT NULL,
  `staff_id` int DEFAULT NULL,
  `staff_in_charge_name` varchar(255) DEFAULT NULL,
  `customer_code` varchar(50) DEFAULT NULL,
  `customer_id` int DEFAULT NULL,
  `industry` varchar(100) DEFAULT NULL,
  `full_name` varchar(255) DEFAULT NULL,
  `region` varchar(100) DEFAULT NULL,
  `phone_number` varchar(20) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `source` varchar(100) DEFAULT NULL,
  `customer_note` text,
  `comment` text,
  `note` text,
  `status` enum('Mới','Tiếp cận','Chưa tiếp cận','Tiềm năng','Đã đặt lịch','Thành công','Không thành công') DEFAULT 'Mới',
  `appointment` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `customerdata`
--

INSERT INTO `customerdata` (`customer_data_id`, `created_at`, `updated_at`, `last_care_date`, `staff_id`, `staff_in_charge_name`, `customer_code`, `customer_id`, `industry`, `full_name`, `region`, `phone_number`, `email`, `source`, `customer_note`, `comment`, `note`, `status`, `appointment`) VALUES
(1, '2025-04-25 12:45:15', '2025-04-25 12:45:15', NULL, 1, 'Trần Thị QL', NULL, NULL, NULL, 'Nguyễn Văn A', NULL, '0912345678', 'a@example.com', NULL, NULL, NULL, NULL, 'Mới', NULL),
(2, '2025-04-25 12:45:15', '2025-04-25 12:45:15', NULL, 2, 'Nguyễn Văn KD', NULL, NULL, NULL, 'Lê Thị B', NULL, '0923456789', 'b@example.com', NULL, NULL, NULL, NULL, 'Tiềm năng', NULL),
(3, '2025-04-25 12:45:15', '2025-04-25 12:45:15', NULL, 3, 'Trần Văn KT', NULL, NULL, NULL, 'Phạm Văn C', NULL, '0934567890', 'c@example.com', NULL, NULL, NULL, NULL, 'Tiếp cận', NULL),
(4, '2025-04-25 12:45:15', '2025-04-25 12:45:15', NULL, 1, 'Trần Thị QL', NULL, NULL, NULL, 'Đỗ Thị D', NULL, '0945678901', 'd@example.com', NULL, NULL, NULL, NULL, 'Mới', NULL),
(5, '2025-04-25 12:45:15', '2025-04-25 12:45:15', NULL, 2, 'Nguyễn Văn KD', NULL, NULL, NULL, 'Bùi Văn E', NULL, '0956789012', 'e@example.com', NULL, NULL, NULL, NULL, 'Đã đặt lịch', NULL),
(6, '2025-04-25 12:45:15', '2025-04-25 12:45:15', NULL, 3, 'Trần Văn KT', NULL, NULL, NULL, 'Lý Văn F', NULL, '0967890123', 'f@example.com', NULL, NULL, NULL, NULL, 'Tiềm năng', NULL),
(7, '2025-04-25 12:45:15', '2025-04-25 12:45:15', NULL, 4, 'Lê Văn HT', NULL, NULL, NULL, 'Nguyễn Thị G', NULL, '0978901234', 'g@example.com', NULL, NULL, NULL, NULL, 'Chưa tiếp cận', NULL),
(8, '2025-04-25 12:45:15', '2025-04-25 12:45:15', NULL, 5, 'Phạm Thị TM', NULL, NULL, NULL, 'Trần Văn H', NULL, '0989012345', 'h@example.com', NULL, NULL, NULL, NULL, 'Thành công', NULL),
(9, '2025-04-25 12:45:15', '2025-04-25 12:45:15', NULL, 2, 'Nguyễn Văn KD', NULL, NULL, NULL, 'Ngô Thị I', NULL, '0990123456', 'i@example.com', NULL, NULL, NULL, NULL, 'Không thành công', NULL),
(10, '2025-04-25 12:45:15', '2025-04-25 12:45:15', NULL, 1, 'Trần Thị QL', NULL, NULL, NULL, 'Hoàng Văn K', NULL, '0901234567', 'k@example.com', NULL, NULL, NULL, NULL, 'Mới', NULL);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `payment`
--

CREATE TABLE `payment` (
  `payment_id` int NOT NULL,
  `contract_id` int DEFAULT NULL,
  `payment_date` date DEFAULT NULL,
  `amount` decimal(15,2) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `payment`
--

INSERT INTO `payment` (`payment_id`, `contract_id`, `payment_date`, `amount`, `created_at`, `updated_at`) VALUES
(6, 11, '2024-05-01', 10000000.00, '2025-04-26 20:20:43', '2025-04-26 20:20:43'),
(7, 12, '2024-05-02', 15000000.00, '2025-04-26 20:20:43', '2025-04-26 20:20:43'),
(8, 13, '2024-05-03', 8000000.00, '2025-04-26 20:20:43', '2025-04-26 20:20:43'),
(9, 14, '2024-05-04', 12000000.00, '2025-04-26 20:20:43', '2025-04-26 20:20:43');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `role`
--

CREATE TABLE `role` (
  `role_id` int NOT NULL,
  `role_name` varchar(255) NOT NULL,
  `description` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `role`
--

INSERT INTO `role` (`role_id`, `role_name`, `description`) VALUES
(1, 'Admin', 'Quản trị viên toàn quyền'),
(2, 'Manager', 'Quản lý các phòng ban'),
(3, 'Sales', 'Nhân viên kinh doanh'),
(4, 'Accounting', 'Nhân viên kế toán'),
(5, 'Support', 'Nhân viên hỗ trợ');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `staffreport`
--

CREATE TABLE `staffreport` (
  `report_id` int NOT NULL,
  `staff_id` int DEFAULT NULL,
  `report_date` date DEFAULT NULL,
  `total_contracts` int DEFAULT NULL,
  `contracts_sent` int DEFAULT NULL,
  `contracts_signed` int DEFAULT NULL,
  `contracts_cancelled` int DEFAULT NULL,
  `total_payment_amount` decimal(15,2) DEFAULT NULL,
  `total_contract_value` decimal(15,2) DEFAULT NULL,
  `projects_transferred` int DEFAULT NULL,
  `projects_completed` int DEFAULT NULL,
  `note` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `staffreport`
--

INSERT INTO `staffreport` (`report_id`, `staff_id`, `report_date`, `total_contracts`, `contracts_sent`, `contracts_signed`, `contracts_cancelled`, `total_payment_amount`, `total_contract_value`, `projects_transferred`, `projects_completed`, `note`, `created_at`, `updated_at`) VALUES
(11, 1, '2024-04-01', 20, 18, 15, 3, 50000000.00, 60000000.00, 5, 4, 'Báo cáo đầu tháng 4.', '2025-04-26 20:11:02', '2025-04-26 20:11:02'),
(12, 2, '2024-04-01', 25, 22, 20, 2, 70000000.00, 80000000.00, 6, 5, 'Hoàn thành KPI.', '2025-04-26 20:11:02', '2025-04-26 20:11:02'),
(13, 3, '2024-04-02', 18, 15, 14, 1, 45000000.00, 50000000.00, 3, 3, 'Giao dịch tốt.', '2025-04-26 20:11:02', '2025-04-26 20:11:02'),
(14, 4, '2024-04-02', 30, 28, 26, 2, 90000000.00, 100000000.00, 8, 7, 'Hiệu quả cao.', '2025-04-26 20:11:02', '2025-04-26 20:11:02'),
(15, 5, '2024-04-03', 10, 9, 8, 1, 20000000.00, 25000000.00, 2, 2, 'Cần cải thiện.', '2025-04-26 20:11:02', '2025-04-26 20:11:02');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `useraccount`
--

CREATE TABLE `useraccount` (
  `user_id` int NOT NULL,
  `employee_code` varchar(50) DEFAULT NULL,
  `full_name` varchar(255) DEFAULT NULL,
  `phone_number` varchar(20) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `birth_date` date DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `gender` enum('Male','Female','Other') DEFAULT 'Male',
  `status` enum('Active','Inactive') DEFAULT 'Active',
  `two_factor_auth` tinyint(1) DEFAULT '0',
  `role_id` int DEFAULT NULL,
  `note` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- Đang đổ dữ liệu cho bảng `useraccount`
--

INSERT INTO `useraccount` (`user_id`, `employee_code`, `full_name`, `phone_number`, `password`, `birth_date`, `email`, `address`, `gender`, `status`, `two_factor_auth`, `role_id`, `note`, `created_at`, `updated_at`) VALUES
(1, '0000001', 'Hoàng321312 1312', '0912345678', '123456', '2025-04-01', '0912345678', 'Hà Nội', 'Male', 'Active', 1, 1, '31312', '2025-04-25 10:44:17', '2025-04-26 23:44:26'),
(2, '0000002', 'Trần Thị B', '0987654321', '123456', '1992-03-15', 'b@example.com', 'Hồ Chí Minh', 'Female', 'Active', 0, 2, 'Ghi chú B', '2025-04-25 10:44:17', '2025-04-26 23:44:21'),
(3, '0000003', 'Lê Văn C', '0909123456', '123456', NULL, 'c@example.com', 'Đà Nẵng', 'Male', 'Active', 0, 1, NULL, '2025-04-25 10:44:17', '2025-04-26 23:44:14'),
(4, '0000004', 'Phạm Thị D231', '0912345678', '123456', '2025-04-09', '0912345678', 'Hà Nội', 'Female', 'Active', 1, 1, '312', '2025-04-25 10:44:17', '2025-04-26 23:42:07'),
(5, '0000005', 'Hoàng Quốc E12', '159263487', '123456', '1995-07-21', 'e@example.com', 'Cần Thơ', 'Other', 'Active', 0, 3, 'Ghi chú E', '2025-04-25 10:44:17', '2025-04-26 23:40:00'),
(10, 'NV000006', 'abc1231231', '123123123', '123456', NULL, '123@gmail.cpm', 'HN', 'Male', 'Active', 0, 1, NULL, '2025-04-26 23:45:22', '2025-04-26 23:45:22'),
(11, 'NV000007', '1234asc', '0234567890', '123456', NULL, 'bc@gmail.com', 'HN', 'Male', 'Active', 0, 1, NULL, '2025-04-27 08:58:32', '2025-04-27 08:58:32');

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `accountrequest`
--
ALTER TABLE `accountrequest`
  ADD PRIMARY KEY (`request_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Chỉ mục cho bảng `activity`
--
ALTER TABLE `activity`
  ADD PRIMARY KEY (`activity_id`),
  ADD KEY `customer_data_id` (`customer_data_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Chỉ mục cho bảng `contract`
--
ALTER TABLE `contract`
  ADD PRIMARY KEY (`contract_id`),
  ADD KEY `customer_id` (`customer_id`),
  ADD KEY `staff_id` (`staff_id`);

--
-- Chỉ mục cho bảng `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`customer_id`),
  ADD UNIQUE KEY `customer_code` (`customer_code`),
  ADD KEY `customer_data_id` (`customer_data_id`);

--
-- Chỉ mục cho bảng `customerdata`
--
ALTER TABLE `customerdata`
  ADD PRIMARY KEY (`customer_data_id`),
  ADD KEY `staff_id` (`staff_id`),
  ADD KEY `fk_customer_id` (`customer_id`);

--
-- Chỉ mục cho bảng `payment`
--
ALTER TABLE `payment`
  ADD PRIMARY KEY (`payment_id`),
  ADD KEY `contract_id` (`contract_id`);

--
-- Chỉ mục cho bảng `role`
--
ALTER TABLE `role`
  ADD PRIMARY KEY (`role_id`);

--
-- Chỉ mục cho bảng `staffreport`
--
ALTER TABLE `staffreport`
  ADD PRIMARY KEY (`report_id`),
  ADD KEY `staff_id` (`staff_id`);

--
-- Chỉ mục cho bảng `useraccount`
--
ALTER TABLE `useraccount`
  ADD PRIMARY KEY (`user_id`),
  ADD KEY `role_id` (`role_id`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `accountrequest`
--
ALTER TABLE `accountrequest`
  MODIFY `request_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT cho bảng `activity`
--
ALTER TABLE `activity`
  MODIFY `activity_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT cho bảng `contract`
--
ALTER TABLE `contract`
  MODIFY `contract_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=44;

--
-- AUTO_INCREMENT cho bảng `customer`
--
ALTER TABLE `customer`
  MODIFY `customer_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT cho bảng `customerdata`
--
ALTER TABLE `customerdata`
  MODIFY `customer_data_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT cho bảng `payment`
--
ALTER TABLE `payment`
  MODIFY `payment_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT cho bảng `role`
--
ALTER TABLE `role`
  MODIFY `role_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT cho bảng `staffreport`
--
ALTER TABLE `staffreport`
  MODIFY `report_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT cho bảng `useraccount`
--
ALTER TABLE `useraccount`
  MODIFY `user_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `accountrequest`
--
ALTER TABLE `accountrequest`
  ADD CONSTRAINT `accountrequest_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `useraccount` (`user_id`);

--
-- Các ràng buộc cho bảng `activity`
--
ALTER TABLE `activity`
  ADD CONSTRAINT `activity_ibfk_1` FOREIGN KEY (`customer_data_id`) REFERENCES `customerdata` (`customer_data_id`),
  ADD CONSTRAINT `activity_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `useraccount` (`user_id`);

--
-- Các ràng buộc cho bảng `contract`
--
ALTER TABLE `contract`
  ADD CONSTRAINT `contract_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`),
  ADD CONSTRAINT `contract_ibfk_2` FOREIGN KEY (`staff_id`) REFERENCES `useraccount` (`user_id`);

--
-- Các ràng buộc cho bảng `customer`
--
ALTER TABLE `customer`
  ADD CONSTRAINT `customer_ibfk_1` FOREIGN KEY (`customer_data_id`) REFERENCES `customerdata` (`customer_data_id`);

--
-- Các ràng buộc cho bảng `customerdata`
--
ALTER TABLE `customerdata`
  ADD CONSTRAINT `customerdata_ibfk_1` FOREIGN KEY (`staff_id`) REFERENCES `useraccount` (`user_id`),
  ADD CONSTRAINT `fk_customer_id` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`);

--
-- Các ràng buộc cho bảng `payment`
--
ALTER TABLE `payment`
  ADD CONSTRAINT `payment_ibfk_1` FOREIGN KEY (`contract_id`) REFERENCES `contract` (`contract_id`);

--
-- Các ràng buộc cho bảng `staffreport`
--
ALTER TABLE `staffreport`
  ADD CONSTRAINT `staffreport_ibfk_1` FOREIGN KEY (`staff_id`) REFERENCES `useraccount` (`user_id`);

--
-- Các ràng buộc cho bảng `useraccount`
--
ALTER TABLE `useraccount`
  ADD CONSTRAINT `useraccount_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `role` (`role_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
