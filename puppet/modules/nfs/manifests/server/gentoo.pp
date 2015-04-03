# Gentoo specifix stuff
class nfs::server::gentoo(
  $nfs_v4 = false,
  $nfs_v4_idmap_domain = undef
) {

  class{ 'nfs::client::gentoo':
    nfs_v4              => $nfs_v4,
    nfs_v4_idmap_domain => $nfs_v4_idmap_domain,
  }

  include nfs::server::gentoo::install, nfs::server::gentoo::service

}
