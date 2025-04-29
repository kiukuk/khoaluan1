<?php
include 'connect.php';
header('Content-Type: application/json');

$sql = "SELECT * FROM Customer";
$result = $conn->query($sql);

$customers = [];
while ($row = $result->fetch_assoc()) {
    $customers[] = $row;
}
echo json_encode($customers);
$conn->close();
?>