<?php
// admin/taikhoan/get_pending_request_count.php

include 'connect.php'; // Chỉnh lại đúng đường dẫn kết nối database

header('Content-Type: application/json');

$sql = "SELECT COUNT(*) as pending_count FROM AccountRequest WHERE status = 'Chờ duyệt'";
$result = $conn->query($sql);

if ($result && $row = $result->fetch_assoc()) {
    echo json_encode(['pending_count' => (int) $row['pending_count']]);
} else {
    echo json_encode(['pending_count' => 0]);
}

$conn->close();
?>