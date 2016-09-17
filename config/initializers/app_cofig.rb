DATA_FILE_PATH = ENV["IPALLOC_DATAPATH"]

#Application will boot up if path is not set
if DATA_FILE_PATH.nil?
  raise "IPALLOC_DATAPATH is not set "
end
