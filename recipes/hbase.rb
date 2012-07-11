include_recipe "chef-socorro::base"

execute "Install Java" do
  command "/usr/bin/wget https://raw.github.com/flexiondotorg/oab-java6/master/oab-java.sh && bash oab-java.sh"
  creates '/etc/apt/sources.list.d/oab.list'
  user "root"
  cwd "/home/socorro"
  action :run
end

package "sun-java6-jdk" do
  action :install
end

cookbook_file "/etc/apt/sources.list.d/cloudera.list" do
  source "apt/cloudera.list" 
  owner "root"
  group "root"
  mode "0644"
end

execute "Add cloudera key" do
  command "/usr/bin/curl -s http://archive.cloudera.com/debian/archive.key | /usr/bin/sudo /usr/bin/apt-key add -"
  user "root"
  action :run
end

execute "Update cloudera repository" do
  command "/usr/bin/apt-get update && touch /tmp/apt-get-update-cloudera"
  creates "/tmp/apt-get-update-cloudera"
  user "root"
  action :run
end

directory "/var/lib/hbase" do
  owner "root"
  group "root"
  action :create
  recursive true
  mode "0777"
end

package "hadoop-hbase" do
  action :install
end

package "hadoop-hbase-master" do
  action :install
end

package "hadoop-hbase-thrift" do
  action :install
end

cookbook_file "/etc/hbase/conf/hbase-site.xml" do
  source "hbase/hbase-site.xml" 
  owner "root"
  group "root"
  mode "0644"
end

service "hadoop-hbase-master" do
  action :restart
end

service "hadoop-hbase-thrift" do
  action :restart
end

execute "Add tables to HBase" do
  command "/bin/cat /home/socorro/source/analysis/hbase_schema | sed \'s/LZO/NONE/g\' | /usr/bin/hbase shell"
  creates '/var/lib/hbase/crash_reports'
  action :run
end