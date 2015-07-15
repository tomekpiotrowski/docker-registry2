# -*- encoding: utf-8 -*-
#
# Cookbook Name:: docker-registry2
# Recipe:: ssl_certificates
#
# Copyright 2015, http://DennyZhang.com
#
# Apache License, Version 2.0
#

%w(
 /root/certs /usr/local/share/ca-certificates/
 /usr/local/share/ca-certificates/docker-dev-cert).each do |x|
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
  cookbook_file x do
    source x
    owner 'root'
    group 'root'
  end
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
