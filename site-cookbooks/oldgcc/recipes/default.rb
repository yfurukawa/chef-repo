#
# Cookbook Name:: oldgcc
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
node['gcc']['rpms'].each do |rpms|
  cookbook_file "/tmp/#{rpms['rpm_package_name']}" do
    source rpms['rpm_package_name']
  end
end

node['gcc']['rpms'].each do |rpms|
  package rpms['rpm_package_name'] do
    action :install
    provider Chef::Provider::Package::Rpm
    source "/tmp/#{rpms['rpm_package_name']}"
  end
end


