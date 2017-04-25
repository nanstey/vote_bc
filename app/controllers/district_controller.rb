class DistrictController < ApplicationController
  def index
    @districts = District.all
  end

  def show
    @district = District.friendly.find(params[:name])

    # redirects home if incorrect district is inserted
    rescue ActiveRecord::RecordNotFound
      redirect_to(root_url, :notice => 'District not found')
  end

  def search
    if params[:address] && params[:address] != ""
      geolocation = District.get_geolocation(params[:address])
      if district = District.get_district(geolocation)
        redirect_to "/district/#{district.slug}"
      else
        redirect_to(root_url, :notice => 'District not found')
      end
    else
      redirect_to(root_url, :notice => 'Address not entered')
    end
  end

end
