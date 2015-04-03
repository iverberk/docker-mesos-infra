class nfs::server::debian::service {

  if $nfs::server::debian::nfs_v4 == true {
    service {'nfs-kernel-server':
      ensure     => running,
      enable     => true,
      hasrestart => true,
      hasstatus  => true,
      require    => Package['nfs-kernel-server'],
      subscribe  => [ Concat['/etc/exports'], Augeas['/etc/idmapd.conf','/etc/default/nfs-common'] ],
    }
  } else {
    service {'nfs-kernel-server':
      ensure     => running,
      enable     => true,
      hasrestart => true,
      hasstatus  => true,
      require    => Package['nfs-kernel-server'],
      subscribe  => Concat['/etc/exports'],
    }
  }
}
