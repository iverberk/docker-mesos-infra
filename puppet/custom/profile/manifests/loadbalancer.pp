class profile::loadbalancer {

  include ::docker
  include ::loadbalancer
  include ::keepalived

  Class['apt'] -> Package<| |>

}