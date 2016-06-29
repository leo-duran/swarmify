# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.define "manager1" do |linux|
    linux.vm.box = "ubuntu/trusty64"
    linux.vm.provision :shell, path: "./manager.sh"
    linux.vm.host_name = 'manager1'

    linux.vm.network "private_network", ip: "192.168.77.110"

    linux.vm.provider "virtualbox" do |v|
      v.memory = 2048
      v.cpus = 2
    end
  end

  config.vm.define "worker1" do |linux|
    linux.vm.box = "ubuntu/trusty64"
    linux.vm.provision :shell, path: "./worker.sh"
    linux.vm.host_name = 'worker1'

    linux.vm.network "private_network", ip: "192.168.77.120"

    linux.vm.provider "virtualbox" do |v|
      v.memory = 1024
      v.cpus = 2
    end
  end

  config.vm.define "worker2" do |linux|
    linux.vm.box = "ubuntu/trusty64"
    linux.vm.provision :shell, path: "./worker.sh"
    linux.vm.host_name = 'worker2'

    linux.vm.network "private_network", ip: "192.168.77.121"

    linux.vm.provider "virtualbox" do |v|
      v.memory = 1024
      v.cpus = 2
    end
  end
end
