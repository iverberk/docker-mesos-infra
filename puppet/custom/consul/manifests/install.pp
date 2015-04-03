class consul::install {

  docker::image { 'progrium/consul':
    ensure => 'present'
  }
  
}