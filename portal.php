<?php
  header('Access-Control-Allow-Origin: *');
  header('Access-Control-Allow-Headers: *');
  header('Content-Type: application/json; charset=utf-8');
  header('Cache-Control: no-cache, no-store, must-revalidate');
  header('Expires: Sat, 1 Sep 1990 00:00:00 GMT');
  header('Pragma: no-cache');
  ini_set('display_errors', 1);
  date_default_timezone_set("Asia/Jakarta");
  try {
    require_once __DIR__ .'/assets/vendor/autoload.php';
    require_once __DIR__ .'/assets/command.php';
    $client = json_decode(Http_Message(), true);
    $portal_time = (string) date('Y-m-d h:i:s', $client['head']['Request-Time']);
    $portal_apps = @$client['link']['apps'];
    $portal_menu = @$client['link']['menu'];
    $portal_mode = @$client['link']['mode'];
    $portal_post = @$client['post'];
    $out["status"]  = 'success';
    $out["time"]    = $portal_time;
    $out["action"]  = $portal_apps ." ". $portal_menu ." ". $portal_mode;
    $out["message"] = 'ok';
    echo json_encode((object) array_filter($out));
  } catch(Exception $e){
    $out["status"]  = 'error';
    $out["message"] = $e -> getMessage();
    echo json_encode((object) array_filter($out));
  }
?>