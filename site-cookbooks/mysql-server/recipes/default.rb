#
# Cookbook Name:: mysql-server
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

%w{mysql-server mysql-devel}.each do |pkg|
	package pkg do
		action :install
	end
end

template "my.cnf.erb" do
	path "/etc/my.cnf"
	source "my.cnf.erb"
	owner "root"
	group "root"
	mode 0644
end

service "mysqld" do
	action [ :enable, :start]
end

execute "set root password" do
	#command "mysqladmin -u root password '#{node['mysql']['server_root_password']}'"
	command "mysqladmin -u root password 'Ken6en'"
	only_if "mysql -u root -e 'show databases;'"
end

directory "/home/mysql" do
	owner node['mysql']['user']
	group node['mysql']['group']
	mode 00755
	action :create
	not_if { Dir.exists?("/home/#{node['mysql']['user']}") }
end
