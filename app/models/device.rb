class Device
  attr_accessor :ip, :device

  def initialize(ip, device)
    @ip = ip
    @device = device
  end

  def save
    raise "Invalid IPv4" unless Device.valid_v4?(self.ip)
    raise "Invalid Device Name" unless Device.validate_device_name(self.device)
    raise "The given IP is already in use" unless Device.is_ip_available?(self.ip)
    raise "Could not persist data" unless Device.persist_data(self.ip, self.device)
  end

  def self.find_by_ip(ip)
    file_name = DATA_FILE_PATH
    if file_name
      File.open(file_name) do |file|
        file.each_line do |line|
          line.chomp!
          data = line.split(',')
          if data[1] == ip
            return {:ip => data[1], :device => data[2]}
          end
        end
      end
    else
      raise "File path not available : #{file_name}"
    end
    nil
  end

  private
  def self.validate_device_name(name)
    /^[a-zA-Z0-9]+$/ =~ name
  end

  def self.is_ip_available?(ip)
    file_name = DATA_FILE_PATH
    File.open(file_name) do |file|
      file.each_line do |line|
        line.chomp!
        data = line.split(',')
        if data[1] == ip
          return false
        end
      end
    end
    true
  end

  def self.valid_v4?(addr)
    unless IP_RANGE
      raise "Something went wrong with IP_RANGE : #{IP_RANGE}"
    end

    IP_RANGE.contains?(addr)
  end

  def self.persist_data(ip, name)
    #Reading ip_block from config
    ip_block = APP_CONFIG['ip_block']
    status = false
    begin
      file = File.open(DATA_FILE_PATH, "a+") { |f| f.puts("#{ip_block},#{ip},#{name}") }
      status = true
    ensure
      file.close if file
    end
    status
  end
end