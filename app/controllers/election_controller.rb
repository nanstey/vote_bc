class ElectionController < ApplicationController

  def show
    if params[:year]
      @election = Election.find_by(year: params[:year])
    else
      @election = Election.current_election
    end
    @election_districts = ElectionDistrict.includes(:district, winner: [:party]).where(:election_id => @election.id).order('districts.name')
    @leaders = @election.leaders
    @party_stats = @election.party_stats
  end

end
