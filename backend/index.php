<?php  

include "connect.php" ; 
$stmt = $con->prepare(" DELETE FROM  `users` WHERE  username = :us ");

$stmt->execute(array(':us'=>"mo1" ));
$count= $stmt ->rowCount();

if($count > 0){
    echo " delete data success";
}else{
    echo "it fails" ;
}

 ?>