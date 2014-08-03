#
# Cookbook Name:: redmine
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
include_recipe "devTools::default"

%w{openssl-devel readline-devel zlib-devel curl-devel libyaml-devel}.each do |pkg|
  package pkg do
    action :install
  end
end

include_recipe "mysql-server::default"
include_recipe "httpd::default"
include_recipe "ImageMagick::default"
include_recipe "ipa-pgothic-fonts"

template "create database user sql" do
  path "/home/#{node['mysql']['user']}/createDatabaseUserForRedmine.sql"
  source "createDatabaseUserForRedmine.sql.erb"
  owner node['mysql']['user']
  group node['mysql']['group']
  mode 0644
  not_if { File.exists?("/home/#{node['mysql']['user']}/createDatabaseUserForRedmine.sql") }
end

include_recipe "mysql-server::createDatabaseForRedmine"

bash "download redmine" do
  code <<-EOH
    cd #{Chef::Config[:file_cache_path]}
    wget http://www.redmine.org/releases/redmine-#{node['redmine']['version']}.tar.gz
  EOH
  not_if { File.exists?("#{Chef::Config[:file_cache_path]}/redmine-#{node['redmine']['version']}.tar.gz") }
end

bash "install redmine" do
  code <<-EOH
    cd #{Chef::Config[:file_cache_path]}
    tar xzf redmine-#{node['redmine']['version']}.tar.gz
    mv redmine-#{node['redmine']['version']} redmine
    mv redmine #{node['redmine']['install_dir']}
  EOH
  not_if { Dir.exists?("#{node['redmine']['install_dir']}") }
end

template "database.yml" do
  path "#{node['redmine']['install_dir']}/config/database.yml"
  source "database.yml.erb"
  owner node['redmine']['user']
  group node['redmine']['group']
  mode 0644
  not_if { File.exists?("#{node['redmine']['install_dir']}/config/database.yml") }
end

template "configuration.yml" do
  path "#{node['redmine']['install_dir']}/config/configuration.yml"
  source "configuration.yml.erb"
  owner node['redmine']['user']
  group node['redmine']['group']
  mode 0644
  not_if { File.exists?("#{node['redmine']['install_dir']}/config/configuration.yml") }
end

bash "create log file" do
  code <<-EOH
    touch #{node['redmine']['install_dir']}/log/development.log
    touch #{node['redmine']['install_dir']}/log/production.log
    chown #{node['redmine']['user']}:#{node['redmine']['group']} #{node['redmine']['install_dir']}/log/development.log
    chown #{node['redmine']['user']}:#{node['redmine']['group']} #{node['redmine']['install_dir']}/log/production.log
    chmod 0666 #{node['redmine']['install_dir']}/log/development.log
    chmod 0666 #{node['redmine']['install_dir']}/log/production.log
  EOH
  not_if { File.exists?("#{node['redmine']['install_dir']}/log/development.log") }
end


bash "install related gems" do
  code <<-EOH
    cd #{node['redmine']['install_dir']}
    /usr/local/bin/bundle install --without development test
  EOH
end

bash "create secret token" do
  code <<-EOH
    cd #{node['redmine']['install_dir']}
    /usr/local/bin/bundle exec /usr/local/bin/rake generate_secret_token
    RAILS_ENV=production /usr/local/bin/bundle exec /usr/local/bin/rake db:migrate
  EOH
end

execute "install passenger module" do
  command "/usr/local/bin/passenger-install-apache2-module < /bin/echo '1'"
  not_if 'find /usr/local/lib/ruby/gems -name mod_passenger.so | grep passenger'
end

execute "create passenger.conf" do
  command <<-EOH
    /usr/local/bin/passenger-install-apache2-module --snippet > /etc/httpd/conf.d/passenger.conf
  EOH
  not_if { File.exists?("/etc/httpd/conf.d/passenger.conf") }
end

#include_recipe "redmine_plugins::default"

execute "change owner of redmine" do
  command <<-EOH
    chown -R apache:apache #{node['redmine']['install_dir']}
    chmod 555 /home/#{node['redmine']['user']}
  EOH
end

template "httpd.conf" do
  path "/etc/httpd/conf/httpd.conf"
  source "httpd.conf.erb"
  owner "root"
  group "root"
  mode 0644
end

execute "restart httpd" do
  command "/etc/init.d/httpd restart"
end

