#
# Cookbook Name:: ghostscript
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

%w{ghostscript ghostscript-devel ghostscript-fonts baekmuk-ttf-fonts-ghostscript cjkuni-fonts-ghostscript evince gnuplot}.each do |pkg|
	package pkg do
		action :install
	end
end

