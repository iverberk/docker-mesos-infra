define nfs::client::mount::nfs_v4::bindmount (
  $mount_name,
  $ensure = 'present',
) {

  nfs::mkdir{ $mount_name: }

  mount {
    $mount_name:
      ensure  => $ensure,
      device  => $name,
      atboot  => true,
      fstype  => 'none',
      options => 'bind',
      require => Nfs::Mkdir[$mount_name],
  }

}
