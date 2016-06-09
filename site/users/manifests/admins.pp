class users::admins {
  users::managed_user { ['joe', 'alice', 'chen']:
    group =>  'managedusers'
  }
  group { 'managedusers':
    ensure  => present
  }
}
