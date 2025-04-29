<?php
header('Content-Type: application/json');
include 'connect.php'; // Kết nối database

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Đọc dữ liệu JSON gửi lên
    $input = json_decode(file_get_contents('php://input'), true);

    if (!$input) {
        echo json_encode(['success' => false, 'message' => 'Dữ liệu gửi lên không hợp lệ!']);
        exit;
    }

    $contract_code = $input['contract_code'] ?? null;
    $customer_id = $input['customer_id'] ?? null;
    $customer_name = $input['customer_name'] ?? null;
    $tax_code = $input['tax_code'] ?? null;
    $start_date = $input['start_date'] ?? null;
    $end_date = $input['end_date'] ?? null;
    $value = $input['value'] ?? 0;
    $signing_date = $input['signing_date'] ?? null;
    $source = $input['source'] ?? null;
    $region = $input['region'] ?? null;
    $status = $input['status'] ?? 'Chưa gửi';
    $company_name = $input['company_name'] ?? null;
    $service_product = $input['product_service'] ?? null;
    $note = $input['note'] ?? null;
    $description = $input['description'] ?? null;
    $staff_id = $input['staff_id'] ?? null;
    $staff_in_charge_name = $input['staff_in_charge_name'] ?? null;

    try {
        if (!$contract_code || !$customer_id) {
            throw new Exception('Thiếu mã hợp đồng hoặc mã khách hàng!');
        }

        // Kiểm tra nếu customer_id đã tồn tại
        $checkCustomer = $conn->prepare("SELECT customer_id FROM Customer WHERE customer_id = ?");
        $checkCustomer->bind_param("i", $customer_id);
        $checkCustomer->execute();
        $checkCustomer->store_result();

        if ($checkCustomer->num_rows === 0) {
            // Nếu chưa có khách hàng thì thêm mới
            $insertCustomer = $conn->prepare("INSERT INTO Customer (customer_code, tax_code, company_name, status) VALUES (?, ?, ?, 'Chưa bắt đầu')");
            $insertCustomer->bind_param("sss", $contract_code, $tax_code, $company_name);
            if (!$insertCustomer->execute()) {
                throw new Exception('Không thể tạo khách hàng mới: ' . $insertCustomer->error);
            }
            $customer_id = $conn->insert_id;
        }

        // Insert hợp đồng
        $stmt = $conn->prepare("INSERT INTO Contract (contract_code, customer_id, customer_name, tax_code, start_date, end_date, value, signing_date, source, region, status, company_name, service_product, note, total_value, amount_paid, amount_due) 
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");

        $total_value = $value;
        $amount_paid = 0;
        $amount_due = $total_value;

        $stmt->bind_param(
            "sisssssssisssssdd",
            $contract_code,
            $customer_id,
            $customer_name,
            $tax_code,
            $start_date,
            $end_date,
            $value,
            $signing_date,
            $source,
            $region,
            $status,
            $company_name,
            $service_product,
            $note,
            $total_value,
            $amount_paid,
            $amount_due
        );

        if ($stmt->execute()) {
            echo json_encode([
                'success' => true,
                'message' => 'Tạo hợp đồng thành công!'
            ]);
        } else {
            throw new Exception('Lỗi khi thêm hợp đồng: ' . $stmt->error);
        }
    } catch (Exception $e) {
        echo json_encode([
            'success' => false,
            'message' => 'Lỗi hệ thống: ' . $e->getMessage()
        ]);
    }
} else {
    echo json_encode([
        'success' => false,
        'message' => 'Phương thức yêu cầu không hợp lệ.'
    ]);
}
?>