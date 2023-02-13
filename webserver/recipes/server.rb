#
# Cookbook:: webserver
# Recipe:: server
#
# Copyright:: 2023, The Authors, All Rights Reserved.
package 'openssl'
package 'httpd' do
  action :install
end

service 'httpd' do
  action [:start, :enable]
end
execute 'generate-certificate' do
  command "openssl req -new -newkey rsa:2048 -days 365 -nodes -x509 -keyout /etc/ssl/private/web-server.key -out /etc/ssl/certs/web-server.crt -subj '/CN=18.144.49.164/OU=EC2 Server'"
  not_if { ::File.exist?('/etc/ssl/private/web-server.key') && ::File.exist?('/etc/ssl/certs/web-server.crt') }
end

template '/etc/httpd/conf/ssl.conf' do
  source 'ssl.erb'
  variables(
    ssl_cert: '/etc/ssl/certs/web-server.crt',
    ssl_key: '/etc/ssl/private/web-server.key'
  )
  notifies :restart, 'service[httpd]'
end

template '/etc/httpd/conf/httpd.conf' do
  source 'httpd.erb'
  notifies :restart, 'service[httpd]'
end

file '/var/www/html/index.html' do
  content '<html>
<head>
<title>Hello World</title>
</head>
<body>
<h1>Hello World!</h1>
</body>
</html>'
end
