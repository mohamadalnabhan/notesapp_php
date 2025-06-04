<?php
$config = include 'config.php';

$dsn = "mysql:host={$config['DB_HOST']};dbname={$config['DB_NAME']}";
$user = $config['DB_USER'];
$pass = $config['DB_PASS'];

$option = [PDO::MYSQL_ATTR_INIT_COMMAND => "SET NAMES UTF8"];

try {
    $con = new PDO($dsn, $user, $pass, $option);
    $con->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    include "functions.php";

    header("Access-Control-Allow-Origin: *");
    header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With, Access-Control-Allow-Origin");
    header("Access-Control-Allow-Methods: POST, OPTIONS, GET");

    checkAuthenticate();

} catch (PDOException $e) {
    echo json_encode(["status" => "error", "message" => $e->getMessage()]);
}
