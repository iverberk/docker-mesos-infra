class profile::mesos::base {

  include ::docker
  include ::consul
  include ::registrator

  class { '::mesos':
    repo => 'mesosphere',
  }

  Class['apt'] -> Package<| |>
  
}