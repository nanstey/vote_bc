class DistrictController < ApplicationController
  def index
    @districts = District.all
  end

  def show
    @district = District.friendly.find(params[:name])
    @district_info = @district.get_election_district_history
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
