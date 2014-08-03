#
# Cookbook Name:: graphviz
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

execute "prepare repo for graphviz" do
	command "wget -O #{node['graphviz']['repo']} #{node['graphviz']['download_repo']}"
	action :run
	not_if { File.exists?("#{node['graphviz']['repo']}" ) }
end

%w{graphviz graphviz-lang-ocaml graphviz-lang-perl graphviz-lang-php graphviz-lang-python graphviz-lang-ruby graphviz-lang-tcl graphviz-libs graphviz-plugins-core graphviz-plugins-gd graphviz-plugins-x graphviz-qt graphviz-x ann-libs compat-readline5 freeglut gd gdbm-devel gtkglext-libs gts guile libXaw libXpm libmng netpbm ocaml ocaml-runtime phonon-backend-gstreamer php-cli php-common qt qt-sqlite qt-x11 tcl tk}.each do |pkg|
	package pkg do
		action :install
	end
end

