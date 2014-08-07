git "#{node['redmine']['install_dir']}/plugins/redmine_backlogs" do
  repository "#{node['redmine_plugins']['backlogs']['repository_url']}"
  reference "master"
  action :checkout
  user "root"
  group "root"
  not_if { Dir.exists?("#{node['redmine']['install_dir']}/plugins/redmine_backlogs/.git") && "#{node['redmine_plugins']['backlogs']['need']}" }
end

bash "install backlogs plugin" do
  code <<-EOH
    cd #{node['redmine']['install_dir']}/plugins/redmine_backlogs
    #{node['ruby']['install_dir']}/bin/bundle install --without development test
    cd #{node['redmine']['install_dir']}
    RAILS_ENV=production #{node['ruby']['install_dir']}/bin/rake redmine:plugins:migrate
    RAILS_ENV=production #{node['ruby']['install_dir']}/bin/bundle exec #{node['ruby']['install_dir']}/bin/rake redmine:backlogs:install
  EOH
  not_if { "#{node['redmine_plugins']['backlogs']['need']}" }
end

