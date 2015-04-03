class nfs::server::gentoo::service {

  if $::nfs::client::gentoo::nfs_v4 == true {
    service { 'nfs':
      ensure     => running,
      enable     => true,
      hasrestart => true,
      hasstatus  => true,
      require    => Package['net-fs/nfs-utils'],
      subscribe  => [
        Concat['/etc/exports'],
        Augeas['/etc/idmapd.conf', '/etc/conf.d/nfs']
        ],
    }
  } else {
    service { 'nfs':
      ensure     => running,
      enable     => true,
      hasrestart => true,
      hasstatus  => true,
      require    => Package['net-fs/nfs-utils'],
      subscribe  => Concat['/etc/exports'],
    }
  }
}
