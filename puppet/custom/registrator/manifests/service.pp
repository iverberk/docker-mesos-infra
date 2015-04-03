class registrator::service (
  $consul_backend = "${::ipaddress_eth1}:8500"
) {

  docker::run { 'registrator-app':
    image           => 'gliderlabs/registrator',
    hostname        => $::fqdn,
    volumes         => ['/var/run/docker.sock:/tmp/docker.sock'],
    command         => "consul://${consul_backend}",
    use_name        => true,
    restart_service => true,
    privileged      => false,
    pull_on_start   => false,
  }

}