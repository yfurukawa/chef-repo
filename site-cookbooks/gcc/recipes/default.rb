#
# Cookbook Name:: gcc
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

%w{glibc-devel.i686 libstdc++.i686}.each do |pkg|
  package pkg do
    action :install
  end
end

include_recipe "gcc::gmp"
include_recipe "gcc::mpfr"
include_recipe "gcc::mpc"
include_recipe "gcc::ldconf_update"
include_recipe "gcc::gcc"
