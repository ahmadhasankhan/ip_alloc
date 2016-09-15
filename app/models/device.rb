class Device
  attr_accessor :ip, :device

  def initialize(ip, device)
    @ip = ip
    @device = device
  end

  def save
    self.ip
    self.device
  end


  private

  def self.validate_ip_address(ip)
    p ip
  end

  def self.validate_device_name(name)
    p name
  end

end