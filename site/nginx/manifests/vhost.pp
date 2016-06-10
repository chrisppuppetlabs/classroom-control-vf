define nginx::vhost (
  $port         = '80',
  $servername   = $title,
  $docroot      = "${nginx::docroot}/vhost/${title}"
) {

  File { 
    owner  => $nginx::owner,
    group   => $nginx::group,
    mode    => '0644'
  }
  
  host { $title:
    ip  => $::upaddress,
  }
  

  file { "${docroot}/index.html":
    ensure  => file,
    content  => template('nginx/index.html.erb')
  }
  
  file { "nginx-vhost-${title}":
    ensure  => file,
    path    => "${nginx::confdir}/conf.d/${title}.conf",
    content => template('nginx/vhost.conf.erb'),
    notify  => Service['nginx']
  }
  
  file { $docroot:
    ensure => directory,
    before => File["nginx-vhost-${title}"]
  }
  
  service { 'nginx':
    ensure  => running,
    enable  => true
  }

}
