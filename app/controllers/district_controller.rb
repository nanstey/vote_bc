class DistrictController < ApplicationController
  def index
    @districts = District.all
    puts "================"
    url = "https://represent.opennorth.ca/boundaries/british-columbia-electoral-districts-2015-redistribution/abbotsford-south/"
    response = HTTP.get(url)
    extent = JSON.parse(response)
    puts extent['extent'][0]
    puts "================"
  end

  def show
    @district = District.friendly.find(params[:name])
  end

  def search
    if params[:address] && params[:address] != ""
      geolocation = District.get_geolocation(params[:address])
      if district = District.get_district(geolocation)
        redirect_to "/district/#{district.slug}"
      else
        redirect_to "/"
      end
    else
      redirect_to "/"
    end
  end

end
