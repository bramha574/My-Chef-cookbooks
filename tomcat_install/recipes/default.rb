#
# Cookbook:: tomcat_install
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.


package 'java-1.7.0-openjdk-devel'

group 'tomcat'

user 'tomcat' do
	manage_home false
	shell '/bin/nologin'
        group 'tomcat'
        home '/opt/tomcat'
end


#execute 'wget http://apache.mirrors.ionfish.org/tomcat/tomcat-8/v8.0.45/bin/apache-tomcat-8.0.45.tar.gz'
remote_file 'apache-tomcat-8.0.45.tar.gz' do
	source 'http://apache.mirrors.ionfish.org/tomcat/tomcat-8/v8.0.45/bin/apache-tomcat-8.0.45.tar.gz'
end

directory '/opt/tomcat' do
	#action :create
	group 'tomcat'
end

execute 'tar xvf apache-tomcat-8*tar.gz -C /opt/tomcat --strip-components=1'

directory '/opt/tomcat/conf' do
        mode '0777'
end

execute 'chgrp -R tomcat /opt/tomcat/conf'

execute 'chmod g+rwx /opt/tomcat/conf/*'

execute 'chown -R tomcat /opt/tomcat/webapps/ /opt/tomcat/work/ /opt/tomcat/temp/ /opt/tomcat/logs/'

template '/etc/systemd/system/tomcat.service' do
	source 'tomcat.service.erb'	
end

template '/opt/tomcat/conf/tomcat-users.xml' do
	source 'tomcat-users.xml.erb'
end

execute 'systemctl daemon-reload'

service 'tomcat' do
	action [:start, :enable]
end

