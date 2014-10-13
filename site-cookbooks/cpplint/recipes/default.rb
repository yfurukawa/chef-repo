#
# Cookbook Name:: cpplint
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

remote_file "#{Chef::Config[:file_cache_path]}/cpplint.py" do
  source "http://google-styleguide.googlecode.com/svn/trunk/cpplint/cpplint.py"
end

execute "patching cpplint for auto execution" do
  command <<-EOH
    cd #{Chef::Config[:file_chache_path]}
  EOH
end

