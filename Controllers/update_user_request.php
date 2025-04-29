<?php
// Bật thông báo lỗi
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

// Kết nối
include 'connect.php';
header('Content-Type: application/json');

// Nhận dữ liệu JSON
$data = json_decode(file_get_contents("php://input"), true);

// Kiểm tra dữ liệu đầu vào
if (!$data || !isset($data['rowId'])) {
    http_response_code(400);
    echo json_encode(["message" => "Dữ liệu không hợp lệ."]);
    exit;
}

$userId = str_replace("row-", "", $data['rowId']);

$fullName   = $data['full_name'] ?? '';
$phone      = $data['phone_number'] ?? '';
$email      = $data['email'] ?? '';
$password   = password_hash($data['password'], PASSWORD_DEFAULT);
$birthDate  = !empty($data['birth_date']) ? $data['birth_date'] : null;
$address    = $data['address'] ?? '';
$roleId     = $data['role_id'] ?? null;
$status     = $data['status'] ?? 'inactive';
$note       = !empty($data['note']) ? $data['note'] : null;

// Bắt đầu transaction
$conn->begin_transaction();

try {
    // Bước 1: Update UserAccount
    $sql1 = "UPDATE UserAccount 
            SET full_name = ?, phone_number = ?, email = ?, password = ?, birth_date = ?, 
                address = ?, role_id = ?, status = ?, note = ?, updated_at = NOW()
            WHERE user_id = ?";

    $stmt1 = $conn->prepare($sql1);
    if (!$stmt1) {
        throw new Exception("Lỗi prepare UserAccount: " . $conn->error);
    }

    $stmt1->bind_param(
        "ssssssissi",
        $fullName,
        $phone,
        $email,
        $password,
        $birthDate,
        $address,
        $roleId,
        $status,
        $note,
        $userId
    );

    if (!$stmt1->execute()) {
        throw new Exception("Lỗi update UserAccount: " . $stmt1->error);
    }

    $stmt1->close();

    // Bước 2: Update trạng thái AccountRequest
    $sql2 = "UPDATE AccountRequest SET status = 'approved' WHERE user_id = ?";
    $stmt2 = $conn->prepare($sql2);

    if (!$stmt2) {
        throw new Exception("Lỗi prepare AccountRequest: " . $conn->error);
    }

    $stmt2->bind_param("i", $userId);

    if (!$stmt2->execute()) {
        throw new Exception("Lỗi update AccountRequest: " . $stmt2->error);
    }

    $stmt2->close();

    // Nếu không lỗi, commit transaction
    $conn->commit();

    echo json_encode(["success" => true, "message" => "Cập nhật thành công và đã chuyển trạng thái yêu cầu."]);
} catch (Exception $e) {
    $conn->rollback();
    http_response_code(500);
    echo json_encode(["success" => false, "message" => $e->getMessage()]);
}

$conn->close();
?>
