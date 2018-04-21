require 'spec_helper'

describe 'taskd::user' do
  let(:title) { 'namevar' }

  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }
      let(:params) do
        {
          'user' => 'alice',
          'org' => 'acme',
        }
      end

      case os
      when %r{^debian}i
        taskd_data_root = '/var/lib/taskd'
        taskd_user = 'Debian-taskd'

      when %r{^ubuntu}i
        taskd_data_root = '/var/lib/taskd'
        taskd_user = 'Debian-taskd'

      end

      it do
        is_expected.to compile
      end

      context 'with ensure => present' do
        let(:params) do
          super().merge('ensure' => 'present')
        end

        it { is_expected.to contain_exec("Create org #{params['org']} if necessary").with_user(taskd_user) }
        it { is_expected.to contain_exec("Create user #{params['user']} if necessary").with_user(taskd_user) }
        it do
          is_expected.to contain_exec("Create certificate for #{params['user']} if necessary").with(
            'cwd'     => taskd_data_root,
            'user'    => taskd_user,
            'creates' => "#{taskd_data_root}/#{params['org']}_#{params['user']}.cert.pem",
          )
        end

        it { is_expected.not_to contain_exec("Delete user #{params['user']} if necessary") }
        it { is_expected.not_to contain_exec("Delete certificate for #{params['user']}") }
        it { is_expected.not_to contain_exec("Delete org #{params['org']} if empty") }
      end

      context 'with ensure => absent' do
        let(:params) do
          super().merge('ensure' => 'absent')
        end

        it { is_expected.not_to contain_exec("Create org #{params['org']} if necessary") }
        it { is_expected.not_to contain_exec("Create user #{params['user']} if necessary") }
        it { is_expected.not_to contain_exec("Create certificate for #{params['user']} if necessary") }

        it { is_expected.to contain_exec("Delete user #{params['user']} if necessary") }
        it { is_expected.to contain_exec("Delete org #{params['org']} if empty") }

        it { is_expected.to contain_file("#{taskd_data_root}/#{params['org']}_#{params['user']}.cert.pem").with_ensure('absent') }
        it { is_expected.to contain_file("#{taskd_data_root}/#{params['org']}_#{params['user']}.key.pem").with_ensure('absent') }
      end
    end
  end
end
