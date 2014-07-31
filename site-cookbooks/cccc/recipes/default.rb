#
# Cookbook Name:: cccc
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
execute "cccc" do
  program = "cccc-3.1.4"
  tarball = "#{program}.tar.gz"
  command <<-EOH
    cd #{Chef::Config[:file_cache_path]}
    wget http://sourceforge.net/projects/cccc/files/cccc/3.1.4/#{tarball}
    tar xzf #{tarball}
    cd #{program}
    make
    make install
  EOH
  not_if { File.exists?("/usr/local/bin/cccc") }
end

