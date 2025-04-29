<?php
// Bật thông báo lỗi
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

// Kết nối
include 'connect.php';
header('Content-Type: application/json');

// Nhận dữ liệu JSON
$data = json_decode(file_get_contents("php://input"), true);

// Kiểm tra đầu vào
if (!$data || !isset($data['rowId'])) {
    http_response_code(400);
    echo json_encode(["message" => "Dữ liệu không hợp lệ."]);
    exit;
}

$userId = str_replace("row-", "", $data['rowId']);

$fullName = $data['full_name'] ?? '';
$phone = $data['phone_number'] ?? '';
$email = $data['email'] ?? '';
$password = $data['password']; // Lấy thẳng password không hash
$birthDate = !empty($data['birth_date']) ? $data['birth_date'] : null;
$address = $data['address'] ?? '';
$roleId = $data['role_id'] ?? null;
$status = $data['status'] ?? 'inactive';
$note = !empty($data['note']) ? $data['note'] : null;

// Câu lệnh cập nhật
$sql = "UPDATE UserAccount 
        SET full_name = ?, phone_number = ?, email = ?, password = ?, birth_date = ?, 
            address = ?, role_id = ?, status = ?, note = ?, updated_at = NOW()
        WHERE user_id = ?";

$stmt = $conn->prepare($sql);

if (!$stmt) {
    http_response_code(500);
    echo json_encode(["message" => "Lỗi prepare: " . $conn->error]);
    exit;
}

// Gán tham số
$stmt->bind_param(
    "ssssssissi",
    $fullName,
    $phone,
    $email,
    $password,
    $birthDate,
    $address,
    $roleId,
    $status,
    $note,
    $userId
);

// Thực thi truy vấn
if ($stmt->execute()) {
    echo json_encode(["message" => "Cập nhật thành công."]);
} else {
    http_response_code(500);
    echo json_encode(["message" => "Cập nhật thất bại: " . $stmt->error]);
}

$stmt->close();
$conn->close();
?>