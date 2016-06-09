class nginx {

  case $::osfamily {
    'redhat', 'debian' : {
      $package  = 'nginx'
      $owner    = 'root'
      $group    = 'root'
      $docroot  = '/var/www'
      $confdir  = '/etc/nginx'
      $logdir   = '/var/log/nginx'
    }
    'windows' : {
      $package  = 'nginx-service'
      $owner    = 'Administrator'
      $group    = 'Administrator'
      $docroot  = 'C:/ProgramData/nginx/html'
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

  File { 
    owner  => $owner,
    group   => $group,
    mode    => '0644'
  }

  package { $package:
    ensure  => present,
  }
  
  file { [$docroot, "${confdir}/conf.d"]:
    ensure  => directory,
  }
  
  file { "${docroot}/index.html":
    ensure  => file,
    source  => 'puppet:///modules/nginx/index.html'
  }
  
  file { "${confdir}/nginx.conf":
    ensure  => file,
    source  => template('nginx/nginx.conf.erb'),
    require => Package[$package],
    notify  => Service['nginx']
  }
  
  file { "${confdir}/conf.d/default.conf":
    ensure  => file,
    source  => template('/nginx/default.conf'),
    require => Package[$package],
    notify  => Service['nginx']
  }
  
  service { 'nginx':
    ensure  => running,
    enable  => true
  }

}
