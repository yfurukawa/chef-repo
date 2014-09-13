#
# Cookbook Name:: qt
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

remote_file "#{Chef::Config[:file_cache_path]}/qt-opensource-linux-x64-5.3.1.run" do
  source "#{node['qt']['download_url']}"
end

