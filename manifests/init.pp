# == Class: transmission
#
# Manage the transmission bittorrent client
#
class transmission (
  $conf_dir       = $transmission::params::conf_dir,
  $manage_user    = true,
  $user           = $transmission::params::user,
  $manage_group   = true,
  $group          = $transmission::params::group,
  $shell          = $transmission::params::shell,
  $package_list   = $transmission::params::package_list,
  $package_ensure = 'installed',
  $manage_service = true,
  $service_name   = $transmission::params::service_name,
  $service_ensure = 'running',
  $service_enable = true,
  $settings       = {},
  $startup_opts   = [],
) inherits transmission::params {

  validate_absolute_path($conf_dir)
  validate_bool($manage_user)
  validate_re($user, '^[a-z_][a-z0-9_-]*[$]?$')
  validate_bool($manage_group)
  validate_re($group, '^[a-z_][a-z0-9_-]*[$]?$')
  validate_absolute_path($shell)
  validate_bool($manage_service)
  validate_re($service_ensure, '^(running|stopped)$')
  validate_bool($service_enable)

  validate_hash($settings)
  $merged_settings = merge($transmission::params::default_settings, $settings)

  validate_array($startup_opts)

  validate_bool($merged_settings['incomplete-dir-enabled'])
  validate_absolute_path($merged_settings['download-dir'])

  anchor { 'transmission::start': }->
  class { 'transmission::install': }->
  class { 'transmission::config': }~>
  class { 'transmission::service': }->
  anchor { 'transmission::end': }

}
