# -*- encoding: utf-8 -*-
default['docker_registry2']['domain_name'] = 'www.testdocker.com'
default['docker_registry2']['username'] = 'mydocker'
default['docker_registry2']['password'] = 'dockerpasswd'

# Make sure parent directory of image_dir exists
default['docker_registry2']['image_dir'] = '/var/docker-registry'
