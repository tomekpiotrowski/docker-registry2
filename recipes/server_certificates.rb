# -*- encoding: utf-8 -*-
#
# Cookbook Name:: docker-registry2
# Recipe:: server_certificates
#
# Copyright 2015, http://DennyZhang.com
#
# Apache License, Version 2.0
#

%w(/root/certs directory node['docker_registry2']['image_dir']).each do |x|
  directory x do
    owner 'root'
    group 'root'
    mode 00755
    action :create
  end
end

%w(
 dev-docker-registry.com.crt dev-docker-registry.com.csr
 dev-docker-registry.com.key devdockerCA.key
 devdockerCA.srl devdockerCA.crt).each do |x|
  cookbook_file "/root/certs/#{x}" do
    source x
    owner 'root'
    group 'root'
  end
end

cookbook_file '/etc/ssl/certs/docker-registry' do
  source 'dev-docker-registry.com.crt'
  owner 'root'
  group 'root'
end

cookbook_file '/etc/ssl/private/docker-registry' do
  source 'dev-docker-registry.com.key'
  owner 'root'
  group 'root'
end
