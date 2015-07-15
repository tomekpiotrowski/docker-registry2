# Encoding: utf-8
require 'serverspec'

# Required by serverspec
set :backend, :exec

#####################################################
# verify service running 
describe port(5000) do
  it { should be_listening }
end

describe port(8080) do
  it { should be_listening }
end

describe service('nginx') do
  it { should be_enabled }
end

describe service('nginx') do
  it { should be_running }
end

describe service('docker-registry') do
  it { should be_enabled }
end

describe service('docker-registry') do
  it { should be_running }
end

########################################################################
chef_data = JSON.parse(IO.read("/tmp/kitchen/dna.json"))
username = chef_data.fetch('docker_registry2').fetch('username')
password = chef_data.fetch('docker_registry2').fetch('password')
domain_name = chef_data.fetch('docker_registry2').fetch('domain_name')

describe command('curl --noproxy 127.0.0.1 -I https://' + username + ':' + password + \
                 '@' + domain_name + ':8080 2>/dev/null | grep HTTP') do
  its(:stdout) { should match /HTTP\/1.1 401 Unauthorized/ }
end
