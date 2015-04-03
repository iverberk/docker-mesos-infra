define nfs::client::mount (
  $server,
  $share,
  $ensure    = 'mounted',
  $mount     = $title,
  $remounts  = false,
  $atboot    = false,
  $options   = '_netdev',
  $bindmount = undef,
  $nfstag    = undef,
  $owner     = 'root',
  $group     = 'root',
  $perm      = '0777',
) {

  include ::nfs::client

  if $nfs::client::nfs_v4 == true {

    if $mount == undef {
      $_nfs4_mount = "${nfs::client::nfs_v4_mount_root}/${share}"
    } else {
      $_nfs4_mount = $mount
    }

    nfs::mkdir{ $_nfs4_mount: }

    mount {"shared ${server}:${share} by ${::clientcert} on ${_nfs4_mount}":
      ensure   => $ensure,
      device   => "${server}:/${share}",
      fstype   => 'nfs4',
      name     => $_nfs4_mount,
      options  => $options,
      remounts => $remounts,
      atboot   => $atboot,
      require  => [
        Nfs::Mkdir[$_nfs4_mount],
        Class['::nfs::client'],
      ],
    }


    if $bindmount != undef {
      nfs::client::mount::nfs_v4::bindmount { $_nfs4_mount:
        ensure     => $ensure,
        mount_name => $bindmount,
      }
    }

    # dependencies for mount:

  } else {

    if $mount == undef {
      $_mount = $share
    } else {
      $_mount = $mount
    }

    nfs::mkdir{ $_mount:
      owner => $owner,
      group => $group,
      perm  => $perm,
    }

    mount {"shared ${server}:${share} by ${::clientcert} ${_mount}":
      ensure   => $ensure,
      device   => "${server}:${share}",
      fstype   => 'nfs',
      name     => $_mount,
      options  => $options,
      remounts => $remounts,
      atboot   => $atboot,
      require  => [
        Nfs::Mkdir[$_mount],
        Class['::nfs::client'],
      ],
    }

  }

}
