class Election < ApplicationRecord
  has_many :election_districts
  has_many :candidate_election_districts
  has_many :districts, through: :election_districts
  has_many :candidates, through: :candidate_election_districts
  has_many :election_leaders
  has_many :leaders, through: :election_leaders
  has_many :parties, through: :leaders

  def self.current_election_year
    2017
  end
end
