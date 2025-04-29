<?php
include 'connect.php';
header('Content-Type: application/json');

$sql = "SELECT * FROM CustomerData";
$result = $conn->query($sql);

$data = [];
while ($row = $result->fetch_assoc()) {
    $data[] = $row;
}
echo json_encode($data);
$conn->close();
?>
