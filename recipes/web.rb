include_recipe "chef-socorro::base"

require_recipe "apache2"
require_recipe "apache2::mod_php5"
require_recipe "apache2::mod_wsgi"
require_recipe "apache2::mod_rewrite"
require_recipe "apache2::mod_headers"
require_recipe "apache2::mod_ssl"
require_recipe "apache2::mod_proxy"

file "/etc/apache2/sites-enabled/000-default" do
  action :delete
end