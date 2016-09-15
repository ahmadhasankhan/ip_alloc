class DevicesController < ApplicationController

  def search
    @device = Device.find_by_ip(params[:ip])
    unless @device
      render json: {error: "NotFound", ip: "#{params[:ip]}"}, status: :not_found
    end
  end

  def assign
    @device = Device.new(device_params[:ip], device_params[:device])
    begin
      #This is not active record's save method
      @device.save
      render :assign, status: :created
    rescue => e
      logger.error("Could not persist the data : #{e.message}")
      render json: {error: "#{e.message}", ip: "#{params[:ip]}"}, status: :bad_request
    end
  end

  private
  def device_params
    params.permit(:ip, :device)
  end
end
