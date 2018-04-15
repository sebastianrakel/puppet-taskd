Vagrant.configure("2") do |config|
	config.vm.provider "libvirt"
	config.vm.define :puppet_taskd do |v|
		v.vm.hostname = "puppet-taskd"
		v.vm.box = "debian-stretch-puppet"
		v.vm.network :private_network,
			:ip => '192.168.254.2'
		# v.vm.provision "file",
		# 	source: ".",
		# 	destination: "/tmp/modules/taskd"
		v.vm.synced_folder "data", "/tmp/vagrant-puppet/data",
			owner: "vagrant",
			group: "vagrant",
			mount_options: [ "dmode=775,fmode=664" ]
		v.vm.provision :puppet, :options => [ "--yamldir /data" ] do |puppet|
			puppet.manifests_path = "examples"
			puppet.manifest_file = "init.pp"
			puppet.module_path = [ "." ]
			puppet.hiera_config_path = "hiera.yaml"
			puppet.working_directory = "/tmp/vagrant-puppet"
		end
	end
end
