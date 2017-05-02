class DistrictController < ApplicationController
  def index
    @districts = ElectionDistrict.includes(:district, winner: [:party])
    @years = Election.all
    render stream: true
  end

  def show
    @district = District.friendly.find(params[:name])
    @district_history = @district.get_election_district_history
    # redirects home if incorrect district is inserted
    rescue ActiveRecord::RecordNotFound
      redirect_to(root_url, :notice => 'District not found')
  end

  def search
    if params[:address] && params[:address] != ""
      if geolocation = District.get_geolocation(params[:address])
        if district = District.get_district(geolocation)
          redirect_to "/district/#{district.slug}"
        else
          redirect_to(request.referer, :notice => 'District not found')
        end
      else
        redirect_to(request.referer, :notice => 'Address not found')
      end
    else
      redirect_to(request.referer, :notice => 'Address not entered')
    end
  end

end
