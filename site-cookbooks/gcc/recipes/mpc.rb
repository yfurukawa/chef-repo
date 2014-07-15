#
# Cookbook Name:: gcc
# Recipe:: mpc
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

execute "mpc_#{node['mpc']['version']}#{node['mpc']['version_prefix']}" do
	command <<-EOH
		cd /tmp
		wget #{node['mpc']['mpc_url']}/mpc-#{node['mpc']['version']}#{node['mpc']['version_prefix']}.tar.gz
		tar xzf mpc-#{node['mpc']['version']}#{node['mpc']['version_prefix']}.tar.gz
		cd mpc-#{node['mpc']['version']}
		./configure --prefix=#{node['gnu']['prefix']} --libdir=#{node['gnu']['prefix']}/#{node['gnu']['libdir']} --with-gmp-include=#{node['gnu']['prefix']}/#{node['gnu']['include']} --with-gmp-lib=#{node['gnu']['prefix']}/#{node['gnu']['libdir']} --with-mpfr-include=#{node['gnu']['prefix']}/#{node['gnu']['include']} --with-mpfr-lib=#{node['gnu']['prefix']}/#{node['gnu']['libdir']}
		make -j4
		make check
		make install
		cd ..
	EOH
	not_if { File.exists?("#{node['gnu']['prefix']}/#{node['gnu']['libdir']}/libmpc.a") }
end
