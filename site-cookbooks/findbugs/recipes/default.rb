#
# Cookbook Name:: findbugs
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
#
# Cookbook Name:: apache-tomcat
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
bash "fingbugs" do
  user="root"
  code <<-EOH
    cd #{node['findbugs']['findbugs_home']}
    wget #{node['findbugs']['download_url']}/#{node['findbugs']['findbugs_base']}.tar.gz
    tar xzf #{node['findbugs']['findbugs_base']}.tar.gz
    echo "export PATH=$PATH:#{node['findbugs']['findbugs_home']}/bin" >> /etc/bashrc
  EOH
  not_if { Dir.exists?("#{node['findbugs']['findbugs_home']}/#{node['findbugs']['findbugs_base']}") }
end

