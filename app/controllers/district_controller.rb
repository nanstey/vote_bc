class DistrictController < ApplicationController
  def index
    @districts = District.all

  end

  def show
    @district_name = params[:name]
    @district = District.where('lower(name) = ?', @district_name.downcase).first
    @boundary = District.get_boundary_points(@district.name)
  end

  def search
    geolocation = District.get_geolocation(params[:address])
    if district = District.get_district(geolocation)
      redirect_to "/district/#{district}"
    else
      redirect_to "/"
    end
  end
end
