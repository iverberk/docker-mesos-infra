class nfs::params (
  $nfs_v4                     = false,
  $nfs_v4_export_root         = '/export',
  $nfs_v4_export_root_clients = "*.${::domain}(ro,fsid=root,insecure,no_subtree_check,async,root_squash)",
  $nfs_v4_mount_root          = '/srv',
  $nfs_v4_idmap_domain        = $::domain
) {

  # Somehow the ::osfamliy fact doesnt exist on some oled systems

  case $::operatingsystem {
    'centos', 'redhat', 'scientific', 'fedora', 'SLC' : { $osfamily = 'redhat' }
    'debian', 'Ubuntu' : { $osfamily = 'debian' }
    'windows'          : { fail('fail!11') }
    'darwin'           : { $osfamily = 'darwin' }
    'gentoo'           : { $osfamily = 'gentoo' }
    default            : { fail("OS: ${::operatingsystem} not supported") }
  }
}
