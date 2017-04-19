class DistrictController < ApplicationController
  def index
    @districts = District.all
  end

  def show
  end
end
