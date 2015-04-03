#
#== Define nfs::client::mount::nfs_v4::root
#
# Mounts the NFSv4 server root.
#
# Don't  use this without configuring a different mount path
# if you have several NFS servers.
#
#

define nfs::client::mount::nfs_v4::root (
  $server,
  $ensure    = 'mounted',
  $mount     = undef,
  $remounts  = false,
  $atboot    = false,
  $options   = '_netdev',
  $bindmount = undef,
  $nfstag    = undef
) {

  include ::nfs::client

  if $mount == undef {
    $_nfs4_mount = $nfs::client::nfs_v4_mount_root
  } else {
    $_nfs4_mount = $mount
  }

  nfs::mkdir{ $_nfs4_mount: }

  mount {"shared root by ${::clientcert} on ${_nfs4_mount}":
    ensure   => $ensure,
    device   => "${server}:/",
    fstype   => 'nfs4',
    name     => $_nfs4_mount,
    options  => $options,
    remounts => $remounts,
    atboot   => $atboot,
    require  => Nfs::Mkdir[$_nfs4_mount],
  }


  if $bindmount != undef {
    nfs::client::mount::nfs_v4::bindmount { $_nfs4_mount:
      ensure     => $ensure,
      mount_name => $bindmount,
    }
  }
}
