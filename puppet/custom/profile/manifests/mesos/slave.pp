class profile::mesos::slave (
  $nfs_server = false,
  $nfs_server_ip = '192.168.33.14'
) {
  
  include profile::mesos::base
  
  class { '::mesos::slave':
    env_var => {
      'MESOS_LOG_DIR' => '/var/log/mesos',
    },
  } ->

  file { '/etc/mesos-slave/containerizers':
    ensure => present,
    owner => root,
    group => root,
    mode => 0755,
    content => 'docker,mesos'
  } ->

  file { '/etc/mesos-slave/executor_registration_timeout':
    ensure => present,
    owner => root,
    group => root,
    mode => 0755,
    content => '5mins'
  }

  if $nfs_server {

    include nfs::server

    file { [ '/data', '/data/db', '/data/sessions' ]:
      ensure => directory,
      owner => root,
      group => root,
      mode => 0777
    } ->

    ::nfs::server::export { '/data':
      ensure  => 'mounted',
      clients => "192.168.33.0/24(rw,insecure,async,no_root_squash)",
      require => File['/data']
    }

  } else {

    include nfs::client

    ::nfs::client::mount { '/data':
      server  => $nfs_server_ip,
      share   => '/data',
      options => 'rw',
    }

  }
  
}