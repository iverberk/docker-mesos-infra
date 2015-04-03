class registry::install {

  docker::image { 'registry':
    ensure => 'present'
  }

}