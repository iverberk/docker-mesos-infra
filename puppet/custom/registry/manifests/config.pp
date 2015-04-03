class registry::config {

  file { '/etc/registry.conf':
    ensure => present,
    owner => root,
    group => root,
    mode => 750,
    content => template('registry/registry.conf.erb'),
  } ->

  file { '/opt/registry':
    ensure => directory,
    owner => root,
    group => root,
    mode => 750,
  } ->

  # Create data container
  docker::run { 'registry-data':
    image           => 'registry',
    command         => 'true',
    use_name        => true,
    volumes         => ['/opt/registry', '/opt/registry'],
    restart_service => false,
    privileged      => false,
    pull_on_start   => false,
  }

}