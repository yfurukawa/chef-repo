#
# Cookbook Name:: prepareFiles
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

git "#{Chef::Config[:file_cache_path]}/prepareFiles" do
 repository "https://github.com/yfurukawa/prepareFiles.git"
end

template "#{Chef::Config[:file_cache_path]}/prepareFiles/src/Makefile" do
  source "Makefile.erb"
  variables( :lib_dir => "-L/usr/lib64 -L/usr/local/lib64",
    :install_target_dir => "/usr/local/bin",
    :test_lib => "-lgtest -lpthread" )
end

execute "prepareFiles" do
 command <<-EOH
   cd #{Chef::Config[:file_cache_path]}/prepareFiles/src
   make
   make install
 EOH
 not_if { File.exists?("/usr/local/bin/prepareFiles") }
end

