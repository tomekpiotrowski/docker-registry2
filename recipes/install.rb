# -*- encoding: utf-8 -*-
#
# Cookbook Name:: docker-registry2
# Recipe:: install
#
# Copyright 2015, http://DennyZhang.com
#
# Apache License, Version 2.0
#
%w(
 build-essential python-dev libevent-dev python-pip liblzma-dev
 openssl libssl-dev swig nginx apache2-utils).each do |x|
  package x do
    action :install
  end
end

%w(python-pip).each do |x|
  package x do
    action :install
  end
end

python_pip 'docker-registry'

template '/usr/local/lib/python2.7/dist-packages/config/config.yml' do
  source 'config.yml.erb'
end

include_recipe 'nginx'

htpasswd '/etc/nginx/docker-registry.htpasswd' do
  user node['docker_registry2']['username']
  password node['docker_registry2']['password']
  notifies :restart, 'service[nginx]', :delayed
end

directory '/root/certs' do
  owner 'root'
  group 'root'
  mode 00755
  action :create
end

template '/etc/nginx/sites-enabled/docker-registry-vhost' do
  source 'docker-registry-vhost.erb'
  notifies :restart, 'service[nginx]', :delayed
end

directory '/var/log/docker-registry' do
  owner 'root'
  group 'root'
  mode 00755
  action :create
end

service 'nginx' do
  supports status: true
  action [:enable, :start]
end

template '/etc/init.d/docker-registry' do
  source 'docker-registry.initscript'
  mode 00755
  notifies :restart, 'service[docker-registry]', :delayed
end

service 'docker-registry' do
  supports status: true
  action [:enable, :start]
end
