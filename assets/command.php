<?php
  function Form_Message($text, $limit = 0){
    $text = str_ireplace('[Microsoft]','', $text);
    $text = str_ireplace('[SQL Server]','', $text);
    $text = str_ireplace('[ODBC Driver 17 for SQL Server]','', $text);
    $text = preg_replace('/\s+/',' ', preg_replace("/(\r\n|\r|\n|\t)+/", ' ', $text));
    $text = strip_tags(@htmlspecialchars($text), ENT_QUOTES);
    $text = stripslashes(trim(ltrim(rtrim($text))));
    $text = str_ireplace('"','', str_ireplace("'",'', $text));
    if ($limit > 0){
      if (strlen($text) < $limit){
        $text = $text;
      } else {
        $text = substr($text, 0, $limit);
      }
    } else {
      $text = $text;
    }
    return $text;
  }
  function Form_Encryp($text, $key_enc, $viv_enc){
    try {
      return @openssl_encrypt($text, 'AES-128-CTR', $key_enc, 0, $viv_enc);
    } catch(Exception $e){
      return $text;
    }
  }
  function Form_Decryp($text, $key_enc, $viv_enc){
    try {
      return @openssl_decrypt($text, 'AES-128-CTR', $key_enc, 0, $viv_enc);
    } catch(Exception $e){
      return $text;
    }
  }
  function Http_Message(){
    foreach ($_SERVER as $name => $value){
      if ($name == 'HTTP_USER_AGENT'){
        $http_head['User-Agent']     = Form_Message($value);
      } else if ($name == 'CONTENT_TYPE'){
        $http_head['Content-Type']   = Form_Message($value);
      } else if ($name == 'CONTENT_LENGTH'){
        $http_head['Content-Length'] = Form_Message($value);
      } else if ($name == 'REQUEST_METHOD'){
        $http_head['Request-Method'] = Form_Message($value);
      } else if ($name == 'REQUEST_TIME'){
        $http_head['Request-Time']   = Form_Message($value);
      }
    }
    $http['head'] = $http_head;
    $http['link'] = @$_GET;
    $http['post'] = @$_POST;
    $http['body'] = json_decode(file_get_contents('php://input'), true);
    $http['lock'] = @$_SESSION;
    return (json_encode((object) array_filter((array) $http)));
  }
  function SQL_Config($var_init, $config_id){
    try {
      $elastic_ping = Elastic\Elasticsearch\ClientBuilder::create()
        -> setHosts([ elastic_host .':'. elastic_port ])
        -> build();
      $elastic_text = [
        'index' => 'service_dat',
        'id'    => $config_id
      ];
      $elastic_exec = $elastic_ping -> get($elastic_text) -> getBody();
      $elastic_exec = ((array) json_decode($elastic_exec, true));
      $base[$var_init .'_instance'] = @$elastic_exec['_source']['instance'];
      $base[$var_init .'_database'] = @$elastic_exec['_source']['database'];
      $base[$var_init .'_username'] = @$elastic_exec['_source']['username'];
      $base[$var_init .'_password'] = @$elastic_exec['_source']['password'];
      return json_encode((object) array_filter((array) $base));
    } catch(Exception $e){
      echo date('Y-m-d H:i:s') .'  '. Form_Message($e -> getMessage()) ."\r\n";
    }
  }
  function SQL_Execute($host, $user, $pass, $data, $exec){
    try {
      $ping  = array('Database' => $data, 'UID' => $user, 'PWD' => $pass);
      $ping  = sqlsrv_connect($host, $ping);
      $info  = '';
      $error = '';
      if(!$ping){
        if (($text = sqlsrv_errors()) != null){
          foreach($text as $expt){
            $error .= ', '. $expt['code'] .' - '. Form_Message($expt['message']);
          }
        }
      } else {
        $query = sqlsrv_query($ping, $exec);
        if($query === false){
          if (($text = sqlsrv_errors()) != null){
            foreach($text as $expt){
              if ($expt['code'] == 0){
                $info  .= ', '. Form_Message($expt['message']);
              } else {
                $error .= ', '. $expt['code'] .' - '. Form_Message($expt['message']);
              }
            }
          }
        } else {
          $table = 1;
          if (($text = sqlsrv_errors()) != null){
            foreach($text as $expt){
              if ($expt['code'] == 0){
                $info  .= ', '. Form_Message($expt['message']);
              } else {
                $error .= ', '. $expt['code'] .' - '. Form_Message($expt['message']);
              }
            }
          }
          do {
            while($loop = sqlsrv_fetch_array($query, SQLSRV_FETCH_ASSOC)){
              $base['data']['d_'. $table][] = $loop;
            }
            $table += 1;
          } while (sqlsrv_next_result($query));
          sqlsrv_free_stmt($query);
        }
        sqlsrv_close($ping);
      }
      if ($error != ''){
        $error = str_replace('E, ','E : ', 'E'. $error);
        $base['status']  = 'error';
        $base['message'] = $error;
      }
      if ($info != ''){
        $info = str_replace('|, ','', '|'. $info);
        $base['status']  = 'success';
        $base['message'] = $info;
        if ($error != ''){
          $base['status']  = 'warning';
          $base['message'] = $info .' '. $error;
        }
      }
      if ($info .' '. $error == ' '){
        $base['status']  = 'success';
        $base['message'] = 'Process Success';
      }
      return json_encode((object) array_filter((array) $base));
    } catch(Exception $e){
      $base['status']  = 'error';
      $base['message'] = Form_Message($e -> getMessage());
      return json_encode((object) array_filter((array) $base));
    }
  }
?>