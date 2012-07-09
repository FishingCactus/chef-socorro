include_recipe "chef-socorro::web"

directory "/home/socorro/primaryCrashStore" do
  owner "www-data"
  group "socorro"
  action :create
  mode "2755"
end

directory "/home/socorro/fallback" do
  owner "www-data"
  group "socorro"
  action :create
  mode "2755"
end

cookbook_file "/etc/apache2/sites-available/crash-reports" do
  source "apache_hosts/crash-reports"
  owner "root"
  group "root"
  mode 0644
end

execute "enable-crash-reports-vhost" do
  command "/usr/sbin/a2ensite crash-reports"
  creates "/etc/apache2/sites-enabled/crash-reports"
  user "root"
  action :run

  notifies :restart, "service[apache2]"
end