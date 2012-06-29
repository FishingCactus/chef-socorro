maintainer        "Fishing Cactus"
maintainer_email  "michael.delva@fishingcactus.com"
license           ""
description       "Installs and configures socorro servers"
long_description  IO.read(File.join(File.dirname(__FILE__), 'README'))
version           "1.0.0"

recipe "socorro", "Installs and configures a complete socorro server"
recipe "socorro::api", "Installs socorro API"
recipe "socorro::collector", "Installs socorro collector"
recipe "socorro::crashmover", "Installs socorro crash mover"
recipe "socorro::monitor", "Installs socorro monitor"
recipe "socorro::processor", "Installs socorro processor"
recipe "socorro::ui", "Installs socorro Web UI"

%w{ apt build-essential java git rsyslog subversion python ant cron memcached php apache2" }.each do |cb|
  depends cb
end

%w{ debian ubuntu }.each do |os|
  supports os
end