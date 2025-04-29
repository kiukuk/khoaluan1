<?php
header('Content-Type: application/json');

// Hiện lỗi chi tiết trong môi trường local
error_reporting(E_ALL);
ini_set('display_errors', 1);

// Kết nối database
include 'connect.php'; // Đường dẫn đến file kết nối DB


// Lấy dữ liệu contract_code từ POST
$contractCode = $_POST['contract_code'] ?? '';

if (empty($contractCode)) {
    echo json_encode(["success" => false, "message" => "Thiếu mã hợp đồng"]);
    exit;
}

// Chuẩn bị xóa
$sql = "DELETE FROM Contract WHERE contract_code = ?";
$stmt = $conn->prepare($sql);

if (!$stmt) {
    echo json_encode(["success" => false, "message" => "Prepare thất bại: " . $conn->error]);
    exit;
}

// Bind tham số
if (!$stmt->bind_param("s", $contractCode)) {
    echo json_encode(["success" => false, "message" => "Bind param thất bại: " . $stmt->error]);
    exit;
}

// Thực thi
if (!$stmt->execute()) {
    echo json_encode(["success" => false, "message" => "Thực thi thất bại: " . $stmt->error]);
} else {
    echo json_encode(["success" => true]);
}

$stmt->close();
$conn->close();
?>