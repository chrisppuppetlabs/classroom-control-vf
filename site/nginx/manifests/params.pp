class nginx::params {

  case $::osfamily {
    'redhat', 'debian' : {
      $package  = 'nginx'
      $owner    = 'root'
      $group    = 'root'
      $confdir  = '/etc/nginx'
      $logdir   = '/var/log/nginx'
    }
    'windows' : {
      $package  = 'nginx-service'
      $owner    = 'Administrator'
      $group    = 'Administrator'
      $confdir  = 'C:/ProgramData/nginx'
      $logdir   = 'C:/ProgramData/nginx/logs'
    }
    'default' : {
      fail ("Module ${module_name} is not supported on ${::osfamily}")
    }
  }
  
  $user = $::osfamily ? {
    'redhat'  => 'nginx',
    'debian'  => 'www-data',
    'windows' => 'nobody'
  }

}
