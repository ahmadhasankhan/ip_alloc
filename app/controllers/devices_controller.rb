class DevicesController < ApplicationController

  def search
    File.open('data.txt') do |file|
      @device = {}
      file.each_line do |line|
        line.chomp!
        data = line.split(',')
        if data[1] == params[:ip]
          @device[:ip] = data[1]
          @device[:device] = data[2]
          break
        end
      end
    end

    unless @device.any?
      render json: {error: "NotFound", ip: "#{params[:ip]}"}, status: :not_found
    end
  end

  def assign
    @device = Device.new(device_params[:ip], device_params[:device])

    #This is not active record's save method
    @device.save
    render :assign, status: :created
  end

  private

  def device_params
    params.permit(:ip, :device)
  end
end
