class ElectionController < ApplicationController

  def show
    if params[:year]
      @election = Election.find_by(year: params[:year])
    else
      @election = Election.find_by(year: Election.current_election_year)
    end
    unless @election.premier_id.nil?
      @premier = Candidate.find(@election.premier_id)
    end
    @districts = @election.districts
    @leaders = @election.leaders

  end



end
