class transmission::config {
  File {
    owner => $transmission::user,
    group => $transmission::group,
  }

  if $transmission::merged_settings['incomplete-dir-enabled'] {
    validate_absolute_path($transmission::merged_settings['incomplete-dir'])
    file { $transmission::merged_settings['incomplete-dir']:
      ensure  => 'directory',
    }
  }

  if $transmission::merged_settings['watch-dir-enabled'] {
    validate_absolute_path($transmission::merged_settings['watch-dir'])
    file { $transmission::merged_settings['watch-dir']:
      ensure => 'directory',
    }
  }

  file { $transmission::merged_settings['download-dir']:
    ensure  => 'directory',
  }

  file { 'transmission_temp_settings':
    ensure  => 'file',
    path    => "${transmission::conf_dir}/settings.tmp.json",
    mode    => '0600',
    content => template("${module_name}/settings.json.erb"),
  }

  file { $transmission::params::init_file:
    ensure   => 'file',
    owner    => 'root',
    group    => '0',
    content => template($transmission::params::init_template),
  }
}
