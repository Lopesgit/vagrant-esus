# -*- mode: ruby -*-
# vi: set ft=ruby :

$init_esus = <<SCRIPT
esus start
SCRIPT

Vagrant.configure(2) do |config|
  config.vm.define "esusab" do |esus|
    esus.vm.box = "ubuntu/xenial64"
    esus.vm.hostname = "esusab"
    esus.vm.network "forwarded_port", guest: 8080, host: 8080, auto_correct: true
    esus.vm.network "forwarded_port", guest: 5433, host: 5433, auto_correct: true
    esus.vm.synced_folder "esus_backups/", "/home/ubuntu/esus_backups"
    # esus.vm.network :private_network, ip: "192.168.33.20"
  end

  config.vm.provider :virtualbox do |vb|
    vb.name = "eSUSAB"
    vb.memory = 2048
    vb.cpus = 1
  end

  config.vm.provision :shell, path: "esus_install.sh"
  config.vm.provision :shell, run: "always", inline: $init_esus

  if Vagrant.has_plugin?("vagrant-proxyconf")
    config.proxy.http     = "http://192.168.0.254:3128"
    config.proxy.https    = "http://192.168.0.254:3128"
    config.proxy.no_proxy = "localhost,127.0.0.1"
  end

  config.trigger.before :halt do
    run_remote  "esus stop"
  end
end
