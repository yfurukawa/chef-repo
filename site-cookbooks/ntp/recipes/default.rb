#
# Cookbook Name:: ntp
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package "ntp" do
	action :install
end

template "/etc/ntp.conf" do
	source "ntp.conf.erb"
	variables( :ntp_server => "10.0.0.1" )
	notifies :restart, "service[ntpd]"
end

# service ntpd start
# chkconfig ntpd on
service "ntpd" do
	action [:start, :enable]
end

