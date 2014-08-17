#
# Cookbook Name:: valgrind
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

execute "valgrind" do
  command <<-EOH
    cd #{Chef::Config[:file_cache_path]}
    wget #{node['valgrind']['download_url']}/valgrind-#{node['valgrind']['version']}.tar.bz2
    tar xjf valgrind-#{node['valgrind']['version']}.tar.bz2
    cd valgrind-#{node['valgrind']['version']}
    ./configure --prefix=#{node['valgrind']['prefix']}
    make
    make install
  EOH
  not_if{ File.exists?("#{node['valgrind']['prefix']}/bin/valgrind") }
end

