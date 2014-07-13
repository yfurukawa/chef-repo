#
# Cookbook Name:: boost
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
bash "boost" do
	program = "boost_1_55_0"
	tarball = "#{program}.tar.bz2"
	user "root"
	code <<-EOH
		cd /tmp
		wget http://sourceforge.net/projects/boost/files/boost/1.55.0/#{tarball}
		tar xjf #{tarball}
		cd #{program}
		./bootstrap.sh
		./b2 install -j8 --prefix=/usr/local
		cd ..
	EOH
	not_if "/sbin/ldconfig -v | grep boost"
end

execute "ldconfig" do
	user "root"
	command "/sbin/ldconfig"
	action :nothing
end

