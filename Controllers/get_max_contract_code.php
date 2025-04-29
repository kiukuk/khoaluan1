<?php
// Hiển thị lỗi chi tiết
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

include 'connect.php'; // đường dẫn connect.php của bạn

header('Content-Type: application/json');

try {
    // Chỉnh query: ép contract_code thành số
    $sql = "SELECT MAX(CAST(contract_code AS UNSIGNED)) AS max_code FROM contract";
    $result = $conn->query($sql);

    if (!$result) {
        throw new Exception("Lỗi truy vấn SQL: " . $conn->error);
    }

    $row = $result->fetch_assoc();

    if ($row && isset($row['max_code'])) {
        $maxCode = $row['max_code'];

        if (empty($maxCode)) {
            $newCode = '00000001'; // Nếu bảng rỗng
        } else {
            $newNumber = intval($maxCode) + 1;
            $newCode = str_pad($newNumber, 8, '0', STR_PAD_LEFT);
        }

        echo json_encode([
            'success' => true,
            'max_contract_code' => $newCode
        ]);
    } else {
        throw new Exception("Không có dữ liệu hợp đồng.");
    }
} catch (Exception $e) {
    echo json_encode([
        'success' => false,
        'message' => $e->getMessage()
    ]);
}
?>
