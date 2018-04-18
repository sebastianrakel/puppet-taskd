require 'spec_helper'

describe 'taskd' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }
      let(:params) { {
        'pki_vars' => {
          'organization' => 'Testing Automation',
          'country' => 'DE',
          'state' => 'North Rhine-Westphalia',
          'locality' => 'Cologne',
        }
      } }
      it { is_expected.to compile }
    end
  end
end
