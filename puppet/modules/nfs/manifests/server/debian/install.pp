class nfs::server::debian::install {

  package { 'nfs-kernel-server':
    ensure => installed
  }

}
