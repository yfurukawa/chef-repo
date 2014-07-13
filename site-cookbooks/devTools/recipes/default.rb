#
# Cookbook Name:: devTools
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

execute "devTools" do
	command 'yum -y groupinstall "Development Tools"'
	action :run
end

