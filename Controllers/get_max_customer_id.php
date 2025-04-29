<?php
// Trả về JSON
header('Content-Type: application/json');

// Kết nối database
include 'connect.php'; // Đảm bảo đường dẫn đúng

// Kiểm tra kết nối
if (!$conn) {
    echo json_encode([
        'success' => false,
        'message' => 'Không thể kết nối cơ sở dữ liệu.'
    ]);
    exit;
}

try {
    // ✅ Truy vấn lấy ID lớn nhất từ bảng Customer mới
    $sql = "SELECT MAX(customer_id) AS max_customer_id FROM Customer";
    $result = $conn->query($sql);

    if ($result && $row = $result->fetch_assoc()) {
        $maxCustomerId = $row['max_customer_id'] ?? 0;

        echo json_encode([
            'success' => true,
            'max_customer_id' => $maxCustomerId
        ]);
    } else {
        echo json_encode([
            'success' => false,
            'message' => 'Không tìm thấy khách hàng.'
        ]);
    }
} catch (Exception $e) {
    echo json_encode([
        'success' => false,
        'message' => 'Lỗi hệ thống: ' . $e->getMessage()
    ]);
}
?>
