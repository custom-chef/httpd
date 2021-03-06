#
# Cookbook:: httpd
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

package "httpd24" do
      action :install
end

service "httpd" do
      action [ :enable, :start ]
end

template "/etc/httpd/conf/httpd.conf" do
    owner "root"
    mode 0644
    source "httpd.conf.erb"
    notifies :reload, "service[httpd]"
end

template "/etc/httpd/conf.d/vhost.conf" do
    owner "root"
    mode 0644
    source "vhost.conf.erb"
    notifies :reload, "service[httpd]"
end

file "/etc/httpd/conf.d/welcome.conf" do
    action :delete
end

file "/etc/httpd/conf.d/autoindex.conf" do
    action :delete
end

group "deploy" do
    action :modify
    members ['deploy,apache']
end
