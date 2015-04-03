class nfs::client::gentoo::configure {
  Augeas{
    require => Class['nfs::client::gentoo::install']
  }

  if $nfs::client::gentoo::nfs_v4 {
      augeas {
        '/etc/conf.d/nfs':
          context => '/files/etc/conf.d/nfs',
          changes => [ 'set NFS_NEEDED_SERVICES rpc.idmapd' ];
        '/etc/idmapd.conf':
          context => '/files/etc/idmapd.conf/General',
          lens    => 'Puppet.lns',
          incl    => '/etc/idmapd.conf',
          changes => ["set Domain ${nfs::client::gentoo::nfs_v4_idmap_domain}"];
      }
  }

}
