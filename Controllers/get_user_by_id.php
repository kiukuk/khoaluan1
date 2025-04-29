<?php
include 'connect.php';
header('Content-Type: application/json');

$user_id = $_GET['user_id'] ?? null;

if ($user_id) {
    $stmt = $conn->prepare("SELECT full_name FROM UserAccount WHERE user_id = ?");
    $stmt->bind_param("i", $user_id);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($user = $result->fetch_assoc()) {
        echo json_encode($user);
    } else {
        echo json_encode(['error' => 'Không tìm thấy người dùng']);
    }

    $stmt->close();
} else {
    echo json_encode(['error' => 'Thiếu user_id']);
}
$conn->close();
?>
