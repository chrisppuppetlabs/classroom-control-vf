class skeleton {

  file { '/etc/skel':
    ennsure => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '0755'
  }
  
  file { '/etc/skel/.bashrc':
    ennsure => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => 'puppet:///modules/skeleton/bashrc'
  }
}
