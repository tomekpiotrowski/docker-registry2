# -*- encoding: utf-8 -*-
#
# Cookbook Name:: docker-registry2
# Recipe:: default
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

# TODO: notify nginx restart
template '/etc/nginx/docker-registry.htpasswd' do
  source 'htpasswd.erb'
end

# TODO: Set Up SSL

directory '/root/certs' do
  owner 'root'
  group 'root'
  mode 00755
  action :create
end

# TODO: 
# openssl genrsa -out devdockerCA.key 2048
# openssl req -x509 -new -nodes -key devdockerCA.key -days 10000 -out devdockerCA.crt
# openssl genrsa -out dev-docker-registry.com.key 2048
# openssl req -new -key dev-docker-registry.com.key -out dev-docker-registry.com.csr
# openssl x509 -req -in dev-docker-registry.com.csr -CA devdockerCA.crt -CAkey devdockerCA.key -CAcreateserial -out dev-docker-registry.com.crt -days 10000
# sudo cp dev-docker-registry.com.crt /etc/ssl/certs/docker-registry
# sudo cp dev-docker-registry.com.key /etc/ssl/private/docker-registry
# sudo mkdir /usr/local/share/ca-certificates/docker-dev-cert
# sudo cp devdockerCA.crt /usr/local/share/ca-certificates/docker-dev-cert
# sudo update-ca-certificates

template '/etc/nginx/sites-enabled/docker-registry-vhost' do
  source 'docker-registry-vhost.erb'
  # TODO: notify nginx restart
end
