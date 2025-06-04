<?php
include "../connect.php";

$title =  filterHtml('title') ;
$content =  filterHtml('content') ;
$userid =  filterHtml('id') ;
$imagename = UploadImg('file');

if($imagename != 'fail'){
    try {
        $stmt = $con->prepare("INSERT INTO  `notes`( `note_title` ,`note_content` ,`note_users`,`note_image`) VALUES(?,?,?,?) ");
        $stmt->execute(array($title, $content, $userid, $imagename));
        $count = $stmt->rowCount();
        if ($count > 0) {
            echo json_encode(["status" => "success"]);
        } else {
            echo json_encode(["status" => "fail"]);
        }
    } catch (PDOException $e) {
        echo json_encode(["status" => "error", "message" => $e->getMessage()]);
    }
} else {
    // ✅ You must respond to avoid Flutter hanging
    echo json_encode(["status" => "fail", "message" => "Image upload failed"]);
}
?>
