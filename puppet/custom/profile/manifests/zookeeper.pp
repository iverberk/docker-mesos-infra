class profile::zookeeper {

  include ::java
  
  class { '::zookeeper':
    repo => 'cloudera',
    require => Class['java'],
  }

}