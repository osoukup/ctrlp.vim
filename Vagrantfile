# -*- mode: ruby -*-
#
# raw VM for testing

Vagrant.configure("2") do |config|
    config.vm.define "vim-ctrlp-fedora"
    config.vm.box = "fedora/00-cloud-base"

    # only libvirt support
    config.vm.provider "libvirt" do |v|
        v.cpu_mode = 'host-passthrough'
        v.driver = "kvm"
        v.memory = 1024
        v.cpus = 1
    end

    # one-way rsync of this directory by default to /vagrant - link it to home dir
    # unfortunately I do not know how to sync it onto /home/vagrant without vagrant
    # aksing fot password so it is sysnced into it as /home/vagrant/vagrant
    config.vm.provision "shell", inline: "yum install -y vim ; rpm -ivh /vagrant/*.rpm"

    # welcome message
    config.vm.post_up_message = "run vim and <ctrl>p to test that it works"
end
