<?php
include 'connect.php'; // Kết nối database

header('Content-Type: application/json');

// Lấy mã hợp đồng từ URL
$contract_code = $_GET['contract_code'] ?? '';

if (!$contract_code) {
    echo json_encode(['success' => false, 'message' => 'Thiếu mã hợp đồng']);
    exit;
}

// Câu lệnh SQL lấy thông tin hợp đồng
$sql = "SELECT * FROM Contract WHERE contract_code = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("s", $contract_code);
$stmt->execute();
$result = $stmt->get_result();

// Trả về kết quả
if ($row = $result->fetch_assoc()) {
    echo json_encode(['success' => true, 'contract' => $row]);
} else {
    echo json_encode(['success' => false, 'message' => 'Không tìm thấy hợp đồng']);
}

$stmt->close();
$conn->close();
?>
