<?php
include 'connect.php'; // File kết nối DB

$sql = "SELECT * FROM Contract";
$result = $conn->query($sql);

$contracts = [];

while ($row = $result->fetch_assoc()) {
    $contracts[] = $row;
}

header('Content-Type: application/json');
echo json_encode($contracts);

$conn->close();
?>
