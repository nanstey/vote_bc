class CandidateElectionDistrict < ApplicationRecord
  belongs_to :candidate
  belongs_to :election
  belongs_to :district
  validates_presence_of :votes_total, if: :previous_year
  validates_presence_of :votes_percent, if: :previous_year

  def previous_year
    Election.find(self.election_id).year < Election.current_election_year
  end
end
