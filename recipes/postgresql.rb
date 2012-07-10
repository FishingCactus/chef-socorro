include_recipe "chef-socorro::base"

require_recipe "postgresql::server"

package "postgresql-plperl" do
  action :install
end

package "postgresql-contrib" do
  action :install
end

cookbook_file "#{node[:postgresql][:dir]}/postgresql.conf" do
  source "postgresql/postgresql.conf" 
  owner "postgres"
  group "postgres"
  mode "0644"

  notifies :restart, "service[postgresql]"
end

execute "Setup PostgreSQL database" do
  command "/home/socorro/source/socorro/external/postgresql/setupdb_app.py --database_name=breakpad"
  not_if "/usr/bin/psql --list breakpad"
  cwd '/home/socorro/source'
  environment ({'PYTHONPATH' => '/data/socorro/application:/data/socorro/thirdparty'})
  user "postgres"
  action :run
end

execute "Create PostgreSQL user" do
  command "/usr/bin/createuser -d -r -s socorro"
  only_if "/usr/bin/psql -xt breakpad -c \"SELECT * FROM pg_user WHERE usename = 'socorro'\" | grep \"(No rows)\""
  user "postgres"
  action :run
end

# execute "Import PostgreSQL data" do
#   command "/bin/bash /home/socorro/source/tools/dataload/import.sh"
#   cwd '/home/socorro/source/tools/dataload'
#   only_if "/usr/bin/psql -xt breakpad -c \"SELECT count(*) FROM products\" | grep \"count | 0\""
#   action :run
# end

service "postgresql" do
  action :enable
end