#
# Cookbook Name:: opencv
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

%w{opencv opencv-devel opencv-devel-docs}.each do |pkg|
	package pkg do
		action :install
	end
end

