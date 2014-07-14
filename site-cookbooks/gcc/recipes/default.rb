#
# Cookbook Name:: gcc
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
execute "gmp_#{node['gmp']['version']}" do
	command <<-EOH
		cd /tmp
		wget #{node['gmp']['gmp_url']}/gmp-#{node['gmp']['version']}#node['gmp']['version_prefix'].tar.bz2
		tar xjf gmp-#{node['gmp']['version']}#node['gmp']['version_prefix'].tar.bz2
		cd gmp-#{node['gmp']['version']}
		./configure --prefix=#{node['gnu']['prefix']} --libdir=#{node['gnu']['prefix']}/#{node['gnu']['libdir']}
		make -j4
		make check
		make install
		cd ..
	EOH
	not_if { File.exists?("#{node['gnu']['prefix']}/#{node['gnu']['libdir']}/libgmp.a") }
end

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
	not_if { File.exists?("#{node['gnu']['prefix']}/#{node['gnu']['libdir']}libmpfr.a") }
end

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

template "gnu-tools.conf" do
	path "/etc/ld.so.conf.d/gnu-tools.conf"
	source "gnu-tools.conf.erb"
	mode 0644
	owner "root"
	group "root"
end

execute "ldUpdate" do
	command "ldconfig"
	action :run
end

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

