class nfs::server::darwin(
  $nfs_v4              = false,
  $nfs_v4_idmap_domain = undef
) {
  fail('NFS server is not supported on Darwin')
}
