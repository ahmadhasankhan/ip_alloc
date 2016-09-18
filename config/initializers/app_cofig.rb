require 'netaddr'
APP_CONFIG = YAML.load_file(Rails.root.join('config/config.yml'))[Rails.env]

#Read Data path from Environment variable
DATA_FILE_PATH = ENV["IPALLOC_DATAPATH"]

#Application will boot up if path is not set
if DATA_FILE_PATH.nil?
  raise "IPALLOC_DATAPATH is not set "
end

#Generate the IP range based on given IP block
IP_RANGE = NetAddr::CIDR.create(APP_CONFIG['ip_block'])
