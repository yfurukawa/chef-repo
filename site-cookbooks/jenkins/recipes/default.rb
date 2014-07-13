#
# Cookbook Name:: jenkins
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

execute "jenkins_getRepo" do
	command "wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo"
	action :run
end

execute "jenkins_rpm" do
	command "rpm --import http://pkg.jenkins-ci.org/redhat/jenkins-ci.org.key"
	action :run
end

package "jenkins" do
	action :install
end

# service jenkins start
# chkconfig jenkins on
service "jenkins" do
	action [:start, :enable]
end

