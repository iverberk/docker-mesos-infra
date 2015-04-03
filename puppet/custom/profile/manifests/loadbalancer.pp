class profile::loadbalancer {

  include ::docker
  include ::loadbalancer
  include ::keepalived

}