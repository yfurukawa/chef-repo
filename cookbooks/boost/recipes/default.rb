#
# Cookbook Name:: boost
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
bash "boost" do
  user "root"
  code <<-EOH
    cd #{Chef::Config[:file_cache_path]}
    wget #{node['boost']['download_url']}/#{node['boost']['version']}/#{node['boost']['program_name']}.tar.bz2
    tar xjf #{node['boost']['program_name']}.tar.bz2
    cd #{node['boost']['program_name']}
    ./bootstrap.sh
    ./b2 install -j4 --prefix=/usr/local
    cd ..
  EOH
  not_if { File.exists?("/usr/local/include/boost/lexical_cast.hpp") }
end

execute "ldconfig" do
  user "root"
  command "/sbin/ldconfig"
  action :nothing
end

