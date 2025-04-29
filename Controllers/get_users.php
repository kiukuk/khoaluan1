<?php
include 'connect.php';
header('Content-Type: application/json');

$sql = "SELECT user_id, full_name FROM UserAccount WHERE status = 'Active'";
$result = $conn->query($sql);

if ($result) {
    $users = [];
    while ($row = $result->fetch_assoc()) {
        $users[] = [
            'user_id' => $row['user_id'],
            'full_name' => $row['full_name']
        ];
    }
    echo json_encode(['success' => true, 'users' => $users]);
} else {
    echo json_encode(['success' => false, 'message' => 'Lỗi truy vấn']);
}

$conn->close();
?>
