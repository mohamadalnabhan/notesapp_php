<?php
// Include files from same directory
include 'connect.php';


// Example usage
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    if (isset($_FILES['myfile'])) {
        $uploadResult = UploadImg('myfile');
        if ($uploadResult) {
            echo "File uploaded successfully: " . $uploadResult;
        } else {
            echo "Errors:<br>";
            print_r($msgError);
        }
    }
}
?>

