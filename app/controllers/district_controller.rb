class DistrictController < ApplicationController
  def index
    @districts = District.all
  end

  def show
    @district = District.find_by name: params[:name]
  end
end
