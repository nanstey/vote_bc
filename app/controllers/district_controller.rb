class DistrictController < ApplicationController
  def index
    @districts = ElectionDistrict.includes(:district, winner: [:party])
    @years = Election.all
    render stream: true
  end

  def show
    req_district = District.friendly.find(params[:name])
    @district_history = req_district.get_election_district_history
    @district = @district_history[0][:district].district
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
          # flash[:error] = 'District not found'
          redirect_to(request.referer, flash = { notice: 'District not found' })
        end
      else
        # flash[:error] = 'Address not found'
        redirect_to(request.referer, flash = { notice: 'Address not found'})
      end
    else
      flash.now = { notice: 'Address not entered' }
      puts "++++++++++++++++++++++++"
      puts flash.inspect
      redirect_to(request.referer)
    end
  end

end
