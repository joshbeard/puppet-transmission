require 'spec_helper'

describe 'transmission' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do

        let(:facts) do
          facts
        end

        context "transmission class without any parameters" do
          let(:params) {{ }}

          it { should contain_class('transmission') }
        end

      end
    end
  end

end
