#
# Cookbook Name:: gcc
# Recipe:: gmt
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
execute "gmp_#{node['gmp']['version']}" do
  command <<-EOH
    cd #{Chef::Config[:file_cache_path]}
    wget #{node['gmp']['gmp_url']}/gmp-#{node['gmp']['version']}#{node['gmp']['version_prefix']}.tar.bz2
    tar xjf gmp-#{node['gmp']['version']}#{node['gmp']['version_prefix']}.tar.bz2
    cd gmp-#{node['gmp']['version']}
    ./configure --prefix=#{node['gnu']['prefix']} --libdir=#{node['gnu']['prefix']}/#{node['gnu']['libdir']}
    make -j4
    make check
    make install
    cd ..
  EOH
  not_if { File.exists?("#{node['gnu']['prefix']}/#{node['gnu']['libdir']}/libgmp.a") }
end

