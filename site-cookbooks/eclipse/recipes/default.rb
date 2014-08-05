#
# Cookbook Name:: eclipse
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

directory "#{node['eclipse']['eclipse_base']}" do
  owner "root"
  group "root"
  mode 00755
  action :create
end

bash "eclipse" do
  user = "root"
  code <<-EOH
    cd #{Chef::Config[:file_cache_path]}
    wget #{node['eclipse']['eclipse_download_url']}/#{node['eclipse']['eclipse_base']}.tar.gz
    tar xzf #{node['eclipse']['eclipse_base']}.tar.gz
    mv -R eclipse/* #{node['eclipse']['eclipse_base']}
    code 'echo "export PATH=$PATH:#{node['eclipse']['eclipse_base']}" >> /etc/bashrc'
  EOH
  not_if { Dir.exists?("#{node['eclipse']['eclipse_base']}") }
end

directory "#{Chef::Config[:file_cache_path]}/cdt" do
  owner "root"
  group "root"
  mode 00755
  action :create
end

bash "cdt" do
  user = "root"
  code <<-EOH
    cd #{Chef::Config[:file_cache_path]}/cdt
    wget #{node['eclipse']['cdt_download_url']}/cdt-master-#{node['eclipse']['cdt_version']}.zip
    unzip cdt-master-#{node['eclipse']['cdt_version']}
    cp -R plugins/* #{node['eclipse']['eclipse_home']}/plugins/
    cp -R features/* #{node['eclipse']['eclipse_home']}/features/
  EOH
  not_if{ File.exists?("#{node['eclipse']['eclipse_home']}/plugins/org.eclipse.cdt_#{node['eclipse']['cdt_version']}.*.jar") }
end

directory "#{Chef::Config[:file_cache_path]}/pleiades" do
  owner "root"
  group "root"
  mode 00755
  action :create
end

cookbook_file "#{Chef::Config[:file_cache_path]}/pleiades/#{node['eclipse']['pleiadesFile']}"do
  source "#{node['eclipse']['pleiadesFile']}"
end

bash "pleiades" do
  code <<-EOH
    cd "#{Chef::Config[:file_cache_path]}/pleiades"
    unzip #{node['eclipse']['pleiadesFile']}
    cp -R #{Chef::Config[:file_cache_path]}/pleiades/plugins/* #{node['eclipse']['eclipse_home']}/plugins/
    cp -R #{Chef::Config[:file_cache_path]}/pleiades/features/* #{node['eclipse']['eclipse_home']}/features/
    echo "-javaagent:#{node['eclipse']['eclipse_home']}/plugins/jp.sourceforge.mergedoc.pleiades/pleiades.jar" >> #{node['eclipse']['eclipse_home']}/eclipse.ini
  EOH
  not_if{ File.exists?("#{node['eclipse']['eclipse_home']}/plugins/jp.sourceforge.mergedoc.pleiades") }
end

template "/usr/share/applications/eclipse.desktop" do
  source "eclipse.desktop.erb"
  variables( :installDirectory => "/usr/local/bin" )
  not_if { File.exists?("/usr/share/applications/eclipse.desktop") }
end

