#
# Cookbook Name:: prepareForRedmine
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
#
%w{openssl-devel readline-devel zlib-devel curl-devel libyaml-devel}.each do |pkg|
	package pkg do
		action :install
	end
end

group node['redmine']['group'] do
	group_name node['redmine']['group']
	gid 1000
	action :create
end

user_home = "/home/#{node['redmine']['user']}"
user node['redmine']['user'] do
	uid 1000
	group node['redmine']['group']
	shell "/bin/bash"
	home user_home
	password nil
	supports :manage_home => true
	system true
	action [:create, :manage]
end

