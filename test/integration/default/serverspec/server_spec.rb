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

# TODO: curl https://USERNAME:PASSWORD@YOUR-DOMAIN:8080
