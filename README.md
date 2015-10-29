# puppet-transmission

#### Table of Contents

1. [Overview](#overview)
2. [Setup - The basics of getting started with transmission](#setup)
    * [What transmission affects](#what-transmission-affects)
    * [Setup requirements](#setup-requirements)
3. [Usage - Configuration options and additional functionality](#usage)
    * [Reference - class parameters](#reference)
    * [Examples](#examples)
4. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

Manages the installation and configuration of the Transmission BitTorrent
client.

## Setup

### What transmission affects

* Optionally manages a user and group
* Optionally manages the transmission service
* Manages the transmission config file (settings.json)
* Manages the installation of transmission packages
* Manages the service configuration for transmission (e.g. defaults or
  sysconfig)

This module is intended for managing the command-line, daemon, and web
installation of Transmission.  For example, on a headless server.

### Setup Requirements

This module does not manage package repositories for installation.  It is the
user's responsibility to make sure the repositories are available with a
desirable package set for Transmission.

## Usage

The base class, `::transmission`, is all you need to interface with.

## Reference

### Class: `transmission`

#### `conf_dir`

The absolute path to the directory that contains Transmission's `settings.json`
config file.

Defaults:

* FreeBSD: `/usr/local/etc/transmission/home`
* RedHat: `/var/lib/transmission/.config/transmission`
* Debian: `/var/lib/transmission-daemon/info`

#### `manage_user`

Boolean. Whether this module should manage the user or not.

Default: true

#### `user`

String.  The name of the user.

Defaults to `transmission` on FreeBSD and RedHat and `debian-transmission` on
Debian systems.

#### `manage_group`

Boolean. Whether this module should manage the group or not.

#### `group`


String.  The name of the group.

Defaults to `transmission` on FreeBSD and RedHat and `debian-transmission` on
Debian systems.

#### `shell`

Absolute path to the shell for the user, if managed.

Defaults to `/usr/sbin/nologin` on FreeBSD, `/sbin/nologin` on RedHat, and
`/bin/false` on Debian.

#### `package_list`

An array of packages to manage.

Defaults:

* FreeBSD: `[ 'transmission-cli', 'transmission-daemon', 'transmission-web' ]`
* RedHat and Debian: `[ 'transmission-cli', 'transmission-daemon' ]`

#### `package_ensure`

The state of the packages.

Defaults to `installed`.  Can be any value that the `ensure` parameter of the
package type can be set to (e.g. `latest`, `absent`)

#### `manage_service`

Whether this module should manage the service or not.

#### `service_name`

The name of the service to manage.

Defaults:

* FreeBSD: `transmission`
* RedHat: `transmission-daemon`
* Debian: `transmission-daemon`

#### `service_ensure`

The state of the service.  Defaults to `running`

#### `service_enable`

Boolean.  Whether the service should be enabled on boot.

#### `settings`

A hash of the settings for Transmission.

Refer to [https://trac.transmissionbt.com/wiki/EditConfigFiles](https://trac.transmissionbt.com/wiki/EditConfigFiles)
for configuration options.

Also refer to [manifests/params.pp](manifests/params.pp) for the default values.

Ultimately, any option you provide in this hash will be _merged_ with the
defaults.

#### `startup_opts`

Any additional startup options to pass to the daemon.

### Examples

Enabling a watched directory:

```puppet
class { '::transmission':
  settings => {
    'watch-dir-enabled' => true,
    'watch-dir'         => '/opt/transmission/torrents',
  },
}
```

These correspond to settings from `settings.json` ([https://trac.transmissionbt.com/wiki/EditConfigFiles#FilesandLocations](https://trac.transmissionbt.com/wiki/EditConfigFiles#FilesandLocations))

```puppet
class { '::transmission':
  settings => {
    'download-dir' => '/opt/transmission/downloads',
  },
}
```

In this example, the options for `watch-dir` will be _merged_ with all of the
default settings listedin [manifests/params.pp](manifests/params.pp)

## Limitations

Tested with Ubuntu 14.04, CentOS 6, and FreeBSD 10

## Development

### Contributing

Contributions are more than welcome!  Reporting issues or code contributions.

1. Fork this repo
2. Do your work
3. Create a pull request

## Authors

Josh Beard (<josh@signalboxes.net>)
