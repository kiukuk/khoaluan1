<?php
include 'connect.php';
header('Content-Type: application/json');

$data = json_decode(file_get_contents("php://input"), true);
$userId = $data['user_id'] ?? null;

if (!$userId) {
    echo json_encode(["message" => "Thiếu mã người dùng"]);
    exit;
}

$sql = "UPDATE UserAccount SET status = 'inactive', updated_at = NOW() WHERE user_id = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("i", $userId);

if ($stmt->execute()) {
    echo json_encode(["message" => "Đã chuyển sang trạng thái ngừng hoạt động."]);
} else {
    echo json_encode(["message" => "Cập nhật thất bại: " . $stmt->error]);
}

$stmt->close();
$conn->close();
?>