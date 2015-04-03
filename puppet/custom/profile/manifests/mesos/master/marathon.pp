class profile::mesos::master::marathon {

  package { 'marathon':
    ensure  => present,
    require => Class['profile::mesos::master'],
  }

  service { 'marathon':
    ensure  => running,
    enable  => true,
    require => Package['marathon'],
  }

}