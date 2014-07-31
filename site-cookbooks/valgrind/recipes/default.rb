#
# Cookbook Name:: valgrind
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

execute "valgrind" do
  program = "valgrind-3.9.0"
  tarball = "#{program}.tar.bz2"
  command <<-EOH
    cd #{Chef::Config[:file_cache_path]}
    wget http://valgrind.org/downloads/#{tarball}
    tar xjf #{tarball}
    cd #{program}
    ./configure
    make
    make install
  EOH
  not_if{ File.exists?("/usr/local/bin/valgrind") }
end

