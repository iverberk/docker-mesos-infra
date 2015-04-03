class registrator::install {

  docker::image { 'gliderlabs/registrator':
    ensure => 'present'
  }

}