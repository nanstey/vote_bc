class ElectionController < ApplicationController

  def show
    @election = Election.find_by(year: params[:year])
    @districts = @election.districts
  end
end
