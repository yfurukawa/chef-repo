#
# Cookbook Name:: gcc
# Recipe:: ldconf_update
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

template "gnu-tools.conf" do
	path "/etc/ld.so.conf.d/gnu-tools.conf"
	source "gnu-tools.conf.erb"
	mode 0644
	owner "root"
	group "root"
end

execute "ldUpdate" do
	command "ldconfig"
	action :run
end

