#
# Cookbook Name:: pmd
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

cookbook_file "/usr/local/lib/#{node['pmd']['pmd_file']}.zip" do
  source "#{node['pmd']['pmd_file']}.zip"
end

execute "install pmd" do
  command <<-EOH
    cd /usr/local/lib
    unzip #{node['pmd']['pmd_file']}.zip
    mv #{node['pmd']['pmd_file']} pmd
  EOH
  not_if{ Dir.exists?("/usr/local/lib/pmd") }
end

cookbook_file "/usr/local/bin/cpd.sh" do
  source "cpd.sh"
  mode 0555
end

