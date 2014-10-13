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

cookbook_file "#{Chef::Config[:file_cache_path]}/cpplintDir.py.patch" do
  source "cpplintDir.py.patch"
end
  
cookbook_file "#{Chef::Config[:file_cache_path]}/cpplint.py.patch" do
  source "cpplint.py.patch"
end
  
execute "patching cpplint for auto execution" do
  command <<-EOH
    cd "#{Chef::Config[:file_cache_path]}"
    patch -p0 -o cpplintDir.py < cpplintDir.py.patch
    patch -p0 < cpplint.py.patch
    mv cpplint.py /usr/local/bin
    mv cpplintDir.py /usr/local/bin
    chmod 0555 /usr/local/bin/cpplint*
  EOH
  not_if { File.exists?("/usr/local/bin/cpplintDir.py") }
end

