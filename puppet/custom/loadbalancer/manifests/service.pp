class loadbalancer::service {

  docker::run { 'nginx-app':
    image           => '192.168.33.19:5000/nginx',
    ports           => ['80:8080'],
    use_name        => true,
    dns             => ['8.8.8.8', '8.8.4.4'],
    restart_service => true,
    privileged      => false,
    pull_on_start   => true,
  }

}