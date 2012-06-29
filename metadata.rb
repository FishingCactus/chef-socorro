maintainer        "Fishing Cactus"
maintainer_email  "michael.delva@fishingcactus.com"
license           ""
description       "Installs and configures socorro servers"
long_description  IO.read(File.join(File.dirname(__FILE__), 'README'))
version           "1.0.0"

recipe "socorro", "Installs and configures a complete socorro server"
recipe "haproxy::app_lb", "Installs and configures haproxy by searching for nodes of a particular role"

%w{ debian ubuntu }.each do |os|
  supports os
end