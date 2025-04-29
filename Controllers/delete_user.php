<?php
include 'connect.php'; // Đường dẫn đến file kết nối DB

header('Content-Type: application/json');

$data = json_decode(file_get_contents('php://input'), true);

// Kiểm tra nếu là mảng nhiều user
if (isset($data['user_ids']) && is_array($data['user_ids'])) {
    $placeholders = implode(',', array_fill(0, count($data['user_ids']), '?'));
    $types = str_repeat('i', count($data['user_ids']));
    $stmt = $conn->prepare("DELETE FROM UserAccount WHERE user_id IN ($placeholders)");

    if ($stmt === false) {
        echo json_encode(['success' => false, 'message' => 'Lỗi prepare: ' . $conn->error]);
        exit;
    }

    $stmt->bind_param($types, ...$data['user_ids']);

    if ($stmt->execute()) {
        echo json_encode(['success' => true, 'message' => 'Xóa ' . $stmt->affected_rows . ' tài khoản thành công']);
    } else {
        echo json_encode(['success' => false, 'message' => 'Lỗi xóa: ' . $stmt->error]);
    }

    $stmt->close();
    $conn->close();
    exit;
}

// Nếu là xóa 1 tài khoản
if (isset($data['user_id'])) {
    $user_id = intval($data['user_id']);
    $stmt = $conn->prepare("DELETE FROM UserAccount WHERE user_id = ?");
    $stmt->bind_param("i", $user_id);

    if ($stmt->execute()) {
        echo json_encode(['success' => true, 'message' => 'Xóa tài khoản thành công']);
    } else {
        echo json_encode(['success' => false, 'message' => 'Xóa thất bại: ' . $stmt->error]);
    }

    $stmt->close();
    $conn->close();
    exit;
}

// Không có dữ liệu hợp lệ
echo json_encode(['success' => false, 'message' => 'Thiếu dữ liệu để xóa']);
