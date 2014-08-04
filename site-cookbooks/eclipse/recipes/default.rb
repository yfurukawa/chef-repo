#
# Cookbook Name:: eclipse
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
bash "eclipse" do
  user = "root"
  code <<-EOH
    cd #{Chef::Config[:file_cache_path]}
    mkdir #{node['eclipse']['eclipse_base']}
    wget #{node['eclipse']['eclipse_download_url']}/#{node['eclipse']['eclipse_base']}.tar.gz
    tar xzf #{node['eclipse']['eclipse_base']}.tar.gz
    mv -R eclipse/* #{node['eclipse']['eclipse_base']}
    code 'echo "export PATH=$PATH:#{node['eclipse']['eclipse_base']}" >> /etc/bashrc'
  EOH
  not_if { Dir.exists?("#{node['eclipse']['eclipse_base']}") }
end

bash "cdt" do
  user = "root"
  code <<-EOH
    mkdir #{Chef::Config[:file_cache_path]}/cdt
    cd #{Chef::Config[:file_cache_path]}/cdt
    wget #{node['eclipse']['cdt_download_url']}/cdt-master-#{node['eclipse']['cdt_version']}.zip
    unzip cdt-master-#{node['eclipse']['cdt_version']}
    cp -R plugins/* #{node['eclipse']['eclipse_home']}/plugins/
    cp -R features/* #{node['eclipse']['eclipse_home']}/features/
  EOH
  not_if{ File.exists?("#{node['eclipse']['eclipse_home']}/plugins/org.eclipse.cdt_#{node['eclipse']['cdt_version']}.*.jar") }
end

pleiadesTmpDir = "#{Chef::Config[:file_cache_path]}/pleiades"
bash "makeTmpDir" do
  user = "root"
  code "mkdir -p #{pleiadesTmpDir}"
end

pleiadesFile = "pleiades.zip"
cookbook_file "#{pleiadesTmpDir}/#{pleiadesFile}"do
  source "#{pleiadesFile}"
end

bash "pleiades" do
  code <<-EOH
    cd "#{pleiadesTmpDir}"
    unzip #{pleiadesFile}
    cp -R #{pleiadesTmpDir}/plugins/* #{node['eclipse']['eclipse_home']}/plugins/
    cp -R #{pleiadesTmpDir}/features/* #{node['eclipse']['eclipse_home']}/features/
    echo "-javaagent:#{node['eclipse']['eclipse_home']}/plugins/jp.sourceforge.mergedoc.pleiades/pleiades.jar" >> #{eclipseHome}/eclipse.ini
  EOH
  not_if{ File.exists?("#{node['eclipse']['eclipse_home']}/plugins/jp.sourceforge.mergedoc.pleiades") }
end

template "/usr/share/applications/eclipse.desktop" do
  source "eclipse.desktop.erb"
  variables( :installDirectory => "/usr/local/bin" )
  not_if { File.exists?("/usr/share/applications/eclipse.desktop") }
end

