Vagrant.configure('2') do |config|
  config.puppet_install.puppet_version = :latest
  config.vm.provider 'libvirt'
  config.vm.define :puppet_taskd do |v|
    v.vm.hostname = 'puppet-taskd'
    v.vm.box = 'debian/stretch64'
    v.vm.network :private_network,
      :ip => '192.168.254.2'
    # v.vm.provision "file",
    #   source: ".",
    #   destination: "/tmp/modules/taskd"
    # v.vm.synced_folder "data", "/tmp/vagrant-puppet/data",
    #   owner: "vagrant",
    #   group: "vagrant",
    #   mount_options: [ "dmode=775,fmode=664" ]
    # v.librarian_puppet.puppetfile_dir = "examples"
    # v.librarian_puppet.placeholder_filename = ".gitkeep"
    v.vm.provision :shell, path: 'examples/vagrant/provision.sh'
    # v.vm.provision :puppet, :options => [ "--yamldir /tmp/vagrant/data", "--modulepath /tmp/vagrant/modules" ] do |puppet|
    v.vm.provision :puppet, :options => [ '--yamldir /tmp/vagrant/data', '--modulepath /tmp/vagrant/modules' ] do |puppet|
      puppet.manifests_path = 'examples'
      puppet.manifest_file = 'init.pp'
      # puppet.hiera_config_path = 'hiera.yaml'
      puppet.working_directory = "/tmp/vagrant"
    end
  end
end
