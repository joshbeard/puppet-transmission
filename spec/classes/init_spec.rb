require 'spec_helper'

describe 'transmission' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do

        let(:facts) do
          facts
        end

        context "transmission class with default parameters" do
          let(:params) {{ }}

          it { is_expected.to contain_class('transmission') }
          it { is_expected.to contain_class('transmission::install') }
          it { is_expected.to contain_class('transmission::config').that_requires('Class[transmission::install]') }
          it { is_expected.to contain_class('transmission::service').that_subscribes_to('Class[transmission::config]') }
        end

        context 'invalid parameters' do
          context 'with invalid parameters' do

            %w(conf_dir shell).each do |path|
              describe path do
                let(:params) {{ path => 'invalid/path' }}
                it { expect { catalogue }.to raise_error(Puppet::Error, /not an absolute path/) }
              end
            end

            %w(manage_user manage_group manage_service service_enable).each do |bool|
              describe bool do
                let(:params) {{ bool => 'invalid_bool' }}
                it { expect { catalogue }.to raise_error(Puppet::Error, /not a boolean/) }
              end
            end

            %w(user group).each do |param|
              describe param do
                let(:params) {{ param => 'not*valid' }}
                it { expect { catalogue }.to raise_error(Puppet::Error, /does not match/) }
              end
            end

            describe 'service_ensure' do
              let(:params) {{ :service_ensure => 'umm' }}
              it { expect { catalogue }.to raise_error(Puppet::Error, /does not match/) }
            end

            describe 'settings' do
              let(:params) {{ :settings => ['one', 'two'] }}
              it { expect { catalogue }.to raise_error(Puppet::Error, /is not a Hash/) }
            end

            describe 'startup_opts' do
              let(:params) {{ :startup_opts => 'not an array' }}
              it { expect { catalogue }.to raise_error(Puppet::Error, /is not an Array/) }
            end

            describe 'incomplete-dir-enabled' do
              let(:params) {{ :settings => { 'incomplete-dir-enabled' => 'yeah' } }}
              it { expect { catalogue }.to raise_error(Puppet::Error, /not a boolean/) }
            end

            describe 'download-dir' do
              let(:params) {{ :settings => { 'download-dir' => 'yeah' } }}
              it { expect { catalogue }.to raise_error(Puppet::Error, /not an absolute path/) }
            end

          end
        end

      end
    end
  end


end
