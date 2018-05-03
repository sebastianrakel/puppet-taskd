supported_os = {
  'ubuntu1604' => 'generic/ubuntu1604',
  'ubuntu1610' => 'generic/ubuntu1610',
  'ubuntu1704' => 'generic/ubuntu1704',
  'ubuntu1710' => 'generic/ubuntu1710',
  'debian9' => 'debian/stretch64',
}

Vagrant.configure('2') do |config|
  config.vm.provider 'libvirt'
  supported_os.each do |(suffix, box)|
    hostname = "puppet-taskd-" + suffix
    config.vm.define hostname do |v|
      v.puppet_install.puppet_version = :latest
      v.vm.hostname = hostname
      v.vm.box = box
      v.vm.network :private_network, type: 'dhcp'
      v.vm.provision :shell, path: 'examples/vagrant/provision.sh'
      v.vm.provision :puppet,
        :options => [ '--yamldir /tmp/vagrant/data', '--modulepath /tmp/vagrant/modules' ] do |puppet|
        puppet.manifests_path = 'examples'
        puppet.manifest_file = 'init.pp'
        puppet.working_directory = '/tmp/vagrant'
      end
    end
  end
end

#  vim: set ts=2 sw=2 tw=0 et :
