# InSpec test for recipe webserver::server

# The InSpec reference, with examples and extensive documentation, can be
# found at https://docs.chef.io/inspec/resources/

require 'chefspec'


describe 'my_cookbook::server' do
  let(:chef_run) { ChefSpec::SoloRunner.converge(described_recipe) }

  it 'installs the httpd package' do
    expect(chef_run).to install_package('httpd')
  end

  it 'installs the openssl package' do
    expect(chef_run).to install_package('openssl')
  end

  it 'enables the httpd service' do
    expect(chef_run).to enable_service('httpd')
  end

  it 'starts the httpd service' do
    expect(chef_run).to start_service('httpd')
  end

  it 'redirects HTTP requests to HTTPS' do
    expect(chef_run).to write_log('Redirecting HTTP to HTTPS.').with_message(/Redirecting from http to https/)
  end

  it 'creates the HTML file' do
    expect(chef_run).to render_file('/var/www/html/index.html').with_content(/<h1>Hello World!<\/h1>/)
  end

  it 'configures SSL' do
    expect(chef_run).to render_file('/etc/httpd/conf.d/ssl.erb').with_content(/SSLEngine on/)
  end

  it 'secures the application' do
    expect(chef_run).to render_file('/etc/httpd/conf/httpd.erb').with_content(/Listen 443/)
  end

  it 'generates a self-signed certificate' do
    expect(chef_run).to run_execute('generate self-signed certificate')
  end
  
end

