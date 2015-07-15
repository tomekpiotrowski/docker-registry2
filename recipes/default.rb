# -*- encoding: utf-8 -*-
#
# Cookbook Name:: docker-registry2
# Recipe:: default
#
# Copyright 2015, http://DennyZhang.com
#
# Apache License, Version 2.0
#

include_recipe 'docker-registry2::server_certificates'
include_recipe 'docker-registry2::client_certificates'
include_recipe 'docker-registry2::install'
