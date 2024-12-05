<?php
include('db.php'); // Database connection (PDO)

// Get the posted data
$bname = $_POST['bname'];
$bnum = $_POST['bnum'];
$baddress = $_POST['baddress'];
$bcategory = $_POST['bcategory'];
$user_id = $_POST['user_id']; // User ID from the logged-in user

// Check if all fields are provided
if (empty($bname) || empty($bnum) || empty($baddress) || empty($bcategory)) {
    echo json_encode(['status' => 'error', 'message' => 'All fields are required.']);
    exit();
}

try {
    // Prepare the SQL query with placeholders
    $query = "INSERT INTO business (bname, bnum, baddress, bcategory, user_id) VALUES (:bname, :bnum, :baddress, :bcategory, :user_id)";
    $stmt = $pdo->prepare($query);

    // Bind the parameters
    $stmt->bindParam(':bname', $bname);
    $stmt->bindParam(':bnum', $bnum);
    $stmt->bindParam(':baddress', $baddress);
    $stmt->bindParam(':bcategory', $bcategory);
    $stmt->bindParam(':user_id', $user_id);

    // Execute the query
    $stmt->execute();

    // If the query is successful
    echo json_encode(['status' => 'success', 'message' => 'Business added successfully.']);
} catch (PDOException $e) {
    // Catch and report any errors
    echo json_encode(['status' => 'error', 'message' => 'Failed to add business: ' . $e->getMessage()]);
}
?>
