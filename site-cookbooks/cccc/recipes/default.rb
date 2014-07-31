#
# Cookbook Name:: cccc
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
execute "cccc" do
  command <<-EOH
    cd #{Chef::Config[:file_cache_path]}
    wget #{node['cccc']['download_url']}/#{node['cccc']['version']}/cccc-#{node['cccc']['version']}.tar.gz
    tar xzf cccc-#{node['cccc']['version']}.tar.gz
    cd cccc-#{node['cccc']['version']}
    make
    make install
  EOH
  not_if { File.exists?("/usr/local/bin/cccc") }
end

