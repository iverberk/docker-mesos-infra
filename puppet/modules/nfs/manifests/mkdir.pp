# Nasty ass hax to allow several levels of directories
define nfs::mkdir (
  $owner = 'root',
  $group = 'root',
  $perm  = '0777'
) {
  exec { "mkdir_recurse_${name}":
    path    => ['/bin', '/usr/bin'],
    command => "mkdir -p ${name}",
    unless  => "test -d ${name}",
  }

  file { $name:
    ensure  => directory,
    require => Exec["mkdir_recurse_${name}"],
    mode    => $perm,
    owner   => $owner,
    group   => $group,
  }

}
