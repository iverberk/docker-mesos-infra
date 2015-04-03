class nfs::server::redhat::service {

  if $nfs::server::redhat::nfs_v4 == true {
    service {'nfs':
      ensure     => running,
      enable     => true,
      hasrestart => true,
      hasstatus  => true,
      require    => Package['nfs-utils'],
      subscribe  => [ Concat['/etc/exports'], Augeas['/etc/idmapd.conf'] ],
    }
  } else {
    service {'nfs':
      ensure     => running,
      enable     => true,
      hasrestart => true,
      hasstatus  => true,
      require    => Package['nfs-utils'],
      subscribe  => Concat['/etc/exports'],
    }
  }
}
