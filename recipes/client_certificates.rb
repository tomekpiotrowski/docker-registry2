# -*- encoding: utf-8 -*-
#
# Cookbook Name:: docker-registry2
# Recipe:: client_certificates
#
# Copyright 2015, http://DennyZhang.com
#
# Apache License, Version 2.0
#

# change /etc/hosts
domain_name = node['docker_registry2']['domain_name']

execute "Change /etc/hosts: 127.0.0.1 #{domain_name}" do
  command "echo 127.0.0.1 #{domain_name} >> /etc/hosts"
  action :run
  not_if "grep '^127.0.0.1 #{domain_name}' /etc/hosts"
end

cookbook_file '/usr/local/share/ca-certificates/docker-dev-cert/devdockerCA.crt' do
  source 'devdockerCA.crt'
  owner 'root'
  group 'root'
  notifies :run, 'execute[update-ca-certificates]', :delayed
end

execute 'update-ca-certificates' do
  command 'update-ca-certificates'
  action :nothing
end
