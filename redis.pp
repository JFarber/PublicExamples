class profiles::redis (

  $redis_usage  = '0.85',
  $slave_master = "$::state-$::city-$::phrg_env-redis 6379" 
) {

  include redis::install

  if ($::hostname =~ /redis$/) {
    redis::server {
      'master':
        redis_memory => floor($memorysize_mb * 1024 * 1024 * $redis_usage),
        redis_ip     => '0.0.0.0',
        redis_port   => 6379,
        running      => true,
        enabled      => true,
      }
  }

  if ($::hostname =~ /redis\d+$/) {
    redis::server {
      'slave':
        redis_memory => floor($memorysize_mb * 1024 * 1024 * $redis_usage),
        redis_ip     => '0.0.0.0',
        redis_port   => 6379,
        running      => true,
        enabled      => true,
        slaveof      => $slave_master
    }

  }

}
