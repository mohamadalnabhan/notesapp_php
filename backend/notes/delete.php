<?php
include "../connect.php";




$noteid =  filterHtml('id') ;
$imageName = filterHtml('imageName') ;
    try {
        $stmt = $con->prepare("DELETE FROM  `notes` WHERE `note_id` = ? ");
        $stmt->execute(array($noteid));
        $data = $stmt->fetch(PDO::FETCH_ASSOC);
        $count =$stmt->rowCount();
        if ($count > 0) {
            deleteFile("../uploads/" ,$imageName) ; 
            echo json_encode(array("status" => "success" ));
        } else {
            echo json_encode(["status" => "failed"]);
        }
    } catch (PDOException $e) {
        echo json_encode(["status" => "error", "message" => $e->getMessage()]);
    }

?>
