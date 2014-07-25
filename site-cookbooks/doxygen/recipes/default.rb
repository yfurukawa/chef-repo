#
# Cookbook Name:: doxygen
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

execute "Download src file" do
	command <<-EOH
		cd #{Chef::Config[:file_cache_path]}
		wget #{node['doxygen']['download_url']}/doxygen-#{node['doxygen']['version']}.src.tar.gz
	EOH
	not_if { File.exists?( "#{Chef::Config[:file_cache_path]}/doxygen-#{node['doxygen']['version']}.src.tar.gz" ) }
end

execute "Install Doxygen" do
	command <<-EOH
		cd #{Chef::Config[:file_cache_path]}
		tar xzf doxygen-#{node['doxygen']['version']}.src.tar.gz
		cd doxygen-#{node['doxygen']['version']}
		./configure --prefix #{node['doxygen']['install_dir']}
		make
		make install
	EOH
	not_if { File.exists?( "#{node['doxygen']['install_dir']}/bin/doxygen" ) }
end

