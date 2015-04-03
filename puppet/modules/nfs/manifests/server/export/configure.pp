define nfs::server::export::configure (
  $clients,
  $ensure = 'present'
) {

  if $ensure != 'absent' {
    $line = "${name} ${clients}\n"

    concat::fragment{
      $name:
        target  => '/etc/exports',
        content => $line
    }
  }
}
