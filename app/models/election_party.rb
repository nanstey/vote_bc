class ElectionParty < ApplicationRecord
  belongs_to :election
  belongs_to :party
  validates :election_id, presence: true
  validates :party_id, presence: true

  validates_presence_of :candidates_running, if: :previous_year
  validates_presence_of :seats_won, if: :previous_year
  validates_presence_of :votes_total, if: :previous_year
  validates_presence_of :votes_percent, if: :previous_year

  def previous_year
    Election.find(self.election_id).year < Election.current_election_year
  end
end
