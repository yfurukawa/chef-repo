#
# Cookbook Name:: cppcheck
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
execute "cppcheck" do
	program = "cppcheck-1.62"
	tarball = "#{program}.tar.bz2"
	command <<-EOH
		cd /tmp
		wget http://sourceforge.net/projects/cppcheck/files/cppcheck/1.62/#{tarball}
		tar xjf #{tarball}
		cd #{program}
		make
		make install
	EOH
	not_if { File.exists?("/usr/bin/cppcheck") }
end

