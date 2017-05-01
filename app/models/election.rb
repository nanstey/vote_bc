class Election < ApplicationRecord
  validates :year, presence: true, uniqueness: true
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

  def self.last_election_year
    2013
  end

  def party_stats
    ElectionParty.includes(:party).where(:election_id => self.id).order(:votes_total => :DESC)
  end
end
