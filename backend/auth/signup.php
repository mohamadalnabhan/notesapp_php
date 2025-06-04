<?php
include "../connect.php";



$username =  filterHtml('username') ;
$email    =  filterHtml('email') ;
$password = filterHtml('password');

    try {
        $stmt = $con->prepare("INSERT INTO `users` (`username`, `email`, `password`) VALUES (?, ?, ?)");
        $stmt->execute(array($username, $email, $password));
        $count =$stmt->rowCount();
        if ($count > 0) {
            echo json_encode(["status" => "success"]);
        } else {
            echo json_encode(["status" => "failed"]);
        }
    } catch (PDOException $e) {
        echo json_encode(["status" => "error", "message" => $e->getMessage()]);
    }

?>
