require 'spec_helper'

describe 'taskd::user' do
  let(:title) { 'namevar' }
  let(:params) do
    {}
  end

  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      it do
        is_expected.to compile
        is_expected.to contain_file('/var/lib/taskd/orgs')
      end
    end
  end
end
