class nginx (
  $package  = $nginx::params::package,
  $owner    = $nginx::params::owner,
  $group    = $nginx::params::group,
  $docroot,
  $confdir  = $nginx::params::confdir,
  $logdir   = $nginx::params::logdir,
  $user     = $nginx::params::user,
) inherits nginx::params {

  File { 
    owner  => $owner,
    group   => $group,
    mode    => '0644'
  }

  package { $package:
    ensure  => present,
  }
  
  file { ["$docroot/vhosts", "${confdir}/conf.d"]:
    ensure  => directory,
  }
  
  nginx::vhost { 'default':
    docroot    => $docroot,
    servername => $::fqdn
  }
  
  file { "${confdir}/nginx.conf":
    ensure  => file,
    content  => template('nginx/nginx.conf.erb'),
    require => Package[$package],
    notify  => Service['nginx']
  }
  
  service { 'nginx':
    ensure  => running,
    enable  => true
  }

}
