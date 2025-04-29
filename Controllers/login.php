<?php
session_start();
require 'connect.php'; // file kết nối CSDL

if ($_SERVER["REQUEST_METHOD"] === "POST") {
    $username = trim($_POST['username']);
    $passwordInput = $_POST['password'];

    // Truy vấn người dùng
    $sql = "SELECT * FROM UserAccount WHERE (email = ? OR phone_number = ?) AND status = 'Active'";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("ss", $username, $username);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows === 1) {
        $user = $result->fetch_assoc();

        // So sánh mật khẩu trực tiếp
        if ($passwordInput === $user['password']) {
            // Đăng nhập thành công
            $_SESSION['user_id'] = $user['user_id'];
            $_SESSION['full_name'] = $user['full_name'];
            $_SESSION['role_id'] = $user['role_id'];

            // Chuyển hướng về trang tài khoản
            $user_id = $user['user_id'];
            $role_id = $user['role_id'];
            header("Location: ../Views/taikhoan.html?user_id=$user_id&role_id=$role_id");
            exit;
        } else {
            echo "<script>alert('⚠️ Sai mật khẩu.'); window.history.back();</script>";
        }
    } else {
        echo "<script>alert('⚠️ Tài khoản không tồn tại hoặc đã bị vô hiệu hóa.'); window.history.back();</script>";
    }
} else {
    http_response_code(405);
    echo "⛔ Phương thức truy cập không được hỗ trợ.";
}
?>
