<?php 
$servername = "localhost";
$username   = "root";
$password   = "thang1721997";
$database   = "db_123";

$conn = new mysqli($servername, $username, $password, $database);
if ($conn->connect_error) {
    die("❌ Kết nối thất bại: " . $conn->connect_error);
}
$conn->set_charset("utf8mb4");
?>
