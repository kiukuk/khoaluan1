<?php
include 'connect.php';
header('Content-Type: application/json');

$sql = "SELECT * FROM UserAccount";
$result = $conn->query($sql);

$data = [];

if ($result && $result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $data[] = [
            'rowId'       => 'row-' . $row['user_id'],
            'employeeId'  => $row['employee_code'] ?? '',
            'fullName'    => $row['full_name'] ?? '',
            'phone'       => $row['phone_number'] ?? '',
            'email'       => $row['email'] ?? '',
            'status'      => strtolower($row['status'] ?? 'inactive'),
            'createdAt'   => isset($row['created_at']) ? date('d/m/Y H:i', strtotime($row['created_at'])) : '',
            'birth_date'  => $row['birth_date'] ?? '',
            'address'     => $row['address'] ?? '',
            'note'        => $row['note'] ?? '',
            'role_id'     => $row['role_id'] ?? '',
        ];
    }
}

echo json_encode($data);
$conn->close();
?>
