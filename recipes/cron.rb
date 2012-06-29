include_recipe "socorro::base"

require_recipe "cron"

cookbook_file "/etc/cron.d/socorro" do
  source "cron/socorro" 
  owner "root"
  group "root"
  mode "0644"
end

link "/etc/socorro/socorrorc" do
  to "/data/socorro/application/scripts/crons/socorrorc"
end