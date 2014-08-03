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
    wget https://googlemock.googlecode.com/files/gmock-1.7.0.zip
    unzip gmock-1.7.0.zip
    cd gmock-1.7.0
    ./configure
    make
    cd include
    cp -R gmock /usr/local/include/
    cd ../lib/.libs
    mv * /usr/local/lib64
    cd ../../gtest/include
    cp -R gtest /usr/local/include/
    cd ../lib/.libs
    mv * /usr/local/lib64
    cd #{Chef::Config[:file_cache_path]}
    ldconfig
  EOH
  not_if { File.exists?("/usr/local/include/gtest") }
end

