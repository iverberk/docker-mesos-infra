class nfs::client::gentoo::service {

  Service{
    require => Class['nfs::client::gentoo::configure']
  }

}
