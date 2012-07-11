include_recipe "chef-socorro::base"
include_recipe "chef-socorro::cron"
include_recipe "chef-socorro::postgresql"
include_recipe "chef-socorro::hbase"

cookbook_file "/etc/supervisor/conf.d/1-socorro-processor.conf" do
  source "supervisor/1-socorro-processor.conf" 
  owner "root"
  group "root"
  mode "0644"
end

execute "Reload supervisorctl reload" do
  command "supervisorctl reload"
end

directory "/home/socorro/temp" do
  owner "socorro"
  group "socorro"
  mode "0775"
  action :create
end

template "/home/socorro/source/scripts/config/processorconfig.py" do
  source "socorro/processorconfig.py.erb"
  mode "644"
end

Chef::Log.info( "Mount Symbols? : " + node[:socorro][:processor][:mount_symbols] ? " YES" : "NO" )
Chef::Log.info( "Mount Folder : " + node["socorro"]["processor"]["mount_folder"] )

if node['socorro']['processor']['mount_symbols']

  directory node["socorro"]["processor"]["mount_folder"] do
    action :create
    recursive true
  end

  package "nfs-common" do
    action :install
  end

  mount node["socorro"]["processor"]["mount_folder"] do
    device node["socorro"]["processor"]["mount_remote_server"]
    fstype node["socorro"]["processor"]["mount_type"]
    options node["socorro"]["processor"]["mount_options"]
    action [:mount, :enable]
  end

end