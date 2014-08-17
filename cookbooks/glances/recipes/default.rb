#
# Cookbook Name:: glances
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "yum-epel::default"

package "glances" do
	action :install
end

