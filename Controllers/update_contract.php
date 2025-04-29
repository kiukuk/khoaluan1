<?php
include 'connect.php';
header('Content-Type: application/json');

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $data = json_decode(file_get_contents("php://input"), true);

    $contract_code = $data['contract_code'] ?? null;
    $customer_name = $data['customer_name'] ?? null;
    $value = $data['value'] ?? 0;
    $status = $data['status'] ?? null;
    $signing_date = $data['signing_date'] ?? null;
    $note = $data['note'] ?? null;
    $staff_in_charge_name = $data['staff_in_charge_name'] ?? null;
    $staff_id = $data['staff_id'] ?? null;

    // Kiểm tra bắt buộc
    if (!$contract_code || !$customer_name || !$status || !$staff_id) {
        echo json_encode(['success' => false, 'message' => 'Thiếu dữ liệu bắt buộc!']);
        exit;
    }

    $sql = "UPDATE Contract SET 
                customer_name = ?, 
                value = ?, 
                status = ?, 
                signing_date = ?, 
                note = ?, 
                staff_in_charge_name = ?, 
                staff_id = ?,
                updated_at = NOW()
            WHERE contract_code = ?";

    $stmt = $conn->prepare($sql);
    if ($stmt) {
        $stmt->bind_param(
            "sdssssis",
            $customer_name,
            $value,
            $status,
            $signing_date,
            $note,
            $staff_in_charge_name,
            $staff_id,
            $contract_code
        );

        if ($stmt->execute()) {
            echo json_encode(['success' => true, 'message' => 'Cập nhật hợp đồng thành công!']);
        } else {
            echo json_encode(['success' => false, 'message' => 'Lỗi khi cập nhật: ' . $stmt->error]);
        }
        $stmt->close();
    } else {
        echo json_encode(['success' => false, 'message' => 'Lỗi chuẩn bị truy vấn']);
    }
} else {
    echo json_encode(['success' => false, 'message' => 'Phải dùng phương thức POST']);
}

$conn->close();
?>
