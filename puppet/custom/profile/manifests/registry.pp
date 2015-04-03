class profile::registry {

  include ::docker
  include ::registry

  Class['apt'] -> Package<| |>

}