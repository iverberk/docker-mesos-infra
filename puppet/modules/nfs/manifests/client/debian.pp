class nfs::client::debian (
  $nfs_v4 = false,
  $nfs_v4_idmap_domain = undef
) {

  include nfs::client::debian::install,
    nfs::client::debian::configure,
    nfs::client::debian::service

}
