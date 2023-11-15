<?php
  header('Access-Control-Allow-Origin: *');
  header('Access-Control-Allow-Headers: *');
  header('Access-Control-Allow-Methods: GET, POST');
  header('Content-Type: application/json; charset=utf-8');
  header('Cache-Control: no-cache, no-store, must-revalidate');
  header('Expires: Sat, 1 Sep 1990 00:00:00 GMT');
  header('Pragma: no-cache');
  ini_set('display_errors', 0);
  date_default_timezone_set("Asia/Jakarta");
//> Configuration Request
  try {
    require_once __DIR__ .'/assets/vendor/autoload.php';
    require_once __DIR__ .'/assets/command.php';
    $config       = json_decode(@file_get_contents(__DIR__ .'/elastic.json'), false);
    $client       = json_decode(Http_Message(), true);
    $company      = @$client['link']['company']; // Company
    $engines      = @$client['link']['engines']; // Application
    $cluster      = @$client['link']['cluster']; // Module
    $console      = @$client['link']['console']; // Sub-Module
    $command      = @$client['link']['command']; // Function
    $logical      = @$client['link']['logical']; // Async | Sync
    $process      = @$client['link']['process']; // Process_Id
    $request      = '';
    $response     = '';
    $exchange     = $company;
    $service      = $company .'_'. $engines;
    $elastic_host = $config -> elastic_host;
    $elastic_port = $config -> elastic_port;
//> Validate Param GET
    if (count((array) @$client['post']) > 0){
      $request = json_encode((object) array_filter($client['post']));
    }
    if (count((array) @$client['body']) > 0){
      $request = json_encode((object) array_filter($client['body']));
    }
    if ($company == ''){
      $out["status"]  = 'warning';
      $out["message"] = 'Company Not Found!';
    } else
    if ($engines == ''){
      $out["status"]  = 'warning';
      $out["message"] = 'Engines Not Found!';
    } else
    if ($command == ''){
      $out["status"]  = 'warning';
      $out["message"] = 'Command Not Found!';
    } else
    if ($process == '' && $request == ''){
      $out["status"]  = 'warning';
      $out["message"] = 'Parameter Not Found!';
    } else {
      if ($cluster != ''){
        $exchange .= '_'. $engines;
        $service  .= '_'. $cluster;
      }
      if ($console != ''){
        $service  .= '_'. $console;
      }
      if ($logical == ''){
        $logical = '1';
      }
//>== Connect To Config Hub
      try {
        $elastic_ping = Elastic\Elasticsearch\ClientBuilder::create()
          -> setHosts([ $elastic_host .':'. $elastic_port ])
          -> build();
        $elastic_info = $elastic_ping -> info() -> getBody();
        $elastic_info = ((array) json_decode($elastic_info, true));
        $elastic_info = $elastic_info['version']['number'];
//>==== Check Microservice Status
        try {
          $elastic_text = [
            'index' => 'service_app',
            'id'    => $service
          ];
          $elastic_exec = $elastic_ping -> get($elastic_text) -> getBody();
          $elastic_exec = ((array) json_decode($elastic_exec, true));
          if ($elastic_exec['_source']['status'] == 'active'){
//>======== Check Config Microservice
            try {
              $elastic_text = [
                'index' => 'service_hub',
                'id'    => $company
              ];
              $elastic_exec   = $elastic_ping -> get($elastic_text) -> getBody();
              $elastic_exec   = ((array) json_decode($elastic_exec, true));
              $redis_host     = $elastic_exec['_source']['redis_host'];
              $redis_port     = $elastic_exec['_source']['redis_port'];
              $redis_index    = $elastic_exec['_source']['redis_index'];
              $redis_ttl      = $elastic_exec['_source']['redis_ttl'];
              $rabbit_host    = $elastic_exec['_source']['rabbit_host'];
              $rabbit_port    = $elastic_exec['_source']['rabbit_port'];
              $rabbit_user    = $elastic_exec['_source']['rabbit_username'];
              $rabbit_pass    = $elastic_exec['_source']['rabbit_password'];
              $rabbit_virtual = $elastic_exec['_source']['rabbit_virtual'];
//==========> Connect To Response Hub
              try {
                $redis_ping  = RedisClient\ClientFactory::create([
                  'server'   => $redis_host .':'. $redis_port,
                  'database' => $redis_index
                ]);
                $redis_info  = ((array) $redis_ping -> info())['Server']['redis_version'];
//>============ Get Process Data For Logical Async or Rollback Connection
                if ($process != ''){
                  $out["process"] = $process;
                  $redis_exec = $redis_ping -> pipeline();
                  $redis_exec -> get($process)
                              -> del($process);
                  $responses  = $redis_ping -> pipeline($redis_exec)[0];
                  if ($responses == null){
                    try {
                      $elastic_text = [
                        'index' => 'service_log',
                        'id'    => $process
                      ];
                      $elastic_exec   = $elastic_ping -> get($elastic_text) -> getBody();
                      $elastic_exec   = ((array) json_decode($elastic_exec, true));
                      $response       = ((array) json_decode($elastic_exec['_source']['response'], true));
                      $out["status"]  = 'info';
                      $out["message"] = 'No Message';
                      if (@$response['status'] != ''){
                        $out["status"] = $response['status'];
                      }
                      if (@$response['message'] != ''){
                        $out["message"] = $response['message'];
                      }
                      $out["data"] = @$response['data'];
                      $elastic_text = [
                        'index' => 'service_log',
                        'id'    => $process,
                        'body'  => [
                          'doc' => [
                            'locked'        => 'close',
                            'time_complete' => date('Y-m-d H:i:s')
                          ]
                        ]
                      ];
                      $elastic_exec = $elastic_ping -> update($elastic_text);
                    } catch(Exception $e){
                      $out["status"]  = 'error';
                      $out["message"] = 'Process Id Not Found';
                    }
                  } else {
                    $response       = ((array) json_decode($responses, true));
                    $out["status"]  = 'info';
                    $out["message"] = 'No Message';
                    if (@$response['status'] != ''){
                      $out["status"] = $response['status'];
                    }
                    if (@$response['message'] != ''){
                      $out["message"] = $response['message'];
                    }
                    $out["data"] = @$response['data'];
                    try {
                      $elastic_text = [
                        'index' => 'service_log',
                        'id'    => $process,
                        'body'  => [
                          'doc' => [
                            'locked'        => 'close',
                            'time_complete' => date('Y-m-d H:i:s')
                          ]
                        ]
                      ];
                      $elastic_exec = $elastic_ping -> update($elastic_text);
                    } catch(Exception $e){ }
                  }
                } else {
//>============== Message Broker
                  try {
                    putenv('AMQP_DEBUG=0');
                    $rabbit_conf  = new PhpAmqpLib\Connection\AMQPStreamConnection(
                      $rabbit_host,
                      $rabbit_port,
                      $rabbit_user,
                      $rabbit_pass,
                      $rabbit_virtual
                    );
                    $rabbit_ping = $rabbit_conf -> channel();
                    $rabbit_info = $rabbit_ping -> getConnection() -> getServerProperties()['version'][1];
                    $process     = date('Ymd') . $redis_index;
                    $redis_exec  = $redis_ping -> pipeline();
                    $redis_exec -> incr($process)
                                ->  get($process)
                                ->  del(date('Ymd', strtotime("-2 days")) . $redis_index);
                    $process    .= '_'. $redis_ping -> pipeline($redis_exec)[1];
                    $requests['process'] = ''. $process;
                    $requests['logical'] = ''. $logical;
                    $requests['command'] = ''. $command;
                    $requests['request'] = ((array) json_decode($request));
                    $request = json_encode((object) array_filter($requests));
//>================ Parsing Data
                    try {
                      $elastic_text = [
                        'index' => 'service_log',
                        'id'    => $process,
                        'body'  => [
                          'company'       => $company,
                          'engines'       => $engines,
                          'logical'       => $logical,
                          'command'       => $command,
                          'service'       => $service,
                          'status'        => 'success',
                          'locked'        => 'open',
                          'message'       => 'Send Message Success',
                          'time_create'   => date('Y-m-d H:i:s'),
                          'time_process'  => date('Y-m-d H:i:s'),
                          'time_response' => '1900-01-01 00:00:00',
                          'time_complete' => '1900-01-01 00:00:00',
                          'request'       => $request,
                          'response'      => ''
                        ]
                      ];
                      $elastic_exec = $elastic_ping -> index($elastic_text);
                      $rabbit_ping -> queue_declare(
                        $service,  // name : $queue
                        false,     // passive
                        true,      // durable     : the queue * survive server restarts
                        false,     // exclusive   : the queue * be accessed in other channels
                        false      // auto_delete : the queue * be deleted once the channel is closed.
                      );
                      $rabbit_ping -> exchange_declare(
                        $exchange, // name : $exchange
                        PhpAmqpLib\Exchange\AMQPExchangeType::DIRECT,
                        false,     // passive
                        true,      // durable     : the exchange * survive server restarts
                        false      // auto_delete : the queue * be deleted once the channel is closed.
                      );
                      $rabbit_ping -> queue_bind($service, $exchange);
                      $rabbit_exec  = new PhpAmqpLib\Message\AMQPMessage(
                        $request,
                        array(
                          'content_type'  => 'application/json',
                          'delivery_mode' => PhpAmqpLib\Message\AMQPMessage::DELIVERY_MODE_PERSISTENT
                        )
                      );
                      $rabbit_ping -> basic_publish($rabbit_exec, $exchange);
                      $rabbit_ping -> close();
                      $rabbit_conf -> close();
//>================== Response To Client
                      if ($logical == '0'){
                        $out["process"] = $process;
                        $out["status"]  = 'success';
                        $out["message"] = 'Send Message Success';
                      } else {
//>==================== Get Response When Sync
                        $response = null;
                        set_time_limit(120);
                        while ($response === NULL){
                          sleep(5);
                          $out["process"] = $process;
                          $redis_exec = $redis_ping -> pipeline();
                          $redis_exec -> get($process)
                                      -> del($process);
                          $responses  = $redis_ping -> pipeline($redis_exec)[0];
                          if ($responses == null){
                            try {
                              $elastic_text = [
                                'index' => 'service_log',
                                'id'    => $process
                              ];
                              $elastic_exec = $elastic_ping -> get($elastic_text) -> getBody();
                              $elastic_exec = ((array) json_decode($elastic_exec, true));
                              if (@$elastic_exec['_source']['response'] != ''){
                                $response       = ((array) json_decode($elastic_exec['_source']['response'], true));
                                $out["status"]  = 'info';
                                $out["message"] = 'No Message';
                                if (@$response['status'] != ''){
                                  $out["status"] = $response['status'];
                                }
                                if (@$response['message'] != ''){
                                  $out["message"] = $response['message'];
                                }
                                $out["data"]  = @$response['data'];
                                $elastic_text = [
                                  'index' => 'service_log',
                                  'id'    => $process,
                                  'body'  => [
                                    'doc' => [
                                      'locked'        => 'close',
                                      'time_complete' => date('Y-m-d H:i:s')
                                    ]
                                  ]
                                ];
                                $elastic_exec = $elastic_ping -> update($elastic_text);
                              }
                            } catch(Exception $e){
                              $response = null;
                            }
                          } else {
                            $response       = ((array) json_decode($responses, true));
                            $out["status"]  = 'info';
                            $out["message"] = 'No Message';
                            if (@$response['status'] != ''){
                              $out["status"] = $response['status'];
                            }
                            if (@$response['message'] != ''){
                              $out["message"] = $response['message'];
                            }
                            $out["data"] = @$response['data'];
                            try {
                              $elastic_text = [
                                'index' => 'service_log',
                                'id'    => $process,
                                'body'  => [
                                  'doc' => [
                                    'locked'        => 'close',
                                    'time_complete' => date('Y-m-d H:i:s')
                                  ]
                                ]
                              ];
                              $elastic_exec = $elastic_ping -> update($elastic_text);
                            } catch(Exception $e){ }
                          }
                        }
                      }
                    } catch(Exception $e){
                      $elastic_text = [
                        'index' => 'service_log',
                        'id'    => $process,
                        'body'  => [
                          'company'       => $company,
                          'engines'       => $engines,
                          'logical'       => $logical,
                          'command'       => $command,
                          'service'       => $service,
                          'status'        => 'error',
                          'locked'        => 'close',
                          'message'       => 'Failed Send Data',
                          'time_create'   => date('Y-m-d H:i:s'),
                          'time_process'  => '1900-01-01 00:00:00',
                          'time_response' => '1900-01-01 00:00:00',
                          'time_complete' => '1900-01-01 00:00:00',
                          'request'       => $request,
                          'response'      => ''
                        ]
                      ];
                      $elastic_exec = $elastic_ping -> index($elastic_text);
                      $out["process"] = $process;
                      $out["status"]  = 'error';
                      $out["message"] = 'Failed Send Data';
                    }
                  } catch(Exception $e){
                    $out["status"]  = 'error';
                    $out["message"] = 'Cannot Connect To Message Broker';
                  }
                }
              } catch(Exception $e){
                $out["status"]  = 'error';
                $out["message"] = 'Cannot Connect To Response Hub';
              }
            } catch(Exception $e){
              $out["status"]  = 'warning';
              $out["message"] = 'Configuration Service '. $company .' Not Found';
            }
          } else {
            $out["status"]  = 'warning';
            $out["message"] = 'Service '. $service .' '. $elastic_exec['_source']['status'];
          }
        } catch(Exception $e){
          $out["status"]  = 'error';
          $out["message"] = 'Service '. $service .' Deactive or Not Registered!';
        }
      } catch(Exception $e){
        $out["status"]  = 'error';
        $out["message"] = 'Cannot Connect To Configuration Server';
      }
    }
  } catch(Exception $e){
    $out["status"]  = 'error';
    $out["message"] = Form_Message($e -> getMessage());
  }
  echo json_encode((object) array_filter($out));
?>