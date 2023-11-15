<?php
  date_default_timezone_set("Asia/Jakarta");
  try {
//> Configure Service
    require_once __DIR__ .'/assets/vendor/autoload.php';
    require_once __DIR__ .'/assets/command.php';
    $config = json_decode(@file_get_contents(__DIR__ .'/elastic.json'), false);
    define('company', getenv('company') ? getenv('company') : 'dev');
    define('engines', getenv('engines') ? getenv('engines') : 'portal');
    define('cluster', getenv('cluster') ? getenv('cluster') : '');
    define('console', getenv('console') ? getenv('console') : '');
    $exchange = company;
    $service  = company .'_'. engines;
    $location = 'service/'. company .'/'. engines;
    if (cluster != ''){
      $exchange .= '_'. engines;
      $service  .= '_'. cluster;
      $location .= '/'. cluster;
    }
    if (console != ''){
      $service  .= '_'. console;
      $location .= '/'. console;
    }
    define('database', company .'_'. engines);
    define('exchange', $exchange);
    define('service',  $service);
    define('location', $location);
//> Connect To Config Hub
    define('elastic_host', $config -> elastic_host);
    define('elastic_port', $config -> elastic_port);
    $elastic_ping = Elastic\Elasticsearch\ClientBuilder::create()
      -> setHosts([ elastic_host .':'. elastic_port ])
      -> build();
//> Confirm Service Status
    try {
      $elastic_text = [
        'index' => 'service_app',
        'id'    => service,
        'body'  => [
          'doc' => [
            'status'    => 'active',
            'message'   => 'ok',
            'time_open' => date('Y-m-d H:i:s'),
            'last_exec' => date('Y-m-d H:i:s')
          ]
        ]
      ];
      $elastic_exec = $elastic_ping -> update($elastic_text);
    } catch(Exception $e){
      $elastic_text = [
        'index' => 'service_app',
        'id'    => service,
        'body'  => [
          'status'    => 'active',
          'message'   => 'ok',
          'time_open' => date('Y-m-d H:i:s'),
          'last_exec' => date('Y-m-d H:i:s')
        ]
      ];
      $elastic_exec = $elastic_ping -> index($elastic_text);
    }
//> Config Link Service
    try {
      $elastic_text = [
        'index' => 'service_hub',
        'id'    => company
      ];
      $elastic_exec = $elastic_ping -> get($elastic_text) -> getBody();
      $elastic_exec = ((array) json_decode($elastic_exec, true));
      define('redis_host',     $elastic_exec['_source']['redis_host']);
      define('redis_port',     $elastic_exec['_source']['redis_port']);
      define('redis_index',    $elastic_exec['_source']['redis_index']);
      define('redis_ttl',      $elastic_exec['_source']['redis_ttl']);
      define('rabbit_host',    $elastic_exec['_source']['rabbit_host']);
      define('rabbit_port',    $elastic_exec['_source']['rabbit_port']);
      define('rabbit_user',    $elastic_exec['_source']['rabbit_username']);
      define('rabbit_pass',    $elastic_exec['_source']['rabbit_password']);
      define('rabbit_virtual', $elastic_exec['_source']['rabbit_virtual']);
//==> Connect To Receptor Hub
      try {
        $redis_ping  = RedisClient\ClientFactory::create([
          'server'   => redis_host .':'. redis_port,
          'database' => redis_index
        ]);
//====> Connect To Message Broker
        try {
          putenv('AMQP_DEBUG=0');
          $rabbit_conf  = new PhpAmqpLib\Connection\AMQPStreamConnection(
            rabbit_host,
            rabbit_port,
            rabbit_user,
            rabbit_pass,
            rabbit_virtual
          );
//>====== Setup Message Broker
          $rabbit_ping = $rabbit_conf -> channel();
          $rabbit_ping -> queue_declare(
            service,  // name : $queue
            false,    // passive
            true,     // durable     : the queue * survive server restarts
            false,    // exclusive   : the queue * be accessed in other channels
            false     // auto_delete : the queue * be deleted once the channel is closed.
          );
          $rabbit_ping -> exchange_declare(
            exchange, // name : $exchange
            PhpAmqpLib\Exchange\AMQPExchangeType::DIRECT,
            false,    // passive
            true,     // durable     : the exchange * survive server restarts
            false     // auto_delete : the queue * be deleted once the channel is closed.
          );
          $rabbit_ping -> queue_bind(service, exchange);
          $rabbit_heat = 0;
//>====== Read Data From Message Broker
          function rabbit_read($rabbit_exec){
            global $elastic_ping, $redis_ping, $rabbit_heat;
            $requests = ((array) json_decode($rabbit_exec -> body));
            $process  = @$requests['process'];
            $logical  = @$requests['logical'];
            $command  = @$requests['command'];
            $request  = @$requests['request'];
            echo "# ". $process . PHP_EOL;
//>======== Check Command File
            if (file_exists(__DIR__ .'/'. location .'/'. $command .'.php')){
              try {
                try {
                  $status   = '';
                  $message  = '';
                  $database = json_decode(SQL_Config('sql', database), true);
//>============== Call Function File
                  try {
                    include(__DIR__ .'/'. location .'/'. $command .'.php');
                  } catch(Exception $e){
                    echo date('Y-m-d H:i:s') .'  '. $process . PHP_EOL;
                    echo "   ". Form_Message($e -> getMessage()) . PHP_EOL;
                  }
                  if (@$status != ''){
                    $results = ((array) json_decode($result, true));
                    $responses['status']  = $status;
                    $responses['message'] = $message;
                    if (@$results['status'] != ''){
                      $responses['status'] = $results['status'];
                    }
                    if (@$results['message'] != ''){
                      $responses['message'] = $results['message'];
                    }
                    $responses['data'] = @$results['data'];
                    $response = json_encode((object) array_filter($responses));
                  } else {
                    $responses['status']  = 'error';
                    $responses['message'] = 'Response Wihout Status';
                    $response = json_encode((object) array_filter($responses));
                  }
                } catch(Exception $e){
                  $status  = 'error';
                  $message = 'service error';
                  $responses['message'] = $message;
                  $responses['status']  = $status;
                  $response = json_encode((object) array_filter($responses));
                  echo date('Y-m-d H:i:s') .'  '. $process . PHP_EOL;
                  echo "   ". Form_Message($e -> getMessage()) . PHP_EOL;
                }
//>============ Save Response To Log Server
                if ($response != ''){
                  $elastic_text = [
                    'index' => 'service_log',
                    'id'    => $process,
                    'body'  => [
                      'doc' => [
                        'service'       => service,
                        'status'        => $status,
                        'message'       => $message,
                        'time_response' => date('Y-m-d H:i:s'),
                        'response'      => $response
                      ]
                    ]
                  ];
                  $elastic_exec = $elastic_ping -> update($elastic_text);
                  $redis_ping  -> set($process, $response);
                }
              } catch(Exception $e){
                echo date('Y-m-d H:i:s') .'  '. $process . PHP_EOL;
                echo "   ". Form_Message($e -> getMessage()) . PHP_EOL;
              }
            } else {
//>========== Flag For Disable Service if Not Found
              $response['status']  = 'error';
              $response['message'] = 'Service Not Found '. service .'_'. $command;
              $rabbit_heat += 1;
              $elastic_text = [
                'index' => 'service_app',
                'id'    => service,
                'body'  => [
                  'doc' => [
                    'message'   => 'Service Not Found '. location .'/'. $command,
                    'last_exec' => date('Y-m-d H:i:s')
                  ]
                ]
              ];
              $elastic_exec = $elastic_ping -> update($elastic_text);
              $elastic_text = [
                'index' => 'service_log',
                'id'    => $process,
                'body'  => [
                  'doc' => [
                    'service'       => service,
                    'status'        => $response['message'],
                    'time_response' => date('Y-m-d H:i:s'),
                    'response'      => json_encode((object) array_filter($response))
                  ]
                ]
              ];
              $elastic_exec = $elastic_ping -> update($elastic_text);
              $redis_ping  -> set($process, json_encode((object) array_filter($response)));
              echo 'Service Not Found : '. location .'/'. $command . PHP_EOL;
            }
//>======== Disable Service If Flag Heat Beat 50
            if ($rabbit_heat > 50){
              $elastic_text = [
                'index' => 'service_app',
                'id'    => service,
                'body'  => [
                  'doc' => [
                    'status'    => 'disabled',
                    'message'   => 'Overheat 50 Error Ping',
                    'last_exec' => date('Y-m-d H:i:s')
                  ]
                ]
              ];
              $elastic_exec = $elastic_ping -> update($elastic_text);
              $rabbit_exec -> getChannel() -> basic_cancel($rabbit_exec -> getConsumerTag());
            }
          }
//>====== Setup Message Broker - Stop and Consume
          $rabbit_ping -> basic_consume(
            service,       // queue        : Queue from where to get the messages
            'rabbit_exec', // consumer_tag : Consumer identifier
            false,         // no_local     : * receive messages published by this consumer.
            false,         // no_ack       : * automatic acknowledgement mode
            false,         // exclusive    : only this consumer can access the queue
            false,         // nowait       :
            'rabbit_read'
          );
          function rabbit_stop($rabbit_ping, $rabbit_conf){
            $rabbit_ping -> close();
            $rabbit_conf -> close();
          }
          register_shutdown_function('rabbit_stop', $rabbit_ping, $rabbit_conf);
          while ($rabbit_ping -> is_consuming()){
            $rabbit_ping -> wait();
          }
        } catch(Exception $e){
          echo date('Y-m-d H:i:s') .'  '. Form_Message($e -> getMessage()) . PHP_EOL;
        }
      } catch(Exception $e){
        echo date('Y-m-d H:i:s') .'  '. Form_Message($e -> getMessage()) . PHP_EOL;
      }
    } catch(Exception $e){
      echo date('Y-m-d H:i:s') .'  '. Form_Message($e -> getMessage()) . PHP_EOL;
    }
  } catch(Exception $e){ }
?>