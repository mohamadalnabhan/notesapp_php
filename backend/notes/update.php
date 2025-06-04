<?php
include "../connect.php";

$noteid =  filterHtml('id') ;
$title =  filterHtml('title') ;
$content =  filterHtml('content') ;
$imageName =  filterHtml('imageName') ;

// if a file request happened  do this
if(isset($_FILES['file'])){
    deleteFile("../uploads" ,$imageName) ; 
    $imageName = UploadImg('file') ; 

}


    try {
        $stmt = $con->prepare("UPDATE  `notes` SET `note_title` = ?,`note_content` = ?  ,`note_image` = ? WHERE `note_id` = ?   ");
        $stmt->execute(array( $title ,$content ,$imageName,$noteid));
        $data = $stmt->fetch(PDO::FETCH_ASSOC);
        $count =$stmt->rowCount();
        if ($count > 0) {
            echo json_encode(array("status" => "success" ));
        } else {
            echo json_encode(["status" => "failed"]);
        }
    } catch (PDOException $e) {
        echo json_encode(["status" => "error", "message" => $e->getMessage()]);
    }

?>
