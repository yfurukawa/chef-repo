#
# Cookbook Name:: inkscape
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

execute "Prepare rpm setting for inkscape" do
	command <<-EOH
		wget #{node['inkscape']['download_url']}/rpmforge-release-#{node['inkscape']['version']}.el6.rf.#{node[:kernel][:machine]}.rpm
		rpm --import #{node['inkscape']['rpm_key_url']}/RPM-GPG-KEY.dag.txt
		rpm -K rpmforge-release-#{node['inkscape']['version']}.el6.rf.#{node[:kernel][:machine]}.rpm
		rpm -i rpmforge-release-#{node['inkscape']['version']}.el6.rf.#{node[:kernel][:machine]}.rpm
	EOH
end

package "inkscape" do
	action :install
end

