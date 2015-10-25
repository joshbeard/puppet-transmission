require 'spec_helper'

describe 'transmission::install' do
  context 'supported operating systems' do

    on_supported_os.each do |os, facts|
      context "on #{os}" do

        let(:facts) do
          facts
        end

        context 'with defaults' do
          let :pre_condition do
            "class { 'transmission': }"
          end

          case facts[:osfamily]
          when /RedHat/i
            it { is_expected.to contain_user('transmission').with({
              :home  => '/var/lib/transmission/.config/transmission',
              :shell => '/sbin/nologin',
              :gid   => 'transmission',
            })}

            it { is_expected.to contain_group('transmission') }

          when /FreeBSD/
            it { is_expected.to contain_user('transmission').with({
              :home  => '/usr/local/etc/transmission/home',
              :shell => '/usr/sbin/nologin',
              :gid   => 'transmission',
            })}

            it { is_expected.to contain_group('transmission') }
            it { is_expected.to contain_package('transmission-web') }
          when /Debian/
            it { is_expected.to contain_user('debian-transmission').with({
              :home  => '/var/lib/transmission-daemon/info',
              :shell => '/bin/false',
              :gid   => 'debian-transmission',
            })}

            it { is_expected.to contain_group('debian-transmission') }
          end

          it { is_expected.to contain_package('transmission-cli') }
          it { is_expected.to contain_package('transmission-daemon') }
        end

        context 'customized' do
          describe 'without managing user or group' do
            let :pre_condition do
              "class { 'transmission': manage_user => false, manage_group => false }"
            end
            it { is_expected.not_to contain_user }
            it { is_expected.not_to contain_group }
          end

          describe 'package list' do
            let :pre_condition do
              "class { 'transmission': package_list => ['one', 'two'] }"
            end
            it { is_expected.to contain_package('one') }
            it { is_expected.to contain_package('two') }
          end
        end


      end
    end

  end
end
