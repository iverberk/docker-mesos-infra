class profile::mesos::master {

  include profile::mesos::base

  service { 'mesos-slave':
    ensure  => 'stopped',
    enable  => false,
    require => Package['mesos']
  }
  
  class { '::mesos::master':
    env_var => {
      'MESOS_LOG_DIR' => '/var/log/mesos',
    },
    require => Class['profile::zookeeper'],
  }

  Class['apt::update'] -> Package['java']
  
}