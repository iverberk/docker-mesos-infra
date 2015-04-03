class role::mesos::master {

  include profile::zookeeper
  include profile::mesos::master

  # Mesos frameworks
  include profile::mesos::master::marathon

}