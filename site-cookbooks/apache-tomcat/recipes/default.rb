#
# Cookbook Name:: apache-tomcat
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
bash "Apache Tomcat" do
  user="root"
  code <<-EOH
    cd #{node['tomcat']['tomcat_home']}
    wget #{node['tomcat']['download_url']}/#{node['tomcat']['tomcat_base']}.tar.gz
    tar xzf #{node['tomcat']['tomcat_base']}.tar.gz
  EOH
  not_if { Dir.exists?("#{node['tomcat']['tomcat_home']}/#{node['tomcat']['tomcat_base']}") }
end

cookbook_file "/etc/init.d/tomcat.sh" do
  source "tomcat.sh"
  mode 00755
  not_if { File.exists?( "/etc/init.d/tomcat.sh" ) }
end
