#
# Cookbook Name:: PySensors
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

execute "PySensors" do
	command <<-EOH
		cd #{Chef::Config[:file_cache_path]}
		wget #{node['PySensors']['download_url']}/PySensors-#{node['PySensors']['version']}.tar.gz
		tar xzf PySensors-#{node['PySensors']['version']}.tar.gz
		cd PySensors-#{node['PySensors']['version']}
		python setup.py build
		python setup.py install
	EOH
	not_if{ Dir.exists?("/usr/lib/python2.6/site-packages/sensors") }
end

