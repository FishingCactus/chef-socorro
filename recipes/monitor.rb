include_recipe "socorro::base"
include_recipe "socorro::cron"
include_recipe "socorro::postgresql"
include_recipe "socorro::hbase"

cookbook_file "/etc/supervisor/conf.d/3-socorro-monitor.conf" do
  source "supervisor/3-socorro-monitor.conf" 
  owner "root"
  group "root"
  mode "0644"
end

execute "Reload supervisorctl reload" do
  command "supervisorctl reload"
end