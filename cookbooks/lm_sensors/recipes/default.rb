#
# Cookbook Name:: lm_sensors
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

execute "lm_sensors" do
	command <<-EOH
		cd #{Chef::Config[:file_cache_path]}
		wget #{node['lm_sensors']['download_url']}/lm_sensors-#{node['lm_sensors']['version']}.tar.bz2
		tar xjf lm_sensors-#{node['lm_sensors']['version']}.tar.bz2
		cd lm_sensors-#{node['lm_sensors']['version']}
		make
		make install
	EOH
	not_if{ File.exists?("#{node['lm_sensors']['prefix']}/lib/libsensors.a") }
end

