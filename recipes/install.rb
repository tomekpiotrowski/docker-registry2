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

# TODO: start service
# gunicorn --access-logfile - --debug -k gevent -b 0.0.0.0:5000 -w 1 docker_registry.wsgi:application
# gunicorn --access-logfile /var/log/docker-registry/access.log --error-logfile /var/log/docker-registry/server.log -k gevent --max-requests 100 --graceful-timeout 3600 -t 3600 -b localhost:5000 -w 8 docker_registry.wsgi:application
