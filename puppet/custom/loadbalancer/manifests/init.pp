class loadbalancer {

  include loadbalancer::install
  include loadbalancer::config
  include loadbalancer::service

}
