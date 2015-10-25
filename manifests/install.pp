class transmission::install {
  if $transmission::manage_user {
    user { $transmission::user:
      ensure  => 'present',
      home    => $transmission::conf_dir,
      comment => 'Transmission Daemon User',
      gid     => $transmission::group,
      shell   => $transmission::shell,
    }
  }

  if $transmission::manage_group {
    group { $transmission::group:
      ensure => 'present',
    }
  }

  package { $transmission::package_list:
    ensure => $transmission::package_ensure,
  }
}
