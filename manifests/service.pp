class transmission::service {
  exec { 'reconfigure_transmission':
    command => "puppet resource service ${transmission::service_name} ensure=stopped && cp -af ${transmission::conf_dir}/settings.tmp.json ${transmission::conf_dir}/settings.json",
    unless  => "diff -w ${transmission::conf_dir}/settings.tmp.json ${transmission::conf_dir}/settings.json",
    cwd     => $transmission::conf_dir,
    path    => $::path,
  }

  service { $transmission::service_name:
    ensure    => $transmission::service_ensure,
    enable    => $transmission::service_enable,
    subscribe => Exec['reconfigure_transmission'],
  }
}
