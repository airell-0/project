<?php
   $status   = 'success';
   $message  = 'ok';
// $database = json_decode(SQL_Config('sql', database), true);
   $result   = SQL_Execute(
     $database['sql_instance'],
     $database['sql_username'],
     $database['sql_password'],
     $database['sql_database'],
     "SELECT 1 AS [id]"
   );
   $rabbit_exec -> ack();
?>