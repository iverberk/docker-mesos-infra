class nfs::server::nfs_v4::configure {

  concat::fragment{
    'nfs_exports_root':
      target  => '/etc/exports',
      content => "${nfs::server::nfs_v4_export_root} ${nfs::server::nfs_v4_export_root_clients}\n",
      order   => 02
  }
  file {
    $nfs::server::nfs_v4_export_root:
      ensure => directory,
  }

  @@nfs::client::mount::nfs_v4::root {"shared server root by ${::clientcert}":
    ensure    => $nfs::server::nfs_v4_root_export_ensure,
    mount     => $nfs::server::nfs_v4_root_export_mount,
    remounts  => $nfs::server::nfs_v4_root_export_remounts,
    atboot    => $nfs::server::nfs_v4_root_export_atboot,
    options   => $nfs::server::nfs_v4_root_export_options,
    bindmount => $nfs::server::nfs_v4_root_export_bindmount,
    nfstag    => $nfs::server::nfs_v4_root_export_tag,
    server    => $::clientcert,
  }
}
