class DistrictController < ApplicationController
  def index
    @districts = District.all
  end

  def show
    @district_name = params[:name]
    @district = District.where('lower(name) = ?', @district_name.downcase).first
  end
end
