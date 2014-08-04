#
# Cookbook Name:: gtest
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
execute "gtest" do
  command <<-EOH
    cd #{Chef::Config[:file_cache_path]}
    wget #{node['gtest']['download_url']}/gmock-#{node['gtest']['version']}.zip
    unzip gmock-#{node['gtest']['version']}.zip
    cd gmock-#{node['gtest']['version']}
    ./configure
    make
    cp -R include/gmock #{node['gtest']['include_dir']}
    mv gmock/lib/.libs/* #{node['gtest']['lib_dir']}
    cp -R gtest/include/gtest #{node['gtest']['include_dir']}
    mv gtest/lib/.libs/* #{node['gtest']['lib_dir']}
    ldconfig
  EOH
  not_if { Dir.exists?("#{node['gtest']['include_dir']}/gtest") }
end

