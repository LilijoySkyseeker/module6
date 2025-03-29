<?php
header('Content-Type: application/json');

$rawData = file_get_contents("php://input");

// DEBUGGING
error_log("Raw Input: " . $rawData);
$data = json_decode($rawData, true);

// DEBUGGING
error_log("Decoded JSON: " . print_r($data, true));

if (!isset($data['userID']) || !isset($data['classNumber'])) {
    echo json_encode(["success" => false, "message" => "Invalid JSON input."]);
    exit();
}

$userID = $data['userID'];
$classNumber = $data['classNumber'];

if (!$userID || !$classNumber) {
    echo json_encode(["success" => false, "message" => "Student ID and Class Number are required."]);
    exit();
}

$servername = "localhost";
$username = "root";  
$password = "";      
$dbname = "Project4_Team7"; 

$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
    die(json_encode(["success" => false, "message" => "Database connection failed."]));
}

$sql = "SELECT Users.UserID FROM Users 
        JOIN Student ON Users.UserID = Student.UserID
        JOIN Classes ON Student.ClassID = Classes.ClassID
        WHERE Users.Username = ? AND Classes.ClassNumber = ?";

$stmt = $conn->prepare($sql);
$stmt->bind_param("si", $userID, $classNumber);
$stmt->execute();
$result = $stmt->get_result();

if ($result->num_rows > 0) {
    echo json_encode(["success" => true, "message" => "Login successful."]);
} else {
    echo json_encode(["success" => false, "message" => "Invalid credentials."]);
}

$conn->close();
?>