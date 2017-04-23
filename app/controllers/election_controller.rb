class ElectionController < ApplicationController

  def show
    if params[:year]
      @election = Election.find_by(year: params[:year])
    else
      @election = Election.find_by(year: 2017)
    end
    if @election.premier_id
      @premier = Candidate.find(@election.premier_id)
    end
    @districts = @election.districts
    @leaders = @election.leaders

  end



end
