#
# Cookbook Name:: gcc
# Recipe:: gcc
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

execute "gcc_#{node['gcc']['version']}#{node['gcc']['version_prefix']}" do
	command <<-EOH
		cd /tmp
		wget #{node['gcc']['gcc_url']}/gcc-#{node['gcc']['version']}#{node['gcc']['version_prefix']}/gcc-#{node['gcc']['version']}#{node['gcc']['version_prefix']}.tar.bz2 
		tar xjf gcc-#{node['gcc']['version']}#{node['gcc']['version_prefix']}.tar.bz2
		cd gcc-#{node['gcc']['version']}
		mkdir build
		cd build
		../configure --enable-languages=c,c++ --disable-multilib --with-gmp-include=#{node['gnu']['prefix']}/#{node['gnu']['include']} --with-gmp-lib=#{node['gnu']['prefix']}/#{node['gnu']['libdir']} --with-mpfr-include=#{node['gnu']['prefix']}/#{node['gnu']['include']} --with-mpfr-lib=#{node['gnu']['prefix']}/#{node['gnu']['libdir']} --with-mpc-include=#{node['gnu']['prefix']}/#{node['gnu']['include']} --with-mpc-lib=#{node['gnu']['prefix']}/#{node['gnu']['libdir']}
		make -j4
		make install
		ldconfig
		cd ..
	EOH
	not_if { File.exists?("#{node['gnu']['prefix']}/bin/gcc") }
end

