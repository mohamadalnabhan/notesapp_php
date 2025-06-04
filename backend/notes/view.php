<?php
include "../connect.php";

// fix: use filter_input OR properly access 
$id =  filterHtml("id") ; 

try {
    $stmt = $con->prepare("SELECT * FROM `notes` WHERE `note_users` = ?");
    $stmt->execute([$id]);
    $data = $stmt->fetchAll(PDO::FETCH_ASSOC);
    $count = $stmt->rowCount();

    if ($count > 0) {
        echo json_encode(["status" => "success", "data" => $data]);
    } else {
        echo json_encode(["status" => "failed", "data" => []]);
    }
} catch (PDOException $e) {
    echo json_encode(["status" => "error", "message" => $e->getMessage()]);
}
?>
