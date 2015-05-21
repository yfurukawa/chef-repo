#
# Cookbook Name:: openjdk
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
%w{java-1.8.0-openjdk java-1.8.0-openjdk-javadoc java-1.8.0-openjdk-devel}.each do |pkg|
  package pkg do
    action :install
  end
end

cookbook_file "/etc/init.d/jdk.sh" do
  source "jdk.sh"
  mode 00755
  not_if { File.exists?( "/etc/init.d/jdk.sh" ) }
end

