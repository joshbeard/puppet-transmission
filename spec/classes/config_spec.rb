require 'spec_helper'

describe 'transmission::config' do
  context 'supported operating systems' do

    on_supported_os.each do |os, facts|
      context "on #{os}" do

        let(:facts) do
          facts
        end

        context 'with customizations' do
          describe 'watch dir' do
            let :pre_condition do
              "class { 'transmission':
                 settings => {
                  'watch-dir-enabled' => true,
                  'watch-dir'         => '/tmp/torrents',
                 }
               }
              "
            end

            it { is_expected.to contain_file('/tmp/torrents') }
          end

          describe 'incomplete dir' do
            let :pre_condition do
              "class { 'transmission':
                 settings => {
                  'incomplete-dir-enabled' => true,
                  'incomplete-dir'         => '/tmp/incomplete_torrents',
                 }
               }
              "
            end

            it { is_expected.to contain_file('/tmp/incomplete_torrents') }
          end

          describe 'conf_dir' do
            let :pre_condition do
              "class { 'transmission':
                 conf_dir => '/var/foo/transmission',
               }
              "
            end

            case facts[:osfamily]
            when /RedHat/i
              it { is_expected.to contain_file('/etc/sysconfig/transmission-daemon').with({
                :content => /TRANSMISSION_HOME="\/var\/foo\/transmission"/
              })}
            when /FreeBSD/i
              it { is_expected.to contain_file('/etc/rc.conf.d/transmission').with({
                :content => /transmission_conf_dir="\/var\/foo\/transmission"/
              })}
            when /Debian/i
              it { is_expected.to contain_file('/etc/default/transmission-daemon').with({
                :content => /CONFIG_DIR="\/var\/foo\/transmission"/
              })}
            end
          end
        end

        context 'with defaults' do
          let :pre_condition do
            "class { 'transmission': }"
          end

          case facts[:osfamily]
          when /RedHat/i
            it { is_expected.to contain_file('transmission_temp_settings').with({
              :path => '/var/lib/transmission/.config/transmission/settings.tmp.json',
            })}

            [
              '^TRANSMISSION_HOME="/var/lib/transmission/.config/transmission"$',
              '^DAEMON_USER="transmission"$',
              '^DAEMON_ARGS="-g \$TRANSMISSION_HOME "$',
            ].each do |content|
              it { is_expected.to contain_file('/etc/sysconfig/transmission-daemon').with({
                :content => /#{content}/,
              })}
            end

            it { is_expected.to contain_file('/var/lib/transmission/Downloads') }

          when /FreeBSD/
            it { is_expected.to contain_file('transmission_temp_settings').with({
              :path => '/usr/local/etc/transmission/home/settings.tmp.json',
            })}

            it { is_expected.to contain_file('/etc/rc.conf.d/transmission') }

            [
              '^transmission_enable="YES"$',
              '^transmission_conf_dir="/usr/local/etc/transmission/home"$',
              '^transmission_user="transmission"$',
              '^transmission_download_dir="/usr/local/etc/transmission/home/Downloads"$',
            ].each do |content|
              it { is_expected.to contain_file('/etc/rc.conf.d/transmission').with({
                :content => /#{content}/,
              })}
            end

            it { is_expected.to contain_file('/usr/local/etc/transmission/home/Downloads') }

          when /Debian/
            it { is_expected.to contain_file('transmission_temp_settings').with({
              :path => '/var/lib/transmission-daemon/info/settings.tmp.json',
            })}

            [
              '^ENABLE_DAEMON=1$',
              '^CONFIG_DIR="/var/lib/transmission-daemon/info"$',
              '^OPTIONS="--config-dir \$CONFIG_DIR "$',
            ].each do |content|
              it { is_expected.to contain_file('/etc/default/transmission-daemon').with({
                :content => /#{content}/,
              })}
            end

            it { is_expected.to contain_file('/var/lib/transmission-daemon/downloads') }

          end

        end

      end
    end

  end
end
