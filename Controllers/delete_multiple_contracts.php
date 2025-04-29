<?php
header('Content-Type: application/json');

include 'connect.php'; // Đường dẫn đến file kết nối DB


// Nhận dữ liệu từ body JSON
$data = json_decode(file_get_contents("php://input"), true);

if (isset($data['contract_codes']) && is_array($data['contract_codes'])) {
    $placeholders = implode(',', array_fill(0, count($data['contract_codes']), '?'));
    $stmt = $conn->prepare("DELETE FROM Contract WHERE contract_code IN ($placeholders)");

    if (!$stmt) {
        echo json_encode(["success" => false, "message" => "Lỗi prepare: " . $conn->error]);
        exit();
    }

    $types = str_repeat('s', count($data['contract_codes']));
    $stmt->bind_param($types, ...$data['contract_codes']);

    if ($stmt->execute()) {
        echo json_encode(["success" => true]);
    } else {
        echo json_encode(["success" => false, "message" => "Lỗi khi xóa: " . $stmt->error]);
    }

    $stmt->close();
} else {
    echo json_encode(["success" => false, "message" => "Dữ liệu gửi lên không hợp lệ!"]);
}

$conn->close();
?>