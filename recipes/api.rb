include_recipe "socorro::web"

cookbook_file "/etc/apache2/sites-available/socorro-api" do
  source "apache_hosts/socorro-api" 
  owner "root"
  group "root"
  mode "0644"
  notifies :restart, "service[apache2]"
end

directory "/var/run/wsgi" do
  owner "root"
  group "root"
  action :create
end

execute "enable-socorro-api-vhost" do
  command "/usr/sbin/a2ensite socorro-api"
  creates "/etc/apache2/sites-enabled/socorro-api"
  user "root"
  action :run

  notifies :restart, "service[apache2]"
end
