#
# Cookbook Name:: gcc
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "gcc::gmp"
include_recipe "gcc::mpfr"
include_recipe "gcc::mpc"
include_recipe "gcc::ldconf_update"
include_recipe "gcc::gcc"
