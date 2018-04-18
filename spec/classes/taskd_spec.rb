require 'spec_helper'

describe 'taskd' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }
      let(:params) do
        {
          'pki_vars' => {
            'organization' => 'Testing Automation',
            'country' => 'DE',
            'state' => 'North Rhine-Westphalia',
            'locality' => 'Cologne',
            'cn' => 'somename.example.com',
            'bits' => 4096,
            'expiration_days' => 3650,
          },
        }
      end

      it { is_expected.to compile }
    end
  end
end
