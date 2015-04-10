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

