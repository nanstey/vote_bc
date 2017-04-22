class ElectionController < ApplicationController

  def show
    @election = Election.find_by(year: params[:year])
    if @election.premier_id
      @premier = Candidate.find(@election.premier_id)
    end
    @districts = @election.districts
    @leaders = @election.leaders

  end



end
