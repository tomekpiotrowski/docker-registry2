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
server_ip = node['docker_registry2']['server_ip']

execute "Change /etc/hosts: #{server_ip} #{domain_name}" do
  command "echo #{server_ip} #{domain_name} >> /etc/hosts"
  action :run
  not_if "grep '^#{server_ip} #{domain_name}' /etc/hosts"
end

%w(
 /usr/local/share/ca-certificates/
 /usr/local/share/ca-certificates/docker-dev-cert).each do |x|
  directory x do
    owner 'root'
    group 'root'
    mode 00755
    action :create
  end
end

cookbook_file '/usr/local/share/ca-certificates/docker-dev-cert/devdockerCA.crt' do
  source 'devdockerCA.crt'
  owner 'root'
  group 'root'
  notifies :run, 'execute[update-ca-certificates]', :delayed
end

execute 'update-ca-certificates' do
  command 'update-ca-certificates --fresh'
  action :nothing
end
