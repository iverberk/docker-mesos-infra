class nfs::server::redhat::install {

  package { 'nfs4-acl-tools':
    ensure => installed,
  }

}
