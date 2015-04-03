class nfs::client::debian::install {

  package { 'rpcbind':
    ensure => installed,
  }

  Package['rpcbind'] -> Service ['rpcbind']


  package { ['nfs-common', 'nfs4-acl-tools']:
    ensure => installed,
  }

}
