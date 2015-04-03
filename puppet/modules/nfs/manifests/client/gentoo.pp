class nfs::client::gentoo (
  $nfs_v4 = false,
  $nfs_v4_idmap_domain = undef
) {

  include nfs::client::gentoo::install,
    nfs::client::gentoo::configure,
    nfs::client::gentoo::service

}
