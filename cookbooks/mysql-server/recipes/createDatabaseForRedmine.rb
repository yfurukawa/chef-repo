execute "create database for redmine" do
	command "mysql -u root -p#{node['mysql']['server_root_password']} -e 'CREATE DATABASE #{node['redmine']['database']} DEFAULT CHARACTER SET utf8;'"
	not_if "mysql -u root -p#{node['mysql']['server_root_password']} -e 'show databases;' | grep #{node['redmine']['database']}"
end

execute "create user" do
	command "mysql -u root -p#{node['mysql']['server_root_password']} < /home/#{node['mysql']['user']}/createDatabaseUserForRedmine.sql"
	user node['mysql']['user']
	group  node['mysql']['group']
	environment 'HOME' => "/home/#{node['mysql']['user']}"
	not_if "mysql -u root -p#{node['mysql']['server_root_password']} -e 'SELECT user FROM mysql.user;' | grep #{node['redmine']['user']}"
end

