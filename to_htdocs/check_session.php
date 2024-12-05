<?php
// Add these headers at the very top of the file
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
ini_set('display_errors', 1);
error_reporting(E_ALL);

require 'db.php';
session_start();

if (isset($_SESSION['user_id'])) {
    echo json_encode([
        'status' => 'success',
        'message' => 'Session is active',
        'user_id' => $_SESSION['user_id']
    ]);
} else {
    echo json_encode([
        'status' => 'error',
        'message' => 'Session expired or not logged in'
    ]);
}
?>
