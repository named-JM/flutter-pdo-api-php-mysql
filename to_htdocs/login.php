<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

require 'db.php';
session_start();

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $username = $_POST['username'];
    $password = $_POST['password'];

    $query = "SELECT * FROM users WHERE username = :username";
    $stmt = $pdo->prepare($query);
    $stmt->execute(['username' => $username]);
    $user = $stmt->fetch();

    if ($user && password_verify($password, $user['password'])) {
        $_SESSION['user_id'] = $user['id']; // Still using 'user_id' for session tracking
        echo json_encode([
            'status' => 'success',
            'message' => 'Login successful',
            'id' => (string)$user['id'], // Convert 'id' to a string
        ]);
    } else {
        echo json_encode([
            'status' => 'error',
            'message' => 'Invalid credentials',
        ]);
    }
}
?>
