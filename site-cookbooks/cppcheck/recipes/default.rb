#
# Cookbook Name:: cppcheck
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
execute "cppcheck" do
  command <<-EOH
    cd #{Chef::Config[:file_cache_path]}
    wget #{node['cppcheck']['download_url']}/#{node['cppcheck']['version']}/cppcheck-#{node['cppcheck']['version']}.tar.bz2
    tar xjf cppcheck-#{node['cppcheck']['version']}.tar.bz2
    cd cppcheck-#{node['cppcheck']['version']}
    make
    make install
  EOH
  not_if { File.exists?("/usr/bin/cppcheck") }
end

