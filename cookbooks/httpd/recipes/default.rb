#
# Cookbook Name:: httpd
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

%w{httpd httpd-devel}.each do |pkg|
	package pkg do
		action :install
	end
end

service "httpd" do
	action [ :enable, :start ]
end

