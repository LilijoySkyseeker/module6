<?php
header('Content-Type: application/json');

$rawData = file_get_contents("php://input");
$data = json_decode($rawData, true);

// DEBUGGING
error_log("Logout Raw Input: " . $rawData);

if (!isset($data['userID']) || !isset($data['classNumber']) || !isset($data['logoutTime'])) {
    echo json_encode(["success" => false, "message" => "Invalid logout request."]);
    exit();
}

$userID = $data['userID'];
$classNumber = $data['classNumber'];
$logoutTime = $data['logoutTime'];

$servername = "localhost";
$username = "root";  
$password = "";      
$dbname = "Project4_Team7"; 

$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
    die(json_encode(["success" => false, "message" => "Database connection failed."]));
}






//working on
$logoutTime = date('Y-m-d H:i:s');
$sql = "UPDATE Login SET Last_Login = ? WHERE UserID = ? AND ClassID = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("sii", $logoutTime, $userID, $classNumber);

if ($stmt->execute()) {
    echo json_encode(["success" => true, "message" => "Logout successful."]);
} else {
    echo json_encode(["success" => false, "message" => "Logout failed."]);
}

$conn->close();
?>