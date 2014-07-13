#
# Cookbook Name:: eclipse
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
bash "eclipse" do
	program = "eclipse-standard-kepler-SR2-linux-gtk-x86_64"
	tarball = "#{program}.tar.gz"
	user = "root"
	code <<-EOH
		cd /tmp
		wget http://ftp.jaist.ac.jp/pub/eclipse/technology/epp/downloads/release/kepler/SR2/#{tarball}
		tar xzf #{tarball}
		cp -R eclipse/ /usr/local/bin/
		code 'echo "export PATH=$PATH:/usr/local/bin/eclipse" >> /etc/bashrc'
	EOH
	not_if { Dir.exists?("/usr/local/bin/eclipse") }
end

eclipseHome = "/usr/local/bin/eclipse"
bash "cdt" do
	program = "cdt-master-8.3.0"
	zipFile = "#{program}.zip"
	user = "root"
	code <<-EOH
		mkdir /tmp/cdt
		cd /tmp/cdt
		wget http://ftp.jaist.ac.jp/pub/eclipse/tools/cdt/releases/kepler/sr2/#{zipFile}
		unzip #{zipFile}
		cp -R plugins/* #{eclipseHome}/plugins/
		cp -R features/* #{eclipseHome}/features/
	EOH
	not_if{ File.exists?("#{eclipseHome}/plugins/org.eclipse.cdt_8.3.0.201402142303.jar") }
end

pleiadesTmpDir = "/tmp/pleiades"
bash "makeTmpDir" do
	user = "root"
	code "mkdir -p #{pleiadesTmpDir}"
end

pleiadesFile = "pleiades.zip"
cookbook_file "#{pleiadesTmpDir}/#{pleiadesFile}"do
	source "#{pleiadesFile}"
end

bash "pleiades" do
	code <<-EOH
		cd "#{pleiadesTmpDir}"
		unzip #{pleiadesFile}
		cp -R #{pleiadesTmpDir}/plugins/* #{eclipseHome}/plugins/
		cp -R #{pleiadesTmpDir}/features/* #{eclipseHome}/features/
		echo "-javaagent:#{eclipseHome}/plugins/jp.sourceforge.mergedoc.pleiades/pleiades.jar" >> #{eclipseHome}/eclipse.ini
	EOH
	not_if{ File.exists?("#{eclipseHome}/plugins/jp.sourceforge.mergedoc.pleiades") }
end

template "/usr/share/applications/eclipse.desktop" do
	source "eclipse.desktop.erb"
	variables( :installDirectory => "/usr/local/bin" )
	not_if { File.exists?("/usr/share/applications/eclipse.desktop") }
end

