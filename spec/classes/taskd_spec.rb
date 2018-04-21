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

      case os
      when %r{^debian}i
        taskd_data_root = '/var/lib/taskd'
        taskd_config = '/etc/taskd/config'
        taskd_service_name = 'taskd'
        taskd_user = 'Debian-taskd'
        taskd_group = 'Debian-taskd'
        taskd_package_name = 'taskd'

      when %r{^ubuntu}i
        taskd_data_root = '/var/lib/taskd'
        taskd_config = '/etc/taskd/config'
        taskd_service_name = 'taskd'
        taskd_user = 'Debian-taskd'
        taskd_group = 'Debian-taskd'
        taskd_package_name = 'taskd'

      end

      it { is_expected.to compile }
      it { is_expected.to contain_file(taskd_config).that_notifies('Service[' + taskd_service_name + ']') }
      it do
        is_expected.to contain_file(taskd_config).with(
          ensure: 'present',
          owner: taskd_user,
          group: taskd_group,
        )
      end

      it do
        is_expected.to contain_file(taskd_data_root).with(
          ensure: 'directory',
          owner: taskd_user,
          group: taskd_group,
        )
      end

      it do
        is_expected.to contain_file(taskd_data_root + '/orgs').with(
          ensure: 'directory',
          owner: taskd_user,
          group: taskd_group,
        )
      end

      it do
        is_expected.to contain_service(taskd_service_name).with(
          ensure: 'running',
          enable: true,
        )
      end

      it { is_expected.to contain_service(taskd_service_name).that_requires('Package[' + taskd_package_name + ']') }

      context 'with generate_certificates => true' do
        let(:params) do
          super().merge('generate_certificates' => true)
        end

        it { is_expected.to contain_file(taskd_data_root + '/vars') }
        it { is_expected.to contain_exec('Generate taskserver ca certificates') }
        it { is_expected.to contain_exec('Generate taskserver server certificates') }
        it { is_expected.to contain_exec('Generate taskserver client certificates') }
        it { is_expected.to contain_exec('Generate taskserver revocation list') }
      end

      context 'with generate_certificates => false' do
        let(:params) do
          super().merge('generate_certificates' => false)
        end

        it { is_expected.not_to contain_file(taskd_data_root + '/vars') }
        it { is_expected.not_to contain_exec('Generate taskserver ca certificates') }
        it { is_expected.not_to contain_exec('Generate taskserver server certificates') }
        it { is_expected.not_to contain_exec('Generate taskserver client certificates') }
        it { is_expected.not_to contain_exec('Generate taskserver revocation list') }
      end
    end
  end
end
#  vim: set ts=2 sw=2 tw=0 et :
