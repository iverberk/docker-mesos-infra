class registry::service {

  docker::run { 'registry-app':
    image           => 'registry',
    ports           => ['5000:5000'],
    use_name        => true,
    volumes         => ['/opt/registry', '/opt/registry'],
    volumes_from    => 'registry-data',
    env             => ['SETTINGS_FLAVOR=local', 'STORAGE_PATH=/opt/registry'],
    dns             => ['8.8.8.8', '8.8.4.4'],
    restart_service => true,
    privileged      => false,
    pull_on_start   => false,
    require         => Docker::Run['registry-data'],
  }

} 