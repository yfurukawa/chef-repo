execute "download hudson" do
  cd #{Chef::Config[:file_cache_path]}
  wget "#{node['redmine_plugins']['hudson']['download_url']}"/redmine_hudson-#{node['redmine_plugins']['hudson']['version']}.zip
  not_if { File.exists?("#{Chef::Config[:file_cache_path]}/redmine_hudson-#{node['redmine_plugins']['hudson']['version']}.zip") && "#{node['redmine_plugins']['hudson']['need']}" }
end

execute "install backlogs plugin" do
  command <<-EOH
    cd #{Chef::Config[:file_cache_path]}
    unzip redmine_hudson-#{node['redmine_plugins']['hudson']['version']}.zip
    mkdir #{node['redmine']['install_dir']}/plugins/redmine_hudson
    cp -R redmine_hudson-#{node['redmine_plugins']['hudson']['version']}/* #{node['redmine']['install_dir']}/plugins/redmine_hudson
    cd #{node['redmine']['install_dir']}/plugins/redmine_hudson
    #{node['ruby']['install_dir']}/bin/bundle install --without development test
    cd #{node['redmine']['install_dir']}
    RAILS_ENV=production #{node['ruby']['install_dir']}/bin/rake redmine:plugins:migrate
  EOH
  not_if { "#{node['redmine_plugins']['hudson']['need']}" }
end

package "httpd" do
  action :restart
  not_if { "#{node['redmine_plugins']['hudson']['need']}" }
end