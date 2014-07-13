#
# Cookbook Name:: ftp
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

%w{vsftpd ftp}.each do |p|
	package p do
		action :install
	end
end

# service vsftpd start
# chkconfig vsftpd on
service "vsftpd" do
	action [:start, :enable]
end

