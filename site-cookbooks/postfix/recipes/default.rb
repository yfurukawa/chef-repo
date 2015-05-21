#
# Cookbook Name:: postfix
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package "postfix" do
	action :install
end

template "/etc/postfix/main.cf" do
	source "main.cf.erb"
	variables(
		:hostname => node[:hostname],
		:domain => node["postfix"]["domain"]
	)
        notifies :restart, "service[postfix]"
end

service "postfix" do
	action [:start, :enable]
end

