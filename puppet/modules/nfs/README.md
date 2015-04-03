#nfs

####Table of Contents

1. [Overview - What is the nfs module?](#overview)
2. [Module Description - What does this module do?](#module-description)
3. [Setup - The basics of getting started with nfs](#setup)
    * [Simple mount an nfs share](#simple-mount-nfs-share)
    * [NFSv3 server and client] (#nfsv3-server-and-client)
    * [NFSv3 multiple exports, servers and multiple node] (#nfsv3-multiple-exports-servers-and-multiple-node)
    * [NFSv4 Simple example] (#nfsv4-simple-example)
    * [NFSv4 insanely overcomplicated reference] (#nfsv4-insanely-overcomplicated-reference)
4. [Usage - The classes and defined types available for configuration](#usage)
    * [Class: nfs::server](#class-nfsserver)
    * [Defined Type: nfs::server::export](#defined-type-nfsserverexport)
    * [Class: nfs::client](#class-nfsclient)
    * [Defined Type: nfs::client::mount](#defined-type-nfsclientmount)
5. [Requirements](#requirements)
6. [Limitations - OS compatibility, etc.](#limitations)
7. [Contributing to the graphite module](#contributing)

##Overview

This module installs, configures and manages everything on NFS clients and servers.

Github Master: [![Build Status](https://secure.travis-ci.org/echocat/puppet-nfs.png?branch=master)](https://travis-ci.org/echocat/puppet-nfs)

##Module Description

This module can be used to simply mount nfs shares on a client or to configure your nfs servers.
It can make use of storeconfigs on the puppetmaster to get its resources. 

##Setup

**What nfs affects:**

* packages/services/configuration files for NFS usage
* can be used with puppet storage

###Simple mount nfs share

This example mounts a nfs share on the client, with NFSv3

```puppet
include '::nfs::client'

::nfs::client::mount { '/mnt/mymountpoint':
  server  => 'nfsserver.my.domain',
  share   => '/share/on/server',
  options => 'rw',
}
```

###NFSv3 server and client

This will export /data/folder on the server and automagically mount it on client.
You need storeconfigs/puppetdb for this to work.
  
```puppet
node server {
  include nfs::server

  ::nfs::server::export{ '/data_folder':
    ensure  => 'mounted',
    clients => '10.0.0.0/24(rw,insecure,async,no_root_squash) localhost(rw)'
  }
}
```

By default, mounts are mounted in the same folder on the clients as
they were exported from on the server.

```puppet
node client {
  include '::nfs::client'
  Nfs::Client::Mount <<| |>> 
}
```

###NFSv3 multiple exports, servers and multiple node

```puppet
  node server1 {
    include '::nfs::server'
    ::nfs::server::export{ 
      '/data_folder':
        ensure  => 'mounted',
        clients => '10.0.0.0/24(rw,insecure,async,no_root_squash) localhost(rw)'
      # exports /homeexport and mounts them om /srv/home on the clients
      '/homeexport':
        ensure  => 'mounted',
        clients => '10.0.0.0/24(rw,insecure,async,root_squash)',
        mount   => '/srv/home'
    }
  }

  node server2 {
    include '::nfs::server'
    # ensure is passed to mount, which will make the client not mount it
    # the directory automatically, just add it to fstab
    ::nfs::server::export{ 
      '/media_library':
        ensure  => 'present',
        nfstag     => 'media'
        clients => '10.0.0.0/24(rw,insecure,async,no_root_squash) localhost(rw)'
    }
  }

  node client {
    include '::nfs::client'
    Nfs::Client::Mount <<| |>>; 
  }

  # Using a storeconfig override, to change ensure option, so we mount
  # all shares
  
  node greedy_client {
    include '::nfs::client'
    Nfs::Client::Mount <<| |>> {
      ensure => 'mounted'
    }
  }


  # only the mount tagged as media 
  # also override mount point
  node media_client {
    include '::nfs::client'
    Nfs::Client::Mount <<|nfstag == 'media' |>> {
      ensure => 'mounted',
      mount  => '/import/media'
    }
  }

  # All @@nfs::server::mount storeconfigs can be filtered by parameters
  # Also all parameters can be overridden (not that it's smart to do
  # so).
  # Check out the doc on exported resources for more info:
  # http://docs.puppetlabs.com/guides/exported_resources.html
  node single_server_client {
    include '::nfs::client'
    Nfs::Client::Mount <<| server == 'server1' |>> {
      ensure => 'absent',
    }
  }
```

###NFSv4 Simple example

We use the `$::domain` fact for the Domain setting in `/etc/idmapd.conf`.
For NFSv4 to work this has to be equal on servers and clients
set it manually if unsure.

All nfsv4 exports are bind mounted into `/export/$mount_name`
and mounted on `/srv/$mount_name` on the client.
Both values can be overridden through parameters both globally
and on individual nodes.

```puppet
  node server {
    class { 'nfs::server':
      nfs_v4 = true,
      nfs_v4_export_root_clients =>
        '10.0.0.0/24(rw,fsid=root,insecure,no_subtree_check,async,no_root_squash)'
    }
    nfs::server::export{ '/data_folder':
      ensure  => 'mounted',
      clients => '10.0.0.0/24(rw,insecure,no_subtree_check,async,no_root_squash) localhost(rw)'
    }
  }
```

By default, mounts are mounted in the same folder on the clients as
they were exported from on the server

```puppet
node client {
  class { 'nfs::server':
    nfs_v4 = true,
    nfs_v4_export_root_clients =>
      '10.0.0.0/24(rw,fsid=root,insecure,no_subtree_check,async,no_root_squash)'
  }
  Nfs::Client::Mount <<| |>>; 
}
```

We can also mount the NFSv4 Root directly through nfs::client::mount::nfsv4::root.
By default /srv will be used for as mount point, but can be overriden through
the 'mounted' option.

```puppet
node client2 {
  $server = 'server'

  class { '::nfs::server':
    nfs_v4 = true,
  }
  Nfs::Client::Mount::Nfs_v4::Root <<| server == $server |>> { 
    mount => "/srv/$server",
  }
}
```

###NFSv4 insanely overcomplicated reference

Just to show you, how coplex we can make things ;-)

```puppet
  # and on individual nodes.
  node server {
    class { 'nfs::server':
      nfs_v4              => true,
      # Below are defaults
      nfs_v4_idmap_domain => $::domain,
      nfs_v4_export_root  => '/export',
      # Default access settings of /export root
      nfs_v4_export_root_clients =>
        "*.${::domain}(ro,fsid=root,insecure,no_subtree_check,async,root_squash)"
    }
    
    nfs::server::export{ '/data_folder':
      # These are the defaults
      ensure  => 'mounted',
      # rbind or bind mounting of folders bindmounted into /export 
      # google it
      bind    => 'rbind',
      # everything below here is propogated by to storeconfigs
      # to clients
      #
      # Directory where we want export mounted on client 
      mount     => undef, 
      remounts  => false,
      atboot    => false,
      #  Don't remove that option, but feel free to add more.
      options   => '_netdev',
      # If set will mount share inside /srv (or overridden mount_root)
      # and then bindmount to another directory elsewhere in the fs -
      # for fanatics.
      bindmount => undef,    
      # Used to identify a catalog item for filtering by by
      # storeconfigs, kick ass.
      nfstag     => undef,
      # copied directly into /etc/exports as a string, for simplicity
      clients => '10.0.0.0/24(rw,insecure,no_subtree_check,async,no_root_squash)'
  }

  node client {
    class { 'nfs::server':
      nfs_v4              => true,
      nfs_v4_idmap_domain => $::domain
      nfs_v4_mount_root   => '/srv',
    }

    # We can as you by now know, override options set on the server
    # on the client node.
    # Be careful. Don't override mount points unless you are sure
    # that only one export will match your filter!
    
    Nfs::Client::Mount <<| # filter goes here # |>> {
      # Directory where we want export mounted on client 
      mount     => undef, 
      remounts  => false,
      atboot    => false,
      #  Don't remove that option, but feel free to add more.
      options   => '_netdev',
      # If set will mount share inside /srv (or overridden mount_root)
      # and then bindmount to another directory elsewhere in the fs -
      # for fanatics.
      bindmount => undef,    
    }
  }
```

##Usage

####Class: `nfs::server`

Set up NFS server and exports. NFSv3 and NFSv4 supported.

**Parameters within `nfs::server`:**

#####`nfs_v4` (optional)

NFSv4 support. Will set up automatic bind mounts to export root.
Disabled by default.

#####`nfs_v4_export_root` (optional)

Export root, where we bind mount shares, default /export

#####`nfs_v4_idmap_domain` (optional)

Domain setting for idmapd, must be the same across server
and clients. Default is to use $domain fact.

#####Examples

```puppet
class { '::nfs::server':
  nfs_v4                      => true,
  nfs_v4_export_root_clients  => "*.${::domain}(ro,fsid=root,insecure,no_subtree_check,async,root_squash)",
  # Generally parameters below have sane defaults.
  nfs_v4_export_root          => "/export",
  nfs_v4_idmap_domain         => $::domain,
}
```

####Defined Type: `nfs::server::export`

Set up NFS export on the server (and stores data in configstore)

**Parameters within `nfs::server::export`:**

#####`v3_export_name` (optional)

Default is `$name`. Usally you do not set it explicit.

#####`v4_export_name` (optional)

Default results from `$name`. Usally you do not set it explicit.

#####`ensure` (optional)

Default is 'mounted'

#####`bind` (optional)

Default is 'rbind'. 
rbind or bind mounting of folders bindmounted into /export. Google it!

**Following parameteres are propogated by to storeconfigs to clients**

#####`mount` (optional)

Default is undef. This means client mount path is the same as server export path.
Directory where we want export mounted on client 

#####`remounts` (optional)

Default is false.

#####`atboot` (optional)

Default is false.

#####`options` (optional)

Default is '_netdev'. Don't remove that option, but feel free to add more.

#####`bindmount` (optional)

Default is undef. If set will mount share inside /srv (or overridden mount_root)
and then bindmount to another directory elsewhere in the fs - for fanatics.

#####`nfstag` (optional)

Default is undef. Used to identify a catalog item for filtering by storeconfigs on clients.

#####`clients` (optional)

Default is 'localhost(ro)'. Copied directly into /etc/exports as a string, for simplicity.

#####Example

```puppet
::nfs::server::export { '/media_library':
  nfstag  => 'media'
  clients => '10.0.0.0/24(rw,insecure,async,no_root_squash) localhost(rw)'
}
```

####Class: `nfs::client`

Set up NFS client and mounts. NFSv3 and NFSv4 supported.

**Parameters within `nfs::client`:**

#####`nfs_v4`

NFSv4 support.
Disabled by default.

#####`nfs_v4_mount_root`

Mount root, where we  mount shares, default /srv

#####`nfs_v4_idmap_domain`

Domain setting for idmapd, must be the same across server
and clients. Default is to use $::domain fact.

#####Example

```puppet
class { '::nfs::client':
  nfs_v4              => true,
  # Generally parameters below have sane defaults.
  nfs_v4_mount_root   => '/srv',
  nfs_v4_idmap_domain => $::domain,
}
```

####Defined Type: `nfs::client::mount`

Set up NFS mount on client.

**Parameters within `nfs::client::mount`:**

#####`server`

FQDN or IP of the NFS server.

#####`share`

Name of share to be mounted.

#####`ensure` (optional)

Default is 'mounted'.

#####`mount` (optional)

Default is `$title` of defined type. Defines mountpoint of the share on the client.

#####`remounts` (optional)

Default is false.

#####`atboot` (optional)

Default is false.

#####`options` (optional)

Default is '_netdev'. Don't remove that option, but feel free to add more.

#####`bindmount` (optional)

Default is undef. If set will mount share inside /srv (or overridden mount_root)
and then bindmount to another directory elsewhere in the fs - for fanatics.

#####`nfstag` (optional)

Default is undef. Used to identify a catalog item for filtering by storeconfigs on clients.

#####`owner` (optional)

Default is 'root'. Sets owner of local mountpoint.

#####`group` (optional)

Default is `root`. Sets goup ownership of mountpoint.

#####`perm` (optional)

Default is '0777'. Set mode of mountpoint.

##Requirements

If you want to have the full potential of this module its recommend to have storeconfigs enabled.

###Modules needed:

* stdlib by puppetlabs
* concat by puppetlabs

###Software versions needed:

* facter > 1.6.2
* puppet > 2.6.2

##Limitations

##Contributing

Echocat modules are open projects. So if you want to make this module even better, you can contribute to this module on [Github](https://github.com/echocat/puppet-nfs).

This module is forked/based on Harald Skoglund <haraldsk@redpill-linpro.com> from https://github.com/haraldsk/puppet-module-nfs/
