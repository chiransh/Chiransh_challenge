# InSpec test for recipe webserver::server

# The InSpec reference, with examples and extensive documentation, can be
# found at https://docs.chef.io/inspec/resources/

require 'chefspec'


describe 'my_cookbook::server' do
  let(:chef_run) { ChefSpec::SoloRunner.converge(described_recipe) }

  it 'installs the httpd package' do
    expect(chef_run).to install_package('httpd')
  end

  it 'enables the openssl service' do
    expect(chef_run).to enable_service('openssl')
  end

  it 'starts the httpd service' do
    expect(chef_run).to start_service('httpd')
  end

  it 'redirects HTTP requests to HTTPS' do
    expect(chef_run).to write_log('Redirecting HTTP to HTTPS.').with_message(/Redirecting from http to https/)
  end

  
end

