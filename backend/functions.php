<?php
function filterHtml($requestname) {
    return isset($_POST[$requestname]) ? htmlspecialchars(strip_tags($_POST[$requestname])) : '';
}

define('MB', 1048576); // Constant in uppercase
function UploadImg($imgReq) {
    $msgError = [];

    if (!isset($_FILES[$imgReq]) || $_FILES[$imgReq]['error'] !== UPLOAD_ERR_OK) {
        $msgError[] = "No file uploaded or upload error";
        return 'fail';
    }

    $file = $_FILES[$imgReq];
    $imageName = rand(1000, 10000) . $file['name'];
    $imageTmp = $file['tmp_name'];
    $imgSize = $file['size'];

    $allowExt = ["jpg", "png", "gif", "pdf", "mp3", "jpeg"];
    $ext = strtolower(pathinfo($imageName, PATHINFO_EXTENSION));

    if (!in_array($ext, $allowExt)) {
        $msgError[] = "Invalid file extension";
    }

    if ($imgSize > 2 * 1048576) {
        $msgError[] = "File too large (max 2MB)";
    }

    if (empty($msgError)) {
        // ✅ Correct directory name and full absolute path
        $uploadDir = '../uploads/';
        
        // ✅ Ensure directory exists
        

        $uploadPath = $uploadDir . $imageName;

        if (move_uploaded_file($imageTmp, $uploadPath)) {
            return $imageName;
        } else {
            file_put_contents("debug_log.txt", "Failed to move to: $uploadPath\n", FILE_APPEND);
        }
    }

    return 'fail';
}
function deleteFile($folderPath, $filename) {
    $filePath = $folderPath . $filename;
    if (file_exists($filePath)) {
        unlink($filePath);
    }
}


function checkAuthenticate(){
    if (isset($_SERVER['PHP_AUTH_USER'])  && isset($_SERVER['PHP_AUTH_PW'])) {

        if ($_SERVER['PHP_AUTH_USER'] != "mo" ||  $_SERVER['PHP_AUTH_PW'] != "momo6969"){
            header('WWW-Authenticate: Basic realm="My Realm"');
            header('HTTP/1.0 401 Unauthorized');
            echo 'Page Not Found';
            exit;
        }
    } else {
        exit;
    }
}
?>