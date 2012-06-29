# SOCORRO
default["socorro"]["git"]["repository"] = "https://github.com/mozilla/socorro"
default["socorro"]["git"]["branch"] = "master"

# SOCORRO PROCESSOR
default["socorro"]["processor"]["mount_symbols"] = true
default["socorro"]["processor"]["mount_folder"] = "/mnt/socorro/symbols"
default["socorro"]["processor"]["mount_remote_server"] = "server:/symbols"
default["socorro"]["processor"]["mount_type"] = "nfs"
default["socorro"]["processor"]["mount_options"] = "rw"
default["socorro"]["processor"]["processor_symbols_pathlist"] = "/mnt/socorro/symbols" #'comma or space separated list of symbol files for minidump_stackwalk (quote paths with embedded spaces)'

# POSTGRESQL
default["socorro"]["postgresql"]["host"] = "localhost"
default["socorro"]["postgresql"]["port"] = "5432"
default["socorro"]["postgresql"]["database"] = "breakpad"
default["socorro"]["postgresql"]["user"] = "breakpad_rw"
default["socorro"]["postgresql"]["password"] = "aPassword"

#STATSD
default["socorro"]["statsd"]["host"] = "localhost"
default["socorro"]["statsd"]["port"] = "8125"

#HBASE
default["socorro"]["hbase"]["host"] = "localhost"
default["socorro"]["hbase"]["port"] = "9090"
default["socorro"]["hbase"]["timeout"] = "5000"

default["socorro"]["hbase"]["secondary_host"] = "localhost"
default["socorro"]["hbase"]["secondary_port"] = "9090"
default["socorro"]["hbase"]["secondary_timeout"] = "5000"