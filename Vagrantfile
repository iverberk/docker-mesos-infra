Vagrant.configure(2) do |config|
  
  config.vm.define :mm1 do |mm1|
    mm1.vm.box = "ubuntu/trusty64"
    mm1.vm.hostname = "mm1.localdomain"
  
    mm1.vm.provision :puppet do |puppet|
      puppet.facter = {
        "fqdn" => "mm1.localdomain",
      }
      puppet.manifests_path = "puppet/manifests"
      puppet.module_path = ["puppet/modules", "puppet/custom"]
      puppet.manifest_file  = "mesos_master.pp"
      puppet.hiera_config_path = "puppet/hiera.yaml"
      puppet.working_directory = "/tmp/vagrant-puppet"
      # puppet.options = "--verbose --debug"
    end

    mm1.vm.provider "virtualbox" do |v|
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--memory", "1024"]
    end

    mm1.vm.network :private_network, ip: "192.168.33.11"
  end

  config.vm.define :mm2 do |mm2|
    mm2.vm.box = "ubuntu/trusty64"
    mm2.vm.hostname = "mm2.localdomain"
  
    mm2.vm.provision :puppet do |puppet|
      puppet.facter = {
        "fqdn" => "mm2.localdomain",
      }
      puppet.manifests_path = "puppet/manifests"
      puppet.module_path = ["puppet/modules", "puppet/custom"]
      puppet.manifest_file  = "mesos_master.pp"
      puppet.hiera_config_path = "puppet/hiera.yaml"
      puppet.working_directory = "/tmp/vagrant-puppet"
    end

    mm2.vm.provider "virtualbox" do |v|
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--memory", "1024"]
    end

    mm2.vm.network :private_network, ip: "192.168.33.12"
  end

  config.vm.define :mm3 do |mm3|
    mm3.vm.box = "ubuntu/trusty64"
    mm3.vm.hostname = "mm3.localdomain"
  
    mm3.vm.provision :puppet do |puppet|
      puppet.facter = {
        "fqdn" => "mm3.localdomain",
      }
      puppet.manifests_path = "puppet/manifests"
      puppet.module_path = ["puppet/modules", "puppet/custom"]
      puppet.manifest_file  = "mesos_master.pp"
      puppet.hiera_config_path = "puppet/hiera.yaml"
      puppet.working_directory = "/tmp/vagrant-puppet"
    end

    mm3.vm.provider "virtualbox" do |v|
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--memory", "1024"]
    end

    mm3.vm.network :private_network, ip: "192.168.33.13"
  end

  config.vm.define :ms1 do |ms1|
    ms1.vm.box = "ubuntu/trusty64"
    ms1.vm.hostname = "ms1.localdomain"
  
    ms1.vm.provision :puppet do |puppet|
      puppet.facter = {
        "fqdn" => "ms1.localdomain",
      }
      puppet.manifests_path = "puppet/manifests"
      puppet.module_path = ["puppet/modules", "puppet/custom"]
      puppet.manifest_file  = "mesos_slave.pp"
      puppet.hiera_config_path = "puppet/hiera.yaml"
      puppet.working_directory = "/tmp/vagrant-puppet"
    end

    ms1.vm.provider "virtualbox" do |v|
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--memory", "1024"]
    end

    ms1.vm.network :private_network, ip: "192.168.33.14"
  end

  config.vm.define :ms2 do |ms2|
    ms2.vm.box = "ubuntu/trusty64"
    ms2.vm.hostname = "ms2.localdomain"
  
    ms2.vm.provision :puppet do |puppet|
      puppet.facter = {
        "fqdn" => "ms2.localdomain",
      }
      puppet.manifests_path = "puppet/manifests"
      puppet.module_path = ["puppet/modules", "puppet/custom"]
      puppet.manifest_file  = "mesos_slave.pp"
      puppet.hiera_config_path = "puppet/hiera.yaml"
      puppet.working_directory = "/tmp/vagrant-puppet"
    end

    ms2.vm.provider "virtualbox" do |v|
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--memory", "1024"]
    end

    ms2.vm.network :private_network, ip: "192.168.33.15"
  end

  config.vm.define :ms3 do |ms3|
    ms3.vm.box = "ubuntu/trusty64"
    ms3.vm.hostname = "ms3.localdomain"
  
    ms3.vm.provision :puppet do |puppet|
      puppet.facter = {
        "fqdn" => "ms3.localdomain",
      }
      puppet.manifests_path = "puppet/manifests"
      puppet.module_path = ["puppet/modules", "puppet/custom"]
      puppet.manifest_file  = "mesos_slave.pp"
      puppet.hiera_config_path = "puppet/hiera.yaml"
      puppet.working_directory = "/tmp/vagrant-puppet"
    end

    ms3.vm.provider "virtualbox" do |v|
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--memory", "1024"]
    end

    ms3.vm.network :private_network, ip: "192.168.33.16"
  end

  config.vm.define :ms4 do |ms4|
    ms4.vm.box = "ubuntu/trusty64"
    ms4.vm.hostname = "ms4.localdomain"
  
    ms4.vm.provision :puppet do |puppet|
      puppet.facter = {
        "fqdn" => "ms4.localdomain",
      }
      puppet.manifests_path = "puppet/manifests"
      puppet.module_path = ["puppet/modules", "puppet/custom"]
      puppet.manifest_file  = "mesos_slave.pp"
      puppet.hiera_config_path = "puppet/hiera.yaml"
      puppet.working_directory = "/tmp/vagrant-puppet"
    end

    ms4.vm.provider "virtualbox" do |v|
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--memory", "1024"]
    end

    ms4.vm.network :private_network, ip: "192.168.33.21"
  end

  config.vm.define :lb1 do |lb1|
    lb1.vm.box = "ubuntu/trusty64"
    lb1.vm.hostname = "lb1.localdomain"
  
    lb1.vm.provision :puppet do |puppet|
      puppet.facter = {
        "fqdn" => "lb1.localdomain",
      }
      puppet.manifests_path = "puppet/manifests"
      puppet.module_path = ["puppet/modules", "puppet/custom"]
      puppet.manifest_file  = "loadbalancer.pp"
      puppet.hiera_config_path = "puppet/hiera.yaml"
      puppet.working_directory = "/tmp/vagrant-puppet"
    end

    lb1.vm.provider "virtualbox" do |v|
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--memory", "512"]
    end

    lb1.vm.network :private_network, ip: "192.168.33.17"
  end

  config.vm.define :lb2 do |lb2|
    lb2.vm.box = "ubuntu/trusty64"
    lb2.vm.hostname = "lb2.localdomain"
  
    lb2.vm.provision :puppet do |puppet|
      puppet.facter = {
        "fqdn" => "lb2.localdomain",
      }
      puppet.manifests_path = "puppet/manifests"
      puppet.module_path = ["puppet/modules", "puppet/custom"]
      puppet.manifest_file  = "loadbalancer.pp"
      puppet.hiera_config_path = "puppet/hiera.yaml"
      puppet.working_directory = "/tmp/vagrant-puppet"
    end

    lb2.vm.provider "virtualbox" do |v|
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--memory", "512"]
    end

    lb2.vm.network :private_network, ip: "192.168.33.18"
  end

  config.vm.define :registry do |registry|
    registry.vm.box = "ubuntu/trusty64"
    registry.vm.hostname = "registry.localdomain"
  
    registry.vm.provision :puppet do |puppet|
      puppet.facter = {
        "fqdn" => "registry.localdomain",
      }
      puppet.manifests_path = "puppet/manifests"
      puppet.module_path = ["puppet/modules", "puppet/custom"]
      puppet.manifest_file  = "registry.pp"
      puppet.hiera_config_path = "puppet/hiera.yaml"
      puppet.working_directory = "/tmp/vagrant-puppet"
      # puppet.options = "--verbose --debug"
    end

    registry.vm.provider "virtualbox" do |v|
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--memory", "512"]
    end

    registry.vm.network :private_network, ip: "192.168.33.19"
  end

end
