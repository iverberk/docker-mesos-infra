class loadbalancer::install {

  docker::image { '192.168.33.19:5000/nginx':
    ensure => 'present'
  }

}