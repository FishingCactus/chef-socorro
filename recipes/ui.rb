include_recipe "socorro::web"

[ "memcached", "php", "php::module_pgsql", "php::module_curl", "php::module_memcache", "php::module_mysql", "php::module_ldap" ].each do |p|
  require_recipe p
end

[ "libcrypt-ssleay-perl", "php5-dev", "php5-tidy", "php-pear", "php5-common", "php5-cli", "php5-gd", "phpunit" ].each do |p|
  package p do
    action :install
  end
end

service "memcached" do
  action [ :enable, :start ]
end

cookbook_file "/etc/apache2/sites-available/crash-stats" do
  source "apache_hosts/crash-stats" 
  owner "root"
  group "root"
  mode "0644"
  notifies :restart, "service[apache2]"
end

directory "/var/log/socorro/kohana" do
  owner "root"
  group "root"
  mode "0755"
  action :create
end

cookbook_file "/etc/php.ini" do
  source "php/php.ini" 
  owner "root"
  group "root"
  mode "0644"
  notifies :restart, "service[apache2]"
end

directory "/data/socorro/htdocs/application/logs" do
  owner "root"
  group "root"
  mode "0777"
  action :create
end

execute "enable-crash-stats-vhost" do
  command "/usr/sbin/a2ensite crash-stats"
  creates "/etc/apache2/sites-enabled/crash-stats"
  user "root"
  action :run

  notifies :restart, "service[apache2]"
end

[ "rewrite", "php5", "proxy", "proxy_http", "ssl", "headers" ].each do |p|
  execute "enable-" + p + "-mod" do
    command "/usr/sbin/a2enmod " + p
    creates "/etc/apache2/mods-enabled/" + p + ".load"
    user "root"
    action :run

    notifies :restart, "service[apache2]"
  end
end