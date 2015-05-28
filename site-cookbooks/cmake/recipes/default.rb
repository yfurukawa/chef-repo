#
# Cookbook Name:: cmake
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

%w{cmake cmake-gui}.each do |pkg|
	package pkg do
		action :install
	end
end

