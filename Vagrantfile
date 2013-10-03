# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "precise64"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"
  config.vm.synced_folder ".", "/vagrant", :nfs => true
  config.vm.provider :virtualbox do |vb|
    vb.gui = false
    vb.customize ["modifyvm", :id, "--memory", "1024"]
  end

  # Enable provisioning with shell script
  config.vm.provision :shell, :path => "bootstrap.sh"

  # Development
  config.vm.define :dev do |dev_config|
    dev_config.vm.network   :private_network, :ip => "192.168.185.4"
    dev_config.vm.provision :chef_solo do |chef|
      chef.cookbooks_path = "cookbooks"
      chef.roles_path     = "roles"
      chef.data_bags_path = "data_bags"
      chef.log_level      = :debug
      # Specify custom Run List:
      chef.add_role "basebox"
      chef.add_role "dev-box"
      # Specify custom JSON attributes:
      chef.json = {
        :projects => [
          { :name => "sample", :enabled => true }
        ]
      }
    end
  end

end
