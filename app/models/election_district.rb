class ElectionDistrict < ApplicationRecord
  belongs_to :election
  belongs_to :district
  validates :election_id, presence: true
  validates :district_id, presence: true
  validates_presence_of :winner_id, if: :previous_year
  validates_presence_of :voters_registered, if: :previous_year
  validates_presence_of :total_votes, if: :previous_year
  validates_presence_of :ballots_rejected, if: :previous_year
  validates_presence_of :ballots_valid, if: :previous_year

  def previous_year
    Election.find(self.election_id).year < Election.current_election_year
  end
end
