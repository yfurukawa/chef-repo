#
# Cookbook Name:: xgdm_setting
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

template "custom.conf" do
	path "/etc/gdm/custom.conf"
	source "custom.conf.erb"
	mode 0644
	owner "root"
	group "root"
end

