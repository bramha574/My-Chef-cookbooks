
# Cookbook:: httpd
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.
#



package 'httpd'

template '/usr/share/httpd/noindex/index.html' do
	source 'index.html.erb'
end

service 'httpd' do
	action [:start, :enable]
end
