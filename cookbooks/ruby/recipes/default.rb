#
# Cookbook Name:: ruby
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

%w{git openssl-devel}.each do |pkg|
	package pkg do
		action :install
	end
end

execute "Download ruby" do
	command <<-EOH
		cd #{Chef::Config[:file_cache_path]}
		wget #{node['ruby']['ruby_url']}/ruby-#{node['ruby']['version']}.tar.bz2
	EOH
	not_if { File.exists?( "#{Chef::Config[:file_cache_path]}/ruby-#{node['ruby']['version']}.tar.bz2" ) }
end

execute "Build ruby" do
	command <<-EOH
		cd #{Chef::Config[:file_cache_path]}
		tar xjf ruby-#{node['ruby']['version']}.tar.bz2
		cd ruby-#{node['ruby']['version']}
		./configure --prefix=#{node['ruby']['prefix']}
		make
		make install
	EOH
	not_if { File.exists?("#{node['ruby']['prefix']}/bin/ruby") }
end

%w{bundler passenger inifile}.each do |gem|
	gem_package gem do
		gem_binary "#{node['ruby']['prefix']}/bin/gem"
		action :install
	end
end

