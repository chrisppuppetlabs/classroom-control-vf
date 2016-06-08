class nginx {

  package { 'nginx':
    ensure  => present,
  }
  
  file { '/var/www':
    ensure  => directory,
    ownner  => 'root',
    group   => 'root',
    mode    => '0755'
  }
  
  file { '/var/www/index.html':
    ensure  => file,
    ownner  => 'root',
    group   => 'root',
    mode    => '0664',
    source  => 'puppet:///modules/nginx/index.html'
  }
  
  file { '/etc/nginx/nginx.conf':
    ensure  => file,
    ownner  => 'root',
    group   => 'root',
    mode    => '0664',
    source  => 'puppet:///modules/nginx/nginx.conf',
    require => Package['nginx'],
    notify  => Service['nginx']
  }
  
  file { '/etc/nginx/conf.d':
    ensure  => directory,
    ownner  => 'root',
    group   => 'root',
    mode    => '0755'
  }
  
  file { '/etc/nginx/conf.d/default.conf':
    ensure  => file,
    ownner  => 'root',
    group   => 'root',
    mode    => '0664',
    source  => 'puppet:///modules/nginx/default.conf',
    require => Package['nginx'],
    notify  => Service['nginx']
  }
  
  service { 'nginx':
    ensure  => running,
    enable  => true
  }

}