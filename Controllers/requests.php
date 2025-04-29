<?php
include 'connect.php'; // Đảm bảo đường dẫn đúng đến file kết nối DB

header('Content-Type: application/json');

$sql = "SELECT r.request_id, r.type, r.status, r.created_at, 
               u.full_name, u.employee_code, u.user_id
        FROM AccountRequest r
        JOIN UserAccount u ON r.user_id = u.user_id
        ORDER BY r.created_at DESC";

$result = $conn->query($sql);

$data = [];

if ($result && $result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $data[] = [
            'requestId' => $row['request_id'],
            'type' => $row['type'],
            'status' => ucfirst($row['status']),
            'createdAt' => date('d/m/Y H:i', strtotime($row['created_at'])),
            'full_name' => $row['full_name'],
            'employee_code' => $row['employee_code'],
            'rowId' => 'row-' . $row['user_id']
        ];
    }
}

echo json_encode($data);
$conn->close();
?>