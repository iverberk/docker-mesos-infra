class loadbalancer::config (
  $keepalived_instances
) {

  keepalived::vrrp::script { 'check_nginx':
    script => '/usr/bin/killall -0 nginx',
  }

  create_resources('keepalived::vrrp::instance', $keepalived_instances)

}