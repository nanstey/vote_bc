class DistrictController < ApplicationController
  def index
    @districts = District.all

  end

  def show
    @district_name = params[:name]
    @district = District.where('lower(name) = ?', @district_name.downcase).first
  end

  def search
    geolocation = District.get_geolocation(params[:address])
    if District.get_boundary_info(geolocation)
      redirect_to "/district/#{District.get_boundary_info(geolocation)}"
    else
      redirect_to "/"
    end
  end
end
