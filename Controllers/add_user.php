<?php
include 'connect.php'; // File kết nối DB

header('Content-Type: application/json');

// Nhận dữ liệu gửi từ frontend
$data = json_decode(file_get_contents('php://input'), true);

// Kiểm tra các trường bắt buộc
if (
    empty($data['full_name']) || empty($data['phone']) || empty($data['email']) ||
    empty($data['password']) || empty($data['status']) || empty($data['role_id'])
) {
    echo json_encode(['success' => false, 'message' => 'Thiếu thông tin bắt buộc']);
    exit;
}

// Sinh mã nhân viên tự động (VD: NV000001)
$result = $conn->query("SELECT MAX(employee_code) AS max_code FROM UserAccount");
$maxCode = $result->fetch_assoc()['max_code'] ?? '000000';
$nextId = (int) substr($maxCode, 2) + 1;
$newCode =  str_pad($nextId, 8, '0', STR_PAD_LEFT);

// Chuẩn bị câu lệnh INSERT
$stmt = $conn->prepare("INSERT INTO UserAccount (employee_code, full_name, phone_number, password, email, address, status, role_id, created_at) VALUES (?, ?, ?, ?, ?, ?, ?, ?, NOW())");
$password = $data['password']; // Lấy thẳng password không hash
$address = $data['address'] ?? '';
$status = $data['status'];
$role_id = $data['role_id'];

$stmt->bind_param(
    "sssssssi",
    $newCode,
    $data['full_name'],
    $data['phone'],
    $password,
    $data['email'],
    $address,
    $status,
    $role_id
);

// Thực thi và trả kết quả
if ($stmt->execute()) {
    echo json_encode(['success' => true, 'message' => 'Tạo tài khoản thành công']);
} else {
    echo json_encode(['success' => false, 'message' => 'Lỗi: ' . $conn->error]);
}

$stmt->close();
$conn->close();
?>