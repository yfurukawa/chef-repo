git "#{node['redmine']['install_dir']}/plugins/redmine_backlogs" do
	repository "https://github.com/backlogs/redmine_backlogs.git"
	reference "master"
	action :checkout
	user "root"
	group "root"
	not_if { Dir.exists?("#{node['redmine']['install_dir']}/plugins/redmine_backlogs/.git") }
end

bash "install backlogs plugin" do
	code <<-EOH
		cd #{node['redmine']['install_dir']}/plugins/redmine_backlogs
		/home/#{node['ruby-env']['user']}/.rbenv/versions/#{node['ruby-env']['version']}/bin/bundle install --without development test
		cd #{node['redmine']['install_dir']}
		RAILS_ENV=production /home/#{node['ruby-env']['user']}/.rbenv/versions/#{node['ruby-env']['version']}/bin/bundle exec rake redmine:backlogs:install
	EOH
end

