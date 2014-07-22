#
# Cookbook Name:: gcc
# Recipe:: mpfr
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

execute "mpfr_#{node['mpfr']['version']}#{node['mpfr']['version_prefix']}" do
	command <<-EOH
		cd /tmp
		wget #{node['mpfr']['mpfr_url']}/mpfr-#{node['mpfr']['version']}#{node['mpfr']['version_prefix']}.tar.bz2
		tar xjf mpfr-#{node['mpfr']['version']}#{node['mpfr']['version_prefix']}.tar.bz2
		cd mpfr-#{node['mpfr']['version']}
		./configure --prefix=#{node['gnu']['prefix']} --libdir=#{node['gnu']['prefix']}/#{node['gnu']['libdir']} --with-gmp-include=#{node['gnu']['prefix']}/#{node['gnu']['include']} --with-gmp-lib=#{node['gnu']['prefix']}/#{node['gnu']['libdir']}
		make -j4
		make check
		make install
		cd ..
	EOH
	not_if { File.exists?("#{node['gnu']['prefix']}/#{node['gnu']['libdir']}/libmpfr.a") }
end
