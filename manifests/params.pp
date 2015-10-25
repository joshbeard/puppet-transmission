class transmission::params {

  case $::osfamily {
    'FreeBSD': {
      $download_dir   = '/usr/local/etc/transmission/home/Downloads'
      $incomplete_dir = '/usr/local/etc/transmission/home/incomplete'
      $pid_file       = '/var/run/transmission/daemon.pid'
      $package_list   = [ 'transmission-cli', 'transmission-daemon', 'transmission-web' ]
      $service_name   = 'transmission'
      $conf_dir       = '/usr/local/etc/transmission/home'
      $shell          = '/usr/sbin/nologin'
      $init_file      = '/etc/rc.conf.d/transmission'
      $init_template  = 'transmission/rc.erb'
      $user           = 'transmission'
      $group          = 'transmission'
    }
    'RedHat': {
      $download_dir   = '/var/lib/transmission/Downloads'
      $incomplete_dir = '/var/lib/transmission/Downloads'
      $pid_file       = undef
      $package_list   = [ 'transmission-cli', 'transmission-daemon' ]
      $service_name   = 'transmission-daemon'
      $conf_dir       = '/var/lib/transmission/.config/transmission/'
      $shell          = '/sbin/nologin'
      $init_file      = '/etc/sysconfig/transmission-daemon'
      $init_template  = 'transmission/sysconfig.erb'
    }
    'Debian': {
      $download_dir   = '/var/lib/transmission-daemon/downloads'
      $incomplete_dir = '/home/debian-transmission/Downloads'
      $pid_file       = undef
      $package_list   = [ 'transmission-cli', 'transmission-daemon' ]
      $service_name   = 'transmission-daemon'
      $conf_dir       = '/var/lib/transmission-daemon/info'
      $shell          = '/bin/false'
      $init_file      = '/etc/default/transmission-daemon'
      $init_template  = 'transmission/default.erb'
      $user           = 'debian-transmission'
      $group          = 'debian-transmission'
    }
  }

  $default_settings = {
    'alt-speed-down'                 => '50',
    'alt-speed-enabled'              => false,
    'alt-speed-time-begin'           => '540',
    'alt-speed-time-day'             => '127',
    'alt-speed-time-enabled'         => false,
    'alt-speed-time-end'             => '1020',
    'alt-speed-up'                   => 50,
    'bind-address-ipv4'              => '0.0.0.0',
    'bind-address-ipv6'              => '::',
    'blocklist-enabled'              => false,
    'blocklist-url'                  => 'http://www.example.com/blocklist',
    'cache-size-mb'                  => 4,
    'dht-enabled'                    => true,
    'download-dir'                   => $download_dir,
    'download-queue-enabled'         => true,
    'download-queue-size'            => 5,
    'encryption'                     => 1,
    'idle-seeding-limit'             => 30,
    'idle-seeding-limit-enabled'     => false,
    'incomplete-dir'                 => $incomplete_dir,
    'incomplete-dir-enabled'         => false,
    'lpd-enabled'                    => false,
    'message-level'                  => 2,
    'peer-congestion-algorithm'      => '',
    'peer-id-ttl-hours'              => 6,
    'peer-limit-global'              => 200,
    'peer-limit-per-torrent'         => 50,
    'peer-port'                      => 51413,
    'peer-port-random-high'          => 65535,
    'peer-port-random-low'           => 49152,
    'peer-port-random-on-start'      => false,
    'peer-socket-tos'                => 'default',
    'pex-enabled'                    => true,
    'pidfile'                        => $pid_file,
    'port-forwarding-enabled'        => true,
    'preallocation'                  => 1,
    'prefetch-enabled'               => 1,
    'queue-stalled-enabled'          => true,
    'queue-stalled-minutes'          => 30,
    'ratio-limit'                    => 2,
    'ratio-limit-enabled'            => false,
    'rename-partial-files'           => true,
    'rpc-authentication-required'    => false,
    'rpc-bind-address'               => '0.0.0.0',
    'rpc-enabled'                    => true,
    'rpc-password'                   => '{af59a61a928e83402ef909c591526dd9a4744e1eo4gclM6N',
    'rpc-port'                       => 9091,
    'rpc-url'                        => '/transmission/',
    'rpc-username'                   => '',
    'rpc-whitelist'                  => '127.0.0.1',
    'rpc-whitelist-enabled'          => false,
    'scrape-paused-torrents-enabled' => true,
    'script-torrent-done-enabled'    => false,
    'script-torrent-done-filename'   => '',
    'seed-queue-enabled'             => false,
    'seed-queue-size'                => 10,
    'speed-limit-down'               => 100,
    'speed-limit-down-enabled'       => false,
    'speed-limit-up'                 => 100,
    'speed-limit-up-enabled'         => false,
    'start-added-torrents'           => true,
    'trash-original-torrent-files'   => false,
    'umask'                          => '18',
    'upload-slots-per-torrent'       => 14,
    'utp-enabled'                    => true,
    'watch-dir'                      => '',
    'watch-dir-enabled'              => false
    }
  }
