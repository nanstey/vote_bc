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
    @election_districts = ElectionDistrict.includes(:district, winner: [:party]).where(:election_id => @election.id).order('districts.name')
    @leaders = @election.leaders
  end

end
