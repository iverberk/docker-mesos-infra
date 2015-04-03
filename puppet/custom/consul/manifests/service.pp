class consul::service (
  $cmd,
  $docker_bridge = '172.17.42.1'
) {

  docker::run { 'consul-app':
    image           => 'progrium/consul',
    ports           => [
        '8500:8500', 
        '8400:8400', 
        '8302:8302/udp', 
        '8302:8302', 
        '8301:8301/udp', 
        '8301:8301', 
        '8300:8300',
        "${docker_bridge}:53:53/udp"
      ],
    command         => $cmd,
    use_name        => true,
    restart_service => true,
    privileged      => false,
    pull_on_start   => false,
    hostname        => $::fqdn
  }

}