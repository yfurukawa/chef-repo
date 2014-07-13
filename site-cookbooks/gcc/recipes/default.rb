#
# Cookbook Name:: gcc4.8.2
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
execute "gmp" do
	command <<-EOH
		cd /tmp
		wget https://ftp.gnu.org/gnu/gmp/gmp-6.0.0a.tar.bz2
		tar xjf gmp-6.0.0a.tar.bz2
		cd gmp-6.0.0
		./configure --prefix=/usr/local --libdir=/usr/local/lib64
		make -j4
		make check
		make install
		cd ..
	EOH
	not_if { File.exists?("/usr/local/lib64/libgmp.a") }
end

execute "mpfr" do
	command <<-EOH
		cd /tmp
		wget http://www.mpfr.org/mpfr-current/mpfr-3.1.2.tar.bz2
		tar xjf mpfr-3.1.2.tar.bz2
		cd mpfr-3.1.2
		./configure --prefix=/usr/local --libdir=/usr/local/lib64 --with-gmp-include=/usr/local/include --with-gmp-lib=/usr/local/lib64
		make -j4
		make check
		make install
		cd ..
	EOH
	not_if { File.exists?("/usr/local/lib64/libmpfr.a") }
end

execute "mpc" do
	command <<-EOH
		cd /tmp
		wget ftp://ftp.gnu.org/gnu/mpc/mpc-1.0.2.tar.gz
		tar xzf mpc-1.0.2.tar.gz
		cd mpc-1.0.2
		./configure --prefix=/usr/local --libdir=/usr/local/lib64 --with-gmp-include=/usr/local/include --with-gmp-lib=/usr/local/lib64 --with-mpfr-include=/usr/local/include --with-mpfr-lib=/usr/local/lib64
		make -j4
		make check
		make install
		cd ..
	EOH
	not_if { File.exists?("/usr/local/lib64/libmpc.a") }
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

execute "gcc4.8.2" do
	command <<-EOH
		cd /tmp
		wget http://ftp.gnu.org/gnu/gcc/gcc-4.8.2/gcc-4.8.2.tar.bz2 
		tar xjf gcc-4.8.2.tar.bz2
		cd gcc-4.8.2
		mkdir build
		cd build
		../configure --enable-languages=c,c++ --disable-multilib --with-gmp-include=/usr/local/include --with-gmp-lib=/usr/local/lib64 --with-mpfr-include=/usr/local/include --with-mpfr-lib=/usr/local/lib64 --with-mpc-include=/usr/local/include --with-mpc-lib=/usr/local/lib64
		make -j4
		make install
		ldconfig
		cd ..
	EOH
	not_if { File.exists?("/usr/local/bin/gcc") }
end

